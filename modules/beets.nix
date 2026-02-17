{home-manager, ...}: {
  home-manager.users.user = {pkgs, ...}: {
    programs.beets = {
      enable = true;
      settings = {
        directory = "/home/user/zpools/data/media/music/navidrome/beets-managed";
        import = {
          write = true;
          move = true;
        };
      };
    };
  };
}
