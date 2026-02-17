{pkgs, ...}: {
  users.users.user = {
    packages = with pkgs; [
      passt
      qemu
      quickemu
    ];
  };
}
