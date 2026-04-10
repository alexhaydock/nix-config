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
    # ollama-rocm doesn't work on the Framework's
    # Radeon 840M even with ROCm support enabled at a system level with
    # NixOS.
    #
    # ollama-vulkan does work but seems unstable.
    package = unstable.ollama-vulkan;
    # Listen on all interfaces rather than 127.0.0.1
    host = "[::]";
  };
}
