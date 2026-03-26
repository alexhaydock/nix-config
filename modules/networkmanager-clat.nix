{
  config,
  pkgs,
  nixpkgs-unstable,
  ...
}:
# Import nixpkgs-unstable
# (we don't use it yet since we're still building from source as the
# nixpkgs release doesn't seem to have the CLAT working)
let
  unstable = import nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
  };
in {
  # Horrible hack to create a dispatcher to enable CLAT every time a connection
  # comes up since networkmanager.settings doesn't seem to accept settings that
  # only exist in the upstream dev branch
  #
  # Since this fires on `up` it probably only starts working after a disconnect
  # and reconnect rather than immediately
  networking.networkmanager.dispatcherScripts = [
    {
      source = pkgs.writeText "upHook" ''
        if [ "$2" = "up" ]; then
          conn="$(${config.networking.networkmanager.package}/bin/nmcli -t -f NAME,DEVICE connection show | grep $1 | cut -d: -f1)"
          ${config.networking.networkmanager.package}/bin/nmcli connection modify "$conn" ipv4.clat auto
          ${config.networking.networkmanager.package}/bin/nmcli connection modify "$conn" ipv4.dhcp-ipv6-only-preferred yes
        fi
      '';
      type = "basic";
    }
  ];

  # We need this to make nmcli available to the dispatcher scripts when they actually run
  # otherwise the scripts can't find the nmcli binary and error out
  systemd.services.NetworkManager-dispatcher = {
    enable = true;
    path = [
      "${config.networking.networkmanager.package}/bin"
    ];
  };

  # Enable NetworkManager
  networking.networkmanager.enable = true;

  # Override NetworkManager with the latest commit from the Git HEAD
  #
  # I originally went with the commit which merged the original CLAT PR but there's
  # been a bunch of improvements merged since
  networking.networkmanager.package = pkgs.networkmanager.overrideAttrs (oldAttrs: let
    src = pkgs.fetchFromGitLab {
      domain = "gitlab.freedesktop.org";
      owner = "NetworkManager";
      repo = "NetworkManager";
      rev = "5580b982ac916ac0f878bcd606801ce7c82aee68";
      hash = "sha256-UElqzm3Rz+FcMdXRne0wDzsvv5djt72uFwfVMpZwzBA=";
    };

    # Patched version of the nixpkgs upstream fix-paths.patch for the udev rules
    # and some other files
    #
    # I removed a hunk from this that would no longer apply on the latest Git HEAD
    # so hopefully it wasn't needed lol
    nixosPathPatch = pkgs.writeText "fix-paths.patch" ''
      diff --git a/data/84-nm-drivers.rules b/data/84-nm-drivers.rules
      index 148acade5c..6395fbfbe5 100644
      --- a/data/84-nm-drivers.rules
      +++ b/data/84-nm-drivers.rules
      @@ -7,6 +7,6 @@ ACTION!="add|change|move", GOTO="nm_drivers_end"
       # Determine ID_NET_DRIVER if there's no ID_NET_DRIVER or DRIVERS (old udev?)
       ENV{ID_NET_DRIVER}=="?*", GOTO="nm_drivers_end"
       DRIVERS=="?*", GOTO="nm_drivers_end"
      -PROGRAM="/bin/sh -c '/usr/sbin/ethtool -i $$1 |/usr/bin/sed -n s/^driver:\ //p' -- $env{INTERFACE}", ENV{ID_NET_DRIVER}="%c"
      +PROGRAM="@runtimeShell@ -c '@ethtool@/bin/ethtool -i $$1 |@gnused@/bin/sed -n s/^driver:\ //p' -- $env{INTERFACE}", ENV{ID_NET_DRIVER}="%c"

       LABEL="nm_drivers_end"
      diff --git a/src/libnmc-base/nm-vpn-helpers.c b/src/libnmc-base/nm-vpn-helpers.c
      index cbe76f5f1c..6ec684f9fe 100644
      --- a/src/libnmc-base/nm-vpn-helpers.c
      +++ b/src/libnmc-base/nm-vpn-helpers.c
      @@ -284,15 +284,6 @@ nm_vpn_openconnect_authenticate_helper(NMSettingVpn *s_vpn, GPtrArray *secrets,
           const char *const   *iter;
           const char          *path;
           const char          *opt;
      -    const char *const    DEFAULT_PATHS[] = {
      -        "/sbin/",
      -        "/usr/sbin/",
      -        "/usr/local/sbin/",
      -        "/bin/",
      -        "/usr/bin/",
      -        "/usr/local/bin/",
      -        NULL,
      -    };
           const char *oc_argv[(12 + 2 * G_N_ELEMENTS(oc_property_args))];
           const char *gw;
           int         port;
      @@ -311,13 +302,8 @@ nm_vpn_openconnect_authenticate_helper(NMSettingVpn *s_vpn, GPtrArray *secrets,

           port = extract_url_port(gw);

      -    path = nm_utils_file_search_in_paths("openconnect",
      -                                         "/usr/sbin/openconnect",
      -                                         DEFAULT_PATHS,
      -                                         G_FILE_TEST_IS_EXECUTABLE,
      -                                         NULL,
      -                                         NULL,
      -                                         error);
      +    path = g_find_program_in_path("openconnect");
      +
           if (!path)
               return FALSE;
    '';
    nixosInstallPathPatch = pkgs.writeText "fix-install-paths.patch" ''
      diff --git a/meson.build b/meson.build
      index 61c025b9d7..d2ae60da34 100644
      --- a/meson.build
      +++ b/meson.build
      @@ -1025,9 +1025,9 @@ meson.add_install_script(
         join_paths('tools', 'meson-post-install.sh'),
         nm_datadir,
         nm_bindir,
      -  nm_pkgconfdir,
      +  nm_prefix + nm_pkgconfdir,
         nm_pkglibdir,
      -  nm_pkgstatedir,
      +  nm_prefix + nm_pkgstatedir,
         nm_mandir,
         nm_sysconfdir,
         enable_docs ? '1' : '0',
    '';
  in {
    name = "networkmanager";
    inherit src;

    # Apply our patch, ensuring that some packages are available in the context
    # while we do it so their paths can be injected into the patch
    patches = [
      (pkgs.replaceVars nixosPathPatch {
        runtimeShell = pkgs.stdenv.shell;
        ethtool = pkgs.ethtool;
        gnused = pkgs.gnused;
      })
      nixosInstallPathPatch
    ];

    # We need to patch the shebangs in that one script for Nix compatibility,
    # and also patch the meson.build for the bpf based CLAT to tell it where
    # to find our Linux Headers and some glibc header stuff
    postPatch = ''
      patchShebangs tools/create-exports-NetworkManager.sh
      sed -i "s|bpf_clang_flags = \[|bpf_clang_flags = ['-I${pkgs.linuxHeaders}/include', '-I${pkgs.glibc.dev}/include',|" src/core/bpf/meson.build
    '';

    # Import some new packages we need to build the CLAT that aren't
    # already in the upstream default.nix - mostly this is clang stuff
    # to build the bpf code for the CLAT
    nativeBuildInputs =
      oldAttrs.nativeBuildInputs
      ++ [
        pkgs.bpftools
        pkgs.clang.cc
        pkgs.cmake
        pkgs.libbpf
        pkgs.linuxHeaders
        pkgs.ethtool
        pkgs.gnused
      ];
  });
}
