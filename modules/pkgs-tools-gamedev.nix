{pkgs, ...}: {
  users.users.user = {
    packages = with pkgs; [
      godot
    ];
  };
}
