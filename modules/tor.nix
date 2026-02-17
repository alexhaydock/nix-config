{pkgs, ...}: {
  users.users.user = {
    packages = with pkgs; [
      oniux # Modern version of `torsocks`
    ];
  };
  services.tor = {
    enable = true;
    client = {
      enable = true; # Enable SOCKS listener on default port (9050)
      dns.enable = true; # Enable DNS listener on default port (9053)
    };
  };
}
