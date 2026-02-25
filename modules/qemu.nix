{
  pkgs,
  nixpkgs-unstable,
  ...
}: let
  unstable = import nixpkgs-unstable {
    system = pkgs.system;
  };
in {
  users.users.user.packages = with pkgs; [
    passt
    qemu
    unstable.OVMFFull
    unstable.quickemu
  ];
}
