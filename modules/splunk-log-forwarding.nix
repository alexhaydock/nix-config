{
  # Ensure journald is forwarding to syslog
  services.journald.forwardToSyslog = true;

  # Enable syslog-ng and forward to Splunk
  services.syslog-ng = {
    enable = true;

    # Wire up journald to the native Splunk HEC output
    #
    # Based primarily on a combination of the examples from
    # the following pages:
    # - https://syslog-ng.github.io/admin-guide/060_Sources/190_systemd-journal/README.html
    # - https://syslog-ng.github.io/admin-guide/070_Destinations/260_Splunk/000_Splunk-hec-event.html
    extraConfig = ''
      @version: 3.38

      source s_journald {
        systemd-journal(prefix("journald."));
      };

      destination d_splunk_hec_event {
        splunk-hec-event(
          url("https://splunk.infected.systems:8088")
          token("deadbeef-dead-beef-dead-beefdeadbeef")
          index("linux")
          event("$(format_json --scope rfc5424 --key journald.*)\n")
        );
      };

      log {
        source(s_journald);
        destination(d_splunk_hec_event);
      };
    '';
  };
}
