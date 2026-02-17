{
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true; # Allow Pipewire to use realtime scheduler for increased performance
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
