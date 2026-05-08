{
  # Lock kernel modules after the system has booted.
  #
  # Helps reduce the attack surface against vulnerability classes like
  # CopyFail and DirtyFrag.
  #
  # WARNING! All needed modules must be loaded at boot by adding them
  #          to `boot.kernelModules` in the relevant `hardware-configuration.nix`.
  #
  #          See README.md for a bash one-liner to generate a formatted list of
  #          running modules on a system before enabling this feature.
  #
  security.lockKernelModules = true;
}
