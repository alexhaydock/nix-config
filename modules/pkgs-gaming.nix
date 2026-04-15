{
  # https://wiki.nixos.org/wiki/GameMode
  programs.gamemode.enable = true;

  # https://wiki.nixos.org/wiki/Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open Steam Remote Play ports in the firewall
  };
}
