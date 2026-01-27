{ config, pkgs, inputs, ... }:

{
  imports = [
    #../../modules/home/wezterm.nix
  ];

  # Home Settings
  home.username = "migg";
  home.homeDirectory = "/home/migg";

  # Universal Packages
  home.packages = with pkgs; [
    firefox
    wezterm
    git
    neovim
    zsh
    starship
  ];

  # Home Manager Configuration
  programs.home-manager.enable = true;

  # State Version
  home.stateVersion = "25.05"; 
}
