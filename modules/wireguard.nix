{pkgs, ...}: {
  users.users.user.packages = with pkgs; [
    wireguard-tools # Includes `wg` and `wg-quick`
  ];
}
