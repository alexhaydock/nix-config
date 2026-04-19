{pkgs, ...}: {
  # This module can be adapted where there's a need to pin the
  # kernel to a specific version
  boot.kernelPackages = pkgs.linuxPackages_6_19;
}
