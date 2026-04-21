{pkgs, ...}: {
  users.users.user = {
    packages = with pkgs; [
      curl
      dig
      dmidecode
      file # provides `file`
      hyfetch
      nvd # Nix version diff tool: `nvd diff /run/booted-system /run/current-system`
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
