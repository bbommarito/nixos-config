{
  description = "Burrito's Nixos Configuration";

  inputs = {
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-22.11";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
  };

  outputs = inputs@{ self, nixpkgs, home-manager }:

    let
      lib = nixpkgs.lib;

      pkgs = import nixpkgs {
        config.allowUnfree = true;
        inherit system;
      };

      system = "x86_64-linux";
    in {
      nixosConfigurations = {
        nala = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.bbommarito = import ./home.nix;
            }
          ];
        };
      };
    };
}

