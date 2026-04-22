{pkgs, ...}: {
  # Enable ROCm support for system packages
  # https://wiki.nixos.org/wiki/AMD_GPU#Enabling_ROCm_&_HIP_For_Packages
  nixpkgs.config.rocmSupport = true;

  # Install `rocminfo` for getting info about GPUs
  users.users.user.packages = with pkgs; [
    rocmPackages.rocminfo
  ];
}
