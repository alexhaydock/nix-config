{
  pkgs,
  nixpkgs-unstable,
  ...
}: let
  unstable = import nixpkgs-unstable {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };
in {
  users.users.user.packages = with pkgs; [
    passt
    qemu
    unstable.OVMFFull
    unstable.quickemu
  ];
}
