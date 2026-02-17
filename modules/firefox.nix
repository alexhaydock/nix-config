{
  pkgs,
  home-manager,
  ...
}: {
  users.users.user = {
    # Install Firefox theme(s) but also any Firefox derivatives here
    packages = with pkgs; [
      firefox-gnome-theme # GTK4-native theme for Firefox
      mullvad-browser
      tor-browser
    ];
  };
  home-manager.users.user = {pkgs, ...}: {
    # Link firefox-gnome-theme into Firefox profile dir
    home.file.".mozilla/firefox/9kg8ag9n.default-release/chrome/firefox-gnome-theme".source = "${pkgs.firefox-gnome-theme}/share/firefox-gnome-theme";

    # Configure Firefox
    programs.firefox = {
      enable = true;

      # Adapted from:
      # https://github.com/corbindavenport/just-the-browser/blob/f163aa91ea766de23954e6173d351fdf18531d54/firefox/policies.json
      policies = {
        DisableFirefoxStudies = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        FirefoxHome = {
          SponsoredStories = false;
          SponsoredTopSites = false;
          Stories = false;
        };
        GenerativeAI = {
          Enabled = false;
        };
        SearchEngines = {
          Remove = [
            "Perplexity"
          ];
        };
      };

      # Configure profile
      profiles.default = {
        id = 0;
        name = "default-release";
        path = "9kg8ag9n.default-release";
        isDefault = true;
        userChrome = ''
          @import "firefox-gnome-theme/userChrome.css";
        '';
        userContent = ''
          @import "firefox-gnome-theme/userContent.css";
        '';
        settings = {
          "browser.startup.homepage" = "about:blank";
          # Settings below copied from firefox-gnome-theme's example `user.js`
          # https://github.com/rafaelmardojai/firefox-gnome-theme/blob/f7ffd917ac0d253dbd6a3bf3da06888f57c69f92/configuration/user.js
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.uidensity" = 0;
          "svg.context-properties.content.enabled" = true;
          "browser.theme.dark-private-windows" = false;
          "widget.gtk.rounded-bottom-corners.enabled" = true;
        };
      };
    };
  };
}
