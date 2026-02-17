{home-manager, ...}: {
  # Add home-manager config
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  # Manage `root` account with home-manager
  home-manager.users.root = {pkgs, ...}: {
    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "25.11";
  };

  # Manage `user` account with home-manager
  home-manager.users.user = {pkgs, ...}: {
    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "25.11";
  };
}
