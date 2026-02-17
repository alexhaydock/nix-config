{home-manager, ...}: {
  home-manager.users.user = {pkgs, ...}: {
    # Mount fileserver
    # Note that this config needs to follow the capitalisation and naming
    # scheme used by systemd units
    systemd.user.mounts = {
      home-user-zpools-data-media = {
        Unit = {
          Description = "Mount NAS via SSHFS";
          Wants = "network-online.target";
          After = "network-online.target";
        };
        Mount = {
          What = "media.infected.systems:/zpools/data/media";
          Where = "/home/user/zpools/data/media";
          Type = "fuse.sshfs";
          Options = "_netdev,reconnect,ServerAliveInterval=5,ServerAliveCountMax=3,idmap=user,x-systemd.automount";
          TimeoutSec = "60";
        };
        Install = {
          WantedBy = ["default.target"];
        };
      };
    };
  };
}
