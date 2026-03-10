# I couldn't get mkOutOfStoreSymlink to work properly so here we slightly
# abuse the systemd tmpfile generator to generate the symlink we need
{
  home-manager,
  ...
}: {
  home-manager.users.user = {
    systemd.user.tmpfiles.rules = [
      "L /home/user/Downloads - - - - /home/user/zpools/data/x/Downloads"
    ];
  };
}
