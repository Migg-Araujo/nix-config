{ config, pkgs, inputs, unstablePkgs, ... }: # Recebendo 'unstablePkgs'

{
  home.username = "migg";
  home.homeDirectory = "/home/migg";

  # Adicione pacotes Home Manager, usando a versão unstable quando possível
  home.packages = [ 
    # tpanel
    inputs.tpanel.packages.${pkgs.system}.default 
    # wezterm unstable (redundante, mas garante que o Home Manager o veja)
    unstablePkgs.wezterm 
  ];

  # Habilita e configura o wezterm via Home Manager
  programs.wezterm = {
    enable = true;
    # Você pode colocar sua configuração Lua aqui:
    # extraConfig = "return {}"; 
  };
  
  # Você pode habilitar e configurar o firefox aqui se necessário (ex: extensões)
  # programs.firefox = { enable = true; ... };

  home.stateVersion = "23.11";
}