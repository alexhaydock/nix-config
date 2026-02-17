{
  pkgs,
  home-manager,
  ...
}: {
  users.users.user = {
    shell = pkgs.nushell; # Set nushell as the default shell (depends on programs.nushell being enabled in home-manager config)
  };

  home-manager.users.user = {pkgs, ...}: {
    programs.nushell = {
      enable = true;
    };

    # Enable Carapace (autosuggestion) support
    programs.carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    # Enable Starship prompt
    programs.starship = {
      enable = true;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };
  };
}
