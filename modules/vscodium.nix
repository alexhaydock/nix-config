{home-manager, ...}: {
  home-manager.users.user = {pkgs, ...}: {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium; # Use VSCodium rather than VSCode
      profiles.default.extensions = with pkgs.vscode-extensions; [
        bierner.markdown-mermaid
        redhat.vscode-yaml
        yzhang.markdown-all-in-one
        jnoortheen.nix-ide
      ];
    };
  };
}
