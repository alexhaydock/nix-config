{pkgs, ...}: {
  users.users.user = {
    packages = with pkgs; [
      curl
      dig
      file # provides `file`
      hyfetch
      nyancat
      optipng
      pciutils # lspci
      psmisc # provides fuser, killall, pstree, etc
      socat
      usbutils # lsusb
      wget
    ];
  };
}
