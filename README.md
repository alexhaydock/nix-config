# nix-config

## Deployment

### Pre-requisites
* Install NixOS from ISO
* Create admin user called `user` during installation
* Encrypt boot disk as required

### Copy SSH keys
Copy my SSH keys from backup into `~/.ssh`

### Enable Git temporarily
```sh
nix-shell -p git
```

### Clone repo
```sh
git clone git@github.com:alexhaydock/nix-config.git ~/nix-config
```

### Copy hardware-configuration.nix into repo
Copies the `hardware-configuration.nix` generated automatically by the installer into the repo ready for use:
```sh
cp -fv /etc/nixos/hardware-configuration.nix ~/nix-config/hosts/framework/hardware-configuration.nix
```

### Copy repo over system level Nix config
```sh
sudo rsync -avsh --delete ~/nix-config/ /etc/nixos/
```

### Update NixOS config using specific target hostname
Using `nixos-rebuild boot` means we can build the config and set it as the boot default without switching into it immediately:
```sh
sudo nixos-rebuild boot --flake /etc/nixos#framework
```

### Reboot
```sh
sudo systemctl reboot
```

