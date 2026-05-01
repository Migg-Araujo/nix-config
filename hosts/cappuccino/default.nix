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

  # Gnome Configurations
  # services.xserver.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Steam Configurations
  hardware.steam-hardware.enable = true;
  services.udev.packages = [pkgs.game-devices-udev-rules];

  # Hostname
  networking.hostName = "cappuccino";

  # Bootloader SystemMD
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;

  # Kernel Zen
  boot.kernelPackages = pkgs.linuxPackages_zen;

  system.stateVersion = "25.05";
}
