{ config, pkgs, inputs, ... }:

{
  imports = [ 
    # Hardware Configuration
    ./hardware.nix

    # Hyprland Configuration
    ../../modules/desktop/hyprland.nix
    
    # Nix Configuration
    ../../modules/core/users.nix
    ../../modules/core/locale.nix
    ../../modules/core/nix-settings.nix
    ../../modules/core/services.nix
    ../../modules/core/fonts.nix
  ];

  # Hostname
  networking.hostName = "cappuccino";

  # Bootloader GRUB
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel Zen
  #boot.kernelPackages = pkgs.linuxPackages_zen;

  # Tpanel Configuration
  environment.systemPackages = [ inputs.tpanel.packages.${pkgs.system}.default ];

  system.stateVersion = "25.05";
}
