{
  pkgsUnstable,
  home-manager,
  ...
}: {
  home-manager.users.user = {pkgs, ...}: {
    programs.beets = {
      enable = true;
      package =
        # Import newer Beets package due to Nix refusing to evaluate
        # Beets 2.5.1 because of CVE-2026-42052
        pkgsUnstable.beets;
      settings = {
        directory = "/home/user/zpools/data/media/music/navidrome/beets-managed";
        import = {
          copy = true; # Copy files rather than moving them
          write = true;
        };
      };
    };
  };
}
