{
  pkgs,
  nixpkgs-unstable,
  ...
}: let
  unstable = import nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
  };
in {
  services.ollama = {
    enable = true;
    # Pull in Ollama from Nixpkgs Unstable since it seems like we need a
    # newer version to pull in some of the newer models
    package = unstable.ollama-rocm; # Use ROCm variant for AMD systems
  };
}
