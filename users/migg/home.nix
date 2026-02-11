{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../modules/home/wezterm.nix
    ../../modules/home/firefox.nix
    ../../modules/home/git.nix
    ../../modules/home/nvim.nix
  ];

  # Home Settings
  home.username = "migg";
  home.homeDirectory = "/home/migg";

  # Universal Packages
  home.packages = with pkgs; [
  ];

  # Home Manager Configuration
  programs.home-manager.enable = true;

  # State Version
  home.stateVersion = "25.05"; 
}
