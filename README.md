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
nixos-rebuild boot --ask-sudo-password --flake github:alexhaydock/nix-config#desktop
```

### Reboot into the working system
```sh
sudo systemctl reboot
```

### Future upgrades:
After the initial reboot, the hostname no longer needs to be specified when rebuilding.

Now we can rebuild and switch into our system and use `nvd diff` to see the difference between the original system we booted and the new derivation (useful to work out if we have upgraded certain packages that might require a reboot):

```sh
nixos-rebuild switch --ask-sudo-password --flake github:alexhaydock/nix-config ; nvd diff /run/booted-system /run/current-system
```
