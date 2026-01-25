{ pkgs, ... }:

{
  imports = [ ./home.nix ];

  # Exclusive PC Packages
  home.packages = with pkgs; [
      
  ];
  
  #Tpanel Configuration
  home.packages = [ inputs.tpanel.packages.${system}.default ];
}
