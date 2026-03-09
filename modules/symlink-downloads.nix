{
  config,
  home-manager,
  ...
}: {
  home-mmanager.users.user = {
    home.file = {
      "Downloads" = {
        source = config.lib.file.mkOutOfStoreSymlink "/home/user/zpools/data/x/Downloads";
      };
    };
  };
}
