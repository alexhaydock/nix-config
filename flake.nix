{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  inputs.nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.home-manager.url = "github:nix-community/home-manager/release-25.11";

  outputs = {
    self,
    nixpkgs,
    ...
  } @ attrs: {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [./hosts/desktop/default.nix];
    };

    nixosConfigurations.framework = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [./hosts/framework/default.nix];
    };

    nixosConfigurations.t480 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [./hosts/t480/default.nix];
    };

    nixosConfigurations.x = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [./hosts/vm-test-x/default.nix];
    };

    formatter.x86_64-linux =
      nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
