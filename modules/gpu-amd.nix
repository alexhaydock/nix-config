# General module for systems with AMD GPUs
{pkgs, ...}: {
  users.users.user.packages = with pkgs; [
    nvtopPackages.amd
  ];
}
