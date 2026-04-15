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
    #
    # Use ROCm to get the most out of AMD GPU
    package = unstable.ollama-rocm;
    host = "[::]"; # Listen on all interfaces rather than 127.0.0.1
    environmentVariables = {
      OLLAMA_KEEP_ALIVE = "-1"; # Keep models loaded indefinitely to prevent SSD grinding
    };
  };
}
