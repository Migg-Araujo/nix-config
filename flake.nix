{
  description = "Migg's Nix Flake";

  inputs = {
    # Nix Packages
    nixpkgs.url = "github:nixos/nixpkgs";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hardware Otimizations
    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    # Nvim
    tnvim = {
      url = "github:Migg-Araujo/nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Prism Laucher
    prismlauncher = {
      url = "github:PrismLauncher/PrismLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      # Cappuccino Configurations
      cappuccino = lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          {nixpkgs.hostPlatform = "x86_64-linux";}
          ./hosts/cappuccino/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {inherit inputs;};
            home-manager.users.migg = import ./users/migg/cappuccino.nix;
          }
        ];
      };

      # Latte Configurations
      latte = lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          {nixpkgs.hostPlatform = "x86_64-linux";}
          ./hosts/latte/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {inherit inputs;};
            home-manager.users.migg = import ./users/migg/latte.nix;
          }
        ];
      };
    };
  };
}
