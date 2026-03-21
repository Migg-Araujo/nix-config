{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Hardware Configuration
    ./hardware.nix

    # Nix Configuration
    ../../modules/core/users.nix
    ../../modules/core/locale.nix
    ../../modules/core/nix-settings.nix
    ../../modules/core/services.nix
    ../../modules/core/fonts.nix
  ];

  # Hyprland Configurations
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

  # Hostname
  networking.hostName = "cappuccino";

  # Bootloader SystemMD
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;

  # Kernel Zen
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Tpanel Configuration
  environment.systemPackages = [inputs.tpanel.packages.${pkgs.system}.default];

  system.stateVersion = "25.05";
}
