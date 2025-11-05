{ config, pkgs, ... }:

{
  services.xserver.enable = true;
  programs.hyprland = {
    enable = true;
    settings = {
      # ----------------------------------------------------
      # ... (General, Decoration, Monitor, etc. permanecem iguais)
      # ----------------------------------------------------
      
      # ----------------------------------------------------
      # Autostart (Início Automático)
      # ----------------------------------------------------
      exec-once = [ 
        "tpanel &"
        # "swaybg -i /caminho/para/seu/wallpaper.jpg &"
      ];

      # ----------------------------------------------------
      # Atalhos de Teclado (Binds)
      # ----------------------------------------------------
      "$mod" = "SUPER";

      bind = [
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

        # Redimensionar/Mover a janela ativa (com SHIFT)
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, I, movewindow, d"
        
        # Sair do Hyprland
        "$mod, E, exit,"
        # Recarregar a configuração do Hyprland
        "$mod, R, exec, hyprctl reload"
      ];
      
      # Trocar para Workspace (1-10)
      bind = [ for i in range 1 10 -> 
        "$mod, ${toString i}, workspace, ${toString i}"
      ];

      # Mover a janela ativa para Workspace (1-10)
      bind = [ for i in range 1 10 -> 
        "$mod SHIFT, ${toString i}, movetoworkspace, ${toString i}"
      ];
      
      # Scroll para trocar de Workspace
      bind = [
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ];

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
    # O wezterm foi movido para o environment.systemPackages principal e é a versão unstable.
  ];
}