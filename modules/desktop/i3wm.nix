{
  config,
  lib,
  pkgs,
  ...
}: let
  mod = "Mod4";
in {
  xsession.windowManager.i3 = {
    enable = true;

    config = {
      modifier = mod;

      terminal = "wezterm";

      window.border = 2;

      fonts = {
        names = ["JetBrainsMono Nerd Font"];
        size = 10.0;
      };

      # Keybindings
      keybindings = lib.mkOptionDefault {
        "${mod}+t" = "exec wezterm";
        "${mod}+d" = "exec dmenu_run";

        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        "${mod}+Shift+c" = "kill";
      };

      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status}/bin/i3status";

          colors = {
            background = "#0f0f0f"; # Fundo solicitado
            statusline = "#a6accd"; # Poimandres: bluish gray
            separator = "#506477"; # Poimandres: muted blue

            focusedWorkspace = {
              border = "#5fb3b3"; # Poimandres: teal
              background = "#5fb3b3"; # Poimandres: teal
              text = "#0f0f0f"; # Texto escuro no fundo claro
            };

            activeWorkspace = {
              border = "#0f0f0f";
              background = "#2e303e"; # Poimandres: dark slate
              text = "#a6accd";
            };

            inactiveWorkspace = {
              border = "#0f0f0f";
              background = "#0f0f0f";
              text = "#767c9d"; # Poimandres: low contrast blue
            };

            urgentWorkspace = {
              border = "#0f0f0f";
              background = "#add7ff"; # Poimandres: bright blue
              text = "#0f0f0f";
            };
          };
        }
      ];
    };
  };
}
