{
  description = "Migg's Flakes Configuration";

  inputs = {
    nixpkgs.url = "github:com/NixOS/nixpkgs/nixos-23.11"; # Versão estável (base)
    
    # Versão Unstable para pacotes específicos
    nixpkgs-unstable.url = "github:com/NixOS/nixpkgs/nixos-unstable";
    
    # Home Manager
    home-manager.url = "github:com/nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Hyprland
    hyprland.url = "github:com/hyprwm/Hyprland";

    # tpanel - bar, launcher e notification
    tpanel = {
      url = "github:com/tuxdotrs/tpanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, tpanel, nixpkgs-unstable, ... }@inputs: {
    nixosConfigurations.cappuccino = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      
      # Passa o conjunto de pacotes unstable como um argumento extra (unstablePkgs)
      extraSpecialArgs = { 
        unstablePkgs = import nixpkgs-unstable { system = "x86_64-linux"; }; 
      };

      modules = [
        ./configuration.nix
        hyprland.nixosModules.default
        home-manager.nixosModules.default
        {
          home-manager.useUserPackages = true;
          home-manager.useGlobalPkgs = true;
          # Também passa o unstablePkgs para o home.nix
          home-manager.users.migg = {
             imports = [
               ./home.nix
             ];
             # Permite que home.nix acesse inputs e unstablePkgs
             _module.args = { inherit inputs unstablePkgs; }; 
          };
        }
      ];
    };
  };
}