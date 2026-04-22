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
    # Use the ROCm version for better performance on 9070 XT
    package = unstable.ollama-rocm;

    # Listen on all interfaces rather than 127.0.0.1
    host = "[::]";

    # Declare env vars for the systemd service
    environmentVariables = {
      OLLAMA_KEEP_ALIVE = "-1"; # Keep models loaded indefinitely to prevent SSD grinding
      OLLAMA_MAX_LOADED_MODELS = "1";
      ROCR_VISIBLE_DEVICES = "GPU-58d041af24d7c0b6"; # Limit only to 9070 XT based on uuid from `rocminfo`
    };

    # Declaratively load a model list
    loadModels = ["gemma4:31b"];
  };

  # Lower the priority of the Ollama service to avoid
  # harming system responsiveness
  systemd.services.ollama = {
    serviceConfig = {
      IOSchedulingPriority = 7; # Set disk IO priority to the lowest available value
      Nice = 19; # Be quite willing to yield to other processes for CPU time
    };
  };
}
