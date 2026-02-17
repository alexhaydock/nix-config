{
  config,
  pkgs,
  nixpkgs,
  home-manager,
  ...
}: {
  networking.hostName = "framework";

  imports = [
    ./hardware-configuration.nix
    (import "${home-manager}/nixos")

    ../../modules/avahi.nix
    ../../modules/beets.nix
    ../../modules/bluetooth-default-disable.nix
    ../../modules/cup-of-tea.nix
    ../../modules/firefox.nix
    ../../modules/fwupd.nix
    ../../modules/generic.nix
    ../../modules/git.nix
    ../../modules/gnome.nix
    ../../modules/home-manager.nix
    ../../modules/networkmanager-clat.nix
    ../../modules/ntp-janet.nix
    ../../modules/nushell.nix
    ../../modules/pipewire.nix
    ../../modules/pkgs-dev-workstation.nix
    ../../modules/podman.nix
    ../../modules/qemu.nix
    ../../modules/serial-devices.nix
    ../../modules/ssh-server.nix
    ../../modules/sshfs-media.nix
    ../../modules/tor.nix
    ../../modules/unfree-allow.nix
    ../../modules/vscodium.nix
    ../../modules/wireshark.nix
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
