{pkgs, ...}: {
  users.users.user = {
    packages = with pkgs; [
      tor-browser
    ];
  };
}
