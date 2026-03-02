{
  pkgs,
  nixpkgs-unstable,
  ...
}: let
  unstable = import nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
  };
in {
  users.users.user.packages = with pkgs; [
    passt
    qemu
    unstable.OVMFFull
    unstable.quickemu
  ];
}
