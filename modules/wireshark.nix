{pkgs, ...}: {
  users.users.user = {
    extraGroups = [
      "wireshark" # rootless pcaps
    ];
  };

  programs = {
    wireshark = {
      enable = true;
      package = pkgs.wireshark; # Otherwise we get wireshark-cli by default
    };
  };
}
