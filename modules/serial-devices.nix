{
  # Add the `user` user to the dialout group that controls access
  # to serial devices
  users.users.user = {
    extraGroups = [
      "dialout" # to talk to serial devices
    ];
  };
}
