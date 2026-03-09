{
  config,
  home-manager,
  ...
}: {
  home-manager.users.user = {
    home.file = {
      "Downloads" = {
        source = config.lib.file.mkOutOfStoreSymlink "/home/user/zpools/data/x/Downloads";
      };
    };
  };
}
