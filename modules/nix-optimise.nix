{
  # Periodically optimise Nix store
  nix.optimise.automatic = true;

  # Optimise store during every build
  nix.settings.auto-optimise-store = true;

  # Periodically remove generations older than 30 days
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 30d";
  };
}
