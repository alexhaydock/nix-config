{home-manager, ...}: {
  home-manager.users.user = {pkgs, ...}: {
    # Mount fileserver
    # Note that this config needs to follow the capitalisation and naming
    # scheme used by systemd units
    systemd.user.mounts = {
      home-user-zpools = {
        Unit = {
          Description = "Mount Media via SSHFS";
          Wants = "network-online.target";
          After = "network-online.target";
        };
        Mount = {
          What = "media.infected.systems:/zpools";
          Where = "/home/user/zpools";
          Type = "fuse.sshfs";
          Options = "_netdev,reconnect,ServerAliveInterval=5,ServerAliveCountMax=3,idmap=user,IdentityFile=/home/user/.ssh/id_ed25519_Primary,x-systemd.automount";
          TimeoutSec = "60";
        };
        Install = {
          WantedBy = ["default.target"];
        };
      };
    };
  };
}
