# This file configures package exceptions for
# instances where the Nix system will refuse to
# allow a nixpkgs-rebuild to evaluate without
# explicitly allowing the package.
{
  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];
}
