{
  # Configure NTP to use Janet NTP servers
  # https://community.jisc.ac.uk/library/janet-services-documentation/network-time-service
  networking.timeServers = [
    "ntp0.ja.net" # South East
    "ntp4.ja.net" # South
    "ntp5.ja.net" # South East
    "ntp6.ja.net" # South
  ];
}
