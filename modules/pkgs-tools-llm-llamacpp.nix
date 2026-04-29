# Retired: I attempted to swap Ollama out for this but the performance was drastically
#          worse using llama.cpp and it caused system hangs
{
  pkgs,
  lib,
  pkgsUnstable,
  ...
}: {
  services.llama-swap = {
    enable = true;
    port = 11111;
    settings = let
      llama-cpp = pkgsUnstable.llama-cpp.override {
        rocmSupport = true;
      };
      llama-server = lib.getExe' llama-cpp "llama-server";
    in {
      healthCheckTimeout = 60;
      # `-ngl 999` = Offload as many (999) layers of the model to the GPU as llama.cpp can fit
      models = {
        "gemma-4-31b" = {
          cmd = "${llama-server} --port \${PORT} -m /var/lib/llama-cpp/models/gemma-4-31b-Q4_K_M.gguf -ngl 999 --no-webui";
        };
      };
    };
  };

  # Lower the priority of the service to avoid
  # harming system responsiveness
  systemd.services.llama-swap = {
    serviceConfig = {
      IOSchedulingPriority = 7; # Set disk IO priority to the lowest available value
      Nice = 19; # Be quite willing to yield to other processes for CPU time
    };
  };
}
