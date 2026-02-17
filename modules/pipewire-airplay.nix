{
  services.pipewire = {
    # Enable RAOP (aka AirPlay) support for PipeWire
    raopOpenFirewall = true; # UDP 6001-6002
    extraConfig.pipewire = {
      "10-airplay" = {
        "context.modules" = [
          {
            name = "libpipewire-module-raop-discover";
            # increase the buffer size if you get dropouts/glitches
            # args = {
            #   "raop.latency.ms" = 500;
            # };
          }
        ];
      };
    };
  };
}
