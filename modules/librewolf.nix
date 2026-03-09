{
  config,
  lib,
  home-manager,
  ...
}: let
  cfg = config.my.librewolf;
in {
  options.my.librewolf.trrUri = lib.mkOption {
    type = lib.types.str;
    default = "https://base.dns.mullvad.net/dns-query";
    description = "LibreWolf DoH resolver URL";
  };
  config = {
    home-manager.users.user = {pkgs, ...}: {
      programs.librewolf = {
        enable = true;
        settings = {
          "browser.startup.page" = 3; # Open previous windows and tabs on startup
          "network.cookie.lifetimePolicy" = 0;
          "network.trr.mode" = 3; # Strict DoH - we always want this so we actually get ECH
          "network.trr.uri" = cfg.trrUri;
          "privacy.clearOnShutdown_v2.cache" = false; # Setting the two clearOnShutdown options here is the equivalent of unticking "Delete cookies and site data when LibreWolf is closed"
          "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
          "privacy.resistFingerprinting" = false; # Depressingly having this on breaks CSS-based dark mode ; ;
          "signon.firefoxRelay.feature" = "disabled"; # Disable "Suggest Firefox Relay email masks to protect your email address"
          "signon.generation.enabled" = false; # Disable "Suggest strong passwords"
          "signon.management.page.breach-alerts.enabled" = false; # Disable "Show alerts about passwords for breached websites"
          "signon.rememberSignons" = true; # Enable inbuilt password manager
        };
      };
    };
  };
}
