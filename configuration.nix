# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, unstablePkgs, ... }: # Recebendo 'unstablePkgs'

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./modules/programs/hyprland.nix
    ];
    
  # ... (resto das configurações de nix, boot, networking, i18n, etc. permanecem iguais)
  nix.settings.experimental-features = ["nix-command" "flakes"];	
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "cappuccino";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.xkb = {
    layout = "br";
    variant = "";

  hardware.enableAllFirmware = true; 
  
  # Configuração Específica para Drivers AMD/Radeon (Mesa)
  services.xserver.videoDrivers = [ "amdgpu" ];
  };
  console.keyMap = "br-abnt2";

  users.users.migg = {
    isNormalUser = true;
    description = "Miguel Araújo";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
  
  services.displayManager.defaultSession = "hyprland";

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vim
    neovim
    wget
    git
    # Terminal Wezterm (Unstable)
    unstablePkgs.wezterm
    # Navegador Firefox (Unstable)
    unstablePkgs.firefox
    # tpanel
    inputs.tpanel.packages.${pkgs.system}.default
  ];

  system.stateVersion = "23.11"; 
}