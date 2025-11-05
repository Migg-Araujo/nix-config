{
  description = "Migg's Flakes Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    # Home Manager
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";

    # tpanel - bar, launcher e notification
    tpanel = {
      url = "github:tuxdotrs/tpanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, tpanel, ... }@inputs: {
    nixosConfigurations.cappuccino = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      
      modules = [
       ({ config, pkgs, ...}: {
       imports = [ ./configuration.nix];
       # Passa 'inputs' para configuration.nix
       _module.args = { inherit inputs; }; 
       })
       
       hyprland.nixosModules.default
        home-manager.nixosModules.default
        {
          home-manager.useUserPackages = true;
          home-manager.useGlobalPkgs = true;

          home-manager.users.migg = {
             imports = [
               ./home.nix
             ];
             # Passa 'inputs' para home.nix
             _module.args = { inherit inputs; };
          };
        }
      ];
    };
  };
}