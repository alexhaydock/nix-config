{
  config,
  home-manager,
  ...
}: {
  home.file."Downloads".source = config.lib.file.mkOutOfStoreSymlink "/home/user/zpools/data/x/Downloads";
}
