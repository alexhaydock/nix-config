{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  inputs.nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

  inputs.home-manager = {
    url = "github:nix-community/home-manager/release-25.11";
    inputs.nixpkgs.follows = "nixpkgs"; # Use the existing nixpkgs for home-manager rather than pulling in a duplicate
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    ...
  } @ attrs: let
    # Define our system as x86_64 Linux so we can `inherit system` later
    # for anything that needs to know what system to build for
    system = "x86_64-linux";
    # Define pkgsUnstable as an output that other modules can consume
    pkgsUnstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    formatter.x86_64-linux =
      nixpkgs.legacyPackages.x86_64-linux.alejandra;

    ##################
    ## DEFINE HOSTS ##
    ##################

    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs =
        attrs
        // {
          inherit pkgsUnstable; # Specifically pass pkgsUnstable to the module as it's not part of `attrs` natively
        };
      modules = [./hosts/desktop/default.nix];
    };

    nixosConfigurations.framework = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs =
        attrs
        // {
          inherit pkgsUnstable; # Specifically pass pkgsUnstable to the module as it's not part of `attrs` natively
        };
      modules = [./hosts/framework/default.nix];
    };

    nixosConfigurations.t480 = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs =
        attrs
        // {
          inherit pkgsUnstable; # Specifically pass pkgsUnstable to the module as it's not part of `attrs` natively
        };
      modules = [./hosts/t480/default.nix];
    };

    nixosConfigurations.x = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs =
        attrs
        // {
          inherit pkgsUnstable; # Specifically pass pkgsUnstable to the module as it's not part of `attrs` natively
        };
      modules = [./hosts/vm-test-x/default.nix];
    };
  };
}
