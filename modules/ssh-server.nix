{
  users.users.user = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDg/3otuTjnvlDfL0JdezCpBiM4G41gt+K+HuYT79ObD ed25519-Primary"
    ];
  };
  services = {
    openssh = {
      enable = true;
      settings = {
        # Here we enable only key-based auth
        # See the users section to configure per-user authorized keys
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}
