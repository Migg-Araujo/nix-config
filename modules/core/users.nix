{ pkgs, ... }:

{
  # Default Shell
  programs.zsh.enable = true; 

  users.users.migg = {
    isNormalUser = true;
    description = "Migg";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "lp" ];
    shell = pkgs.zsh; 
  };
}
