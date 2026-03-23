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

  #I3WM Configurations
  services.xserver = {
    enable = true;
    layout = "br";
    xkbVariant = "abnt2";

    windowManager.i3.enable = true;
  };

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

  # Hostname
  networking.hostName = "latte";

  # Bootloader SystemMD
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;

  # Kernel Latest
  boot.kernelPackages = pkgs.linuxPackages_latest;

  system.stateVersion = "25.05";
}
