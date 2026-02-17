{
  pkgs,
  nixpkgs,
  ...
}: {
  # Enable some experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Periodically optimise Nix store and remove
  # generations older than 30 days
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use the stable kernel branch rather than the LTS branch
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Use NetworkManager
  networking.networkmanager.enable = true;

  # Use nftables instead of iptables as the firewall
  networking.nftables.enable = true;

  # TODO: Can we remove this?
  services.xserver.enable = true;
  services.xserver.excludePackages = [pkgs.xterm]; # we don't want the graphical xterm package as we have Ptyxis

  # Disable CUPS
  services.printing.enable = false;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout" # to talk to serial devices
    ];
  };
}
