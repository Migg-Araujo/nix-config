{ config, pkgs, inputs, ... }:

{
  # Allow Unfree Software
  nixpkgs.config.allowUnfree = true;
  
  # Network Configurations
  networking.networkmanager.enable = true;

  # Nix Settings
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  # Keep last 5 Nix Generations
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}
