{
  config,
  pkgs,
  nixpkgs,
  nixpkgs-unstable,
  home-manager,
  ...
}: {
  networking.hostName = "framework";

  imports = [
    ./hardware-configuration.nix
    (import "${home-manager}/nixos")

    ../../modules/auditd.nix
    ../../modules/avahi.nix
    ../../modules/beets.nix
    ../../modules/bluetooth-default-disable.nix
    ../../modules/cup-of-tea.nix
    ../../modules/cups-disable.nix
    ../../modules/fwupd.nix
    ../../modules/generic.nix
    ../../modules/git.nix
    ../../modules/gnome-settings-physical.nix
    ../../modules/gnome.nix
    ../../modules/home-manager.nix
    ../../modules/kernel-stable.nix
    ../../modules/librewolf.nix
    ../../modules/networkmanager-clat.nix
    ../../modules/nix-optimise.nix
    ../../modules/ntp-janet.nix
    ../../modules/nushell.nix
    ../../modules/pipewire.nix
    ../../modules/pkgs-desktop.nix
    ../../modules/pkgs-tools-dev.nix
    ../../modules/pkgs-tools-general.nix
    ../../modules/pkgs-tools-media.nix
    ../../modules/podman.nix
    ../../modules/qemu.nix
    ../../modules/serial-devices.nix
    # ../../modules/splunk-log-forwarding.nix # Temp disabled to save license
    ../../modules/ssh-server.nix
    ../../modules/sshfs-media.nix
    ../../modules/sshfs.nix
    ../../modules/tor-browser.nix
    ../../modules/tor.nix
    ../../modules/unfree-allow.nix
    ../../modules/vscodium.nix
    ../../modules/wireshark.nix
    ../../modules/yubikey.nix
  ];

  # Custom config for my modules below this line
  my.librewolf.trrUri = "https://dns.infected.systems/dns-query"; # Use DoH resolver on local LAN

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
