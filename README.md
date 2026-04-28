# nix-config

## Deployment

### Pre-requisites
* Install NixOS from ISO
* Create admin user called `user` during installation
* Encrypt boot disk as required

### Copy and commit hardware config into repo
Copy the `/etc/nixos/hardware-configuration.nix` that the installer has automatically generated into an entry for the system inside `hosts/` in this repo.

### Move the local NixOS config
```sh
sudo mv -fv /etc/nixos ~/nixos-conf-old
```

### Run a rebuild based on the remote flake
> [!WARNING]
> Ensure you use the right hostname during this step and the hostname has support wired up in both `flake.nix` and in the `hosts/` directory in this repo.

```sh
sudo nixos-rebuild boot --flake github:alexhaydock/nix-config#desktop
```

### Reboot into the working system
```sh
sudo systemctl reboot
```

### Future upgrades:
```sh
sudo nixos-rebuild switch --flake github:alexhaydock/nix-config ; nvd diff /run/booted-system /run/current-system
```
