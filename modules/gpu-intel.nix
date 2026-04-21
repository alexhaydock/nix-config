# General module for systems with Intel GPUs
{pkgs, ...}: {
  users.users.user.packages = with pkgs; [
    nvtopPackages.intel
  ];
}
