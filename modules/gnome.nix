{pkgs, ...}: {
  # Enable GNOME
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Slim down GNOME a bit by removing some packages
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [
    gnome-console
    decibels # default audio player
    geary
    gnome-music
    gnome-tour
    showtime # default video player
    yelp # help viewer
  ];

  # Add Nautilus "Open in Terminal" shortcut
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "ptyxis";
  };

  # Install GNOME Extensions as user packages
  users.users.user.packages = with pkgs; [
    gnomeExtensions.caffeine
    ptyxis # and a fancy Terminal
  ];
}
