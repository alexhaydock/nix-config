{pkgs, ...}: {
  users.users.user.packages = with pkgs; [
    rocmPackages.rocminfo # Install `rocminfo` for getting info about ROCm support
  ];
}
