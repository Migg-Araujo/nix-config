{
  description = "Migg's Flakes Configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    # NixOS Configurations
    nixosConfigurations = {
      "cappuccino" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            #Home Manager Configuration
            home-manager.users.migg = import ./home.nix;
            home-manager.extraSpecialArgs = { inherit inputs; }; 
          }
        ];
      };
    };
  };
}