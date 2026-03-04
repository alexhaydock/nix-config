{
  # Enable PC/SC (SmartCard API) daemon, which is
  # useful to us to talk to Yubikeys at system
  # level, to do things like using age-plugin-yubikey
  services.pcscd.enable = true;
}
