# ~/nixos-config/home.nix

{ config, pkgs, ... }:

{
  home.username = "migg";
  home.homeDirectory = "/home/migg";
  
  # Home Manager Version
  home.stateVersion = "24.05";
  
  # Packages for the user
  home.packages = with pkgs; [
    nvim
    git
  ];
  
  # Example
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -lh";
      update = "sudo nixos-rebuild switch --flake ~/nixos-config#cappuccino";
    };
  };

  # Example for dotfile
  # home.file.".config/meu-app/config.conf".text = "conteúdo da config...";
}