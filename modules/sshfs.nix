{pkgs, ...}: {
  # Install sshfs as a system package rather than with home-manager
  # otherwise systemd user units that depend on it seem unable to
  # find the sshfs binary when started during system boot
  environment.systemPackages = with pkgs; [
    sshfs
  ];
}
