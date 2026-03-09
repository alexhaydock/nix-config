{home-manager, ...}: {
  # Configure GNOME using home-manager's dconf module
  home-manager.users.user = {pkgs, ...}: {
    dconf.settings = {
      "org/gnome/desktop/background" = {
        color-shading-type = "solid";
        picture-options = "zoom";
        picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/progress-l.jxl";
        picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/progress-d.jxl";
        primary-color = "#967864";
        secondary-color = "#000000";
      };
      "org/gnome/desktop/screensaver" = {
        color-shading-type = "solid";
        picture-options = "zoom";
        picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/progress-l.jxl";
        picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/progress-d.jxl";
        primary-color = "#967864";
        secondary-color = "#000000";
      };
      "org/gnome/desktop/interface" = {
        accent-color = "teal";
        color-scheme = "prefer-dark";
        clock-format = "12h";
        clock-show-weekday = true;
        show-battery-percentage = true;
        text-scaling-factor = 1.25;
      };
      "org/gnome/desktop/notifications" = {
        show-in-lock-screen = false;
      };
      "org/gnome/desktop/privacy" = {
        remember-recent-files = false;
        remove-old-temp-files = true;
        remove-old-trash-files = true;
        report-technical-problems = false;
      };
      "org/gnome/nautilus/icon-view" = {
        default-zoom-level = "extra-large";
      };
      "org/gnome/nautilus/preferences" = {
        recursive-search = "always";
        show-image-thumbnails = "always";
      };
      "org/gnome/settings-daemon/plugins/power" = {
        # We are a VM. Do not automatically sleep.
        sleep-inactive-ac-type = "nothing";
        sleep-inactive-ac-timeout = 0;
      };
      "org/gnome/system/location" = {
        enabled = false;
      };
      "org/gnome/TextEditor" = {
        restore-session = false;
      };
      "org/gnome/gnome-system-monitor" = {
        graph-update-interval = 3000;
        network-in-bits = true;
        resources-memory-in-iec = true;
        show-whose-processes = "all";
      };
    };
  };
}
