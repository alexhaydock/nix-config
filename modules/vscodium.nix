{home-manager, ...}: {
  home-manager.users.user = {pkgs, ...}: {
    programs.vscodium = {
      enable = true;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        bierner.markdown-mermaid
        jnoortheen.nix-ide
        redhat.vscode-yaml
        yzhang.markdown-all-in-one
      ];
    };
  };
}
