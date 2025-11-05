{ config, pkgs, inputs, ... }:

{
  # REMOVIDO: 'home.username' e 'home.homeDirectory' [Source 8]
  # O flake.nix [Source 7] já define o usuário como 'migg'.

  home.packages = [ 
    # tpanel
    inputs.tpanel.packages.${pkgs.system}.default 
    # wezterm (do pkgs unstable)
    pkgs.wezterm 
  ];

  programs.wezterm = {
    enable = true;
    # extraConfig = "return {}"; 
  };
  
  # **CORREÇÃO AQUI:** Atualizado para a versão unstable atual
  home.stateVersion = "24.05";
}