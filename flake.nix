{
  description = "Migg's Nix Flake";

  inputs = {
    # Nix Packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hardware Otimizations
    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    # TPanel
    tpanel = {
      url = "github:Migg-Araujo/tpanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ...}@inputs:
  let
    lib = nixpkgs.lib;
      system = "x86_64-linux";
  in{
    nixosConfigurations = {

      # Cappuccino Configurations
      cappuccino = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/cappuccino/default.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.migg = import ./users/migg/cappuccino.nix;
          }
        ];
      };
        
      # Latte Configurations
      latte = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/latte/default.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.migg = import ./users/migg/latte.nix;
          }
        ];
      };

    };
  };
}
