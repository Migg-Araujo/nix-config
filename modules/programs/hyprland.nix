{ config, pkgs, ... }:

{
  services.xserver.enable = true;
  programs.hyprland = {
    enable = true;
    settings = {
      
      # Autostart (Início Automático)
      exec-once = [ 
        "tpanel &"
        # "swaybg -i /caminho/para/seu/wallpaper.jpg &"
      ];

      # ----------------------------------------------------
      # Atalhos de Teclado (Binds) - SEÇÃO CORRIGIDA
      # ----------------------------------------------------
      "$mod" = "SUPER";

      bind = 
        # 1. Binds Estáticos
        [
          # Abrir Terminal: WEZTERM
          "$mod, T, exec, wezterm" 
          # Abrir Navegador: FIREFOX
          "$mod, B, exec, firefox"
          # Fechar janela ativa
          "$mod, Q, killactive,"
          # Abrir Launcher do tpanel
          "$mod, D, exec, tpanel_launcher" 
          # Alternar entre as janelas
          "$mod, TAB, cyclenext"
          # Alternar o layout
          "$mod, J, layoutmsg, orientationnext"
          # Mover o foco entre as janelas
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, I, movefocus, d"
          # Mover a janela ativa (com SHIFT)
          "$mod SHIFT, H, movewindow, l"
          "$mod SHIFT, L, movewindow, r"
          "$mod SHIFT, K, movewindow, u"
          "$mod SHIFT, I, movewindow, d"
          # Sair do Hyprland
          "$mod, E, exit,"
          # Recarregar a configuração do Hyprland
          "$mod, R, exec, hyprctl reload"
          # Scroll para trocar de Workspace
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"
        ]
        
        # 2. Concatena os binds gerados por laço (Workspaces 1-10)
        ++ (builtins.genList (i: 
          let ws = toString (i + 1); # i vai de 0 a 9, então adicionamos 1
          in "$mod, ${ws}, workspace, ${ws}"
        ) 10) # Gera 10 entradas (1 a 10)

        # 3. Concatena os binds gerados por laço (Mover para Workspaces 1-10)
        ++ (builtins.genList (i: 
          let ws = toString (i + 1); 
          in "$mod SHIFT, ${ws}, movetoworkspace, ${ws}"
        ) 10);

      # ----------------------------------------------------
      # Configuração do Mouse
      # ----------------------------------------------------
      bindm = [
        "$mod, mouse:272, movewindow" 
        "$mod, mouse:273, resizewindow" 
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    libnotify 
    wayland
    mesa
  ];
}