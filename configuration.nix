{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./modules/programs/hyprland.nix
    ];
    
  nix.settings.experimental-features = ["nix-command" "flakes"];	
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "cappuccino";
  networking.networkmanager.enable = true;

  # Ajustado para São Paulo
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
  };
  
  # Firmware para seus drivers AMD
  hardware.enableAllFirmware = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  console.keyMap = "br-abnt2";
  
  users.users.migg = {
    isNormalUser = true;
    description = "Miguel Araújo";
    # **CORREÇÃO AQUI:** 'extraGroup' [Source 34] renomeado para 'groups'
    groups = [ "networkmanager" "wheel" ];
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
    wezterm
    # Navegador Firefox (Unstable)
    firefox
    # tpanel
    inputs.tpanel.packages.${pkgs.system}.default
  ];

  # **CORREÇÃO AQUI:** Atualizado para a versão unstable atual [Source 37]
  system.stateVersion = "24.05"; 
}