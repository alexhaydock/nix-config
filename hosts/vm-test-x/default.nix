{
  config,
  pkgs,
  nixpkgs,
  nixpkgs-unstable,
  home-manager,
  ...
}: {
  networking.hostName = "x";

  imports = [
    ./hardware-configuration.nix
    (import "${home-manager}/nixos")

    ../../modules/bootloader.nix
    ../../modules/cup-of-tea.nix
    ../../modules/cups-disable.nix
    ../../modules/flatpak.nix
    ../../modules/gnome-settings-vm.nix
    ../../modules/gnome.nix
    ../../modules/home-manager.nix
    ../../modules/kernel-stable.nix
    ../../modules/librewolf.nix
    ../../modules/nftables.nix
    ../../modules/nix-features.nix
    ../../modules/nix-optimise.nix
    ../../modules/ntp-janet.nix
    ../../modules/pipewire.nix
    ../../modules/pkgs-tools-general.nix
    ../../modules/pkgs-tools-llm-webui.nix
    ../../modules/pkgs-tools-media.nix
    ../../modules/sshfs-vm-share.nix
    ../../modules/sshfs.nix
    ../../modules/symlink-downloads.nix
    ../../modules/tor-browser.nix
    ../../modules/unfree-allow.nix
    ../../modules/users-user.nix
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
