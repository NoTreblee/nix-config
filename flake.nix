{
  description = "Szlacroxx NixOS + Home Manager + Nix-on-Droid config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-on-droid, ... }:
  let
    system = "x86_64-linux";

    commonModules = [
      ./modules/nixos/common.nix
    ];

    mkHost = hostname: nixpkgs.lib.nixosSystem {
      inherit system;

      modules = commonModules ++ [
        ./hosts/${hostname}/configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.szlacroxx = import ./home/szlacroxx/home.nix;
        }
      ];
    };
  in {
    nixosConfigurations = {
      mbp = mkHost "mbp";
      snus = mkHost "snus";
    };

    nixOnDroidConfigurations = {
      default = nix-on-droid.lib.nixOnDroidConfiguration {  
        pkgs = import nixpkgs { system = "aarch64-linux"; };
        modules = [ ./droid/configuration.nix ];
      };
    };
  };
}
