{ config, pkgs, inputs, ... }:

{
  imports = [ ./home.nix ];

  # Exclusive PC Packages
  home.packages = with pkgs; [
    inputs.tpanel.packages.${system}.default
  ];
}
