{pkgs, ...}: {
  users.users.user = {
    packages = with pkgs; [
      bitwarden-desktop
      chromium
      easytag # GUI based audio file tagger
      element-desktop
      feishin # Navidrome client
      gimp
      keepassxc
      libreoffice
      obsidian
      rpi-imager
      signal-desktop
    ];
  };
}
