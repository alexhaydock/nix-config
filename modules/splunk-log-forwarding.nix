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
    #
    # Note the use of '' before the $ variable in the sourcetype
    # field is a Nix-ism and does not end up in the final
    # syslog-ng config.
    #
    # Also note that the .journald.* prefix added to keys is the
    # default used by syslog-ng and this is stripped by the rekey
    # magic we've got going on in the event field.
    extraConfig = ''
      @version: 3.38

      source s_journald {
        systemd-journal();
      };

      destination d_splunk_hec_event {
        splunk-hec-event(
          url("https://splunk.infected.systems:8088")
          token("deadbeef-dead-beef-dead-beefdeadbeef")
          index("linux")
          sourcetype("''${.journald._TRANSPORT}")
          event("$(format_json --key .journald.* --rekey .journald.* --shift 10)\n")
        );
      };

      log {
        source(s_journald);
        destination(d_splunk_hec_event);
      };
    '';
  };
}
