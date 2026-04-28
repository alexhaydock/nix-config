{
  # Enable automatic updates from GitHub-hosted Flake
  # https://mynixos.com/options/system.autoUpgrade
  system.autoUpgrade = {
    enable = true;
    flake = "github:alexhaydock/nix-config"; # Upgrade directly from GitHub
    flags = [
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
    persistent = true; # Run on resume if we would have run while the system was off/asleep
    runGarbageCollection = true;
  };
}
