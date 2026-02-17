{
  # Disable Bluetooth by default (writes /etc/bluetooth/main.conf)
  hardware.bluetooth = {
    enable = true;
    settings = {
      Policy = {
        AutoEnable = false;
      };
    };
  };
}
