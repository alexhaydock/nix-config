{
  # NixOS defaults to installing the latest LTS kernel, so
  # switching to the LTS branch is as simple as not importing
  # this module for the host
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
