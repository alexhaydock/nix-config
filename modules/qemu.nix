{
  pkgs,
  nixpkgs-unstable,
  ...
}: let
  unstable = import nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
  };
in {
  users.users.user.packages = with pkgs; [
    passt
    unstable.quickemu
  ];

  # Enable libvirtd
  virtualisation.libvirtd = {
    enable = true;
    onShutdown = "shutdown"; # Shut down VMs when the host shuts down, rather than suspending
    qemu.swtpm.enable = true;
    qemu.package = pkgs.qemu_kvm; # Install QEMU only for native architecture for minimalism
  };

  # Allow unprivileged access to libvirtd
  users.users.user = {
    extraGroups = [
      "libvirtd"
    ];
  };
}
