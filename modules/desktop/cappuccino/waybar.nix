{
  config,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 50;
        width = 1200;
        margin-top = 10;

        modules-left = [
          "custom/nixos"
          "clock"
        ];
        modules-center = [
          "cava#left"
          "hyprland/workspaces"
          "cava#right"
        ];
        modules-right = [
          "custom/bluetooth"
          "tray"
          "group/power"
        ];

        "custom/nixos" = {
          format = "";
          tooltip = false;
          on-click = "wofi --show drun";
        };

        "clock" = {
          # Formato apenas com horas e minutos (ex: 14:30)
          format = "{:%H:%M}";
          # Tooltip ativado para mostrar detalhes se passar o mouse
          tooltip = false;
        };

        # TUDO ISSO DEVE FICAR DENTRO DO mainBar
        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          all-outputs = true;
          show-special = false;
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
          format-icons = {
            "activate" = " ";
            "occupied" = " ";
            "default" = " ";
          };
        };

        # Configuração do Cava da Esquerda
        "cava#left" = {
          framerate = 30;
          autosens = 1;
          bars = 14;
          method = "pulse";
          source = "auto";
          stereo = true;
          reverse = false;
          bar_delimiter = 0;
          monstercat = false;
          waves = false;
          noise_reduction = 0.77;
          format-icons = [
            "▁"
            "▂"
            "▃"
            "▄"
            "▅"
            "▆"
            "▇"
            "█"
          ];
          sleep_timer = 1; # Faz o módulo entrar em "sleep" se não houver som
          hide_on_silence = true; # Esconde o texto/barras quando silencioso
        };

        # Configuração do Cava da Direita
        "cava#right" = {
          framerate = 30;
          autosens = 1;
          bars = 10;
          method = "pulse";
          source = "auto";
          stereo = true;
          reverse = false;
          bar_delimiter = 0;
          monstercat = false;
          waves = false;
          noise_reduction = 0.77;
          format-icons = [
            "▁"
            "▂"
            "▃"
            "▄"
            "▅"
            "▆"
            "▇"
            "█"
          ];
          sleep_timer = 1; # Faz o módulo entrar em "sleep" se não houver som
          hide_on_silence = true; # Esconde o texto/barras quando silencioso
        };

        # Configuração do Grupo (Gaveta)
        "group/power" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 500;
            children-class = "not-power";
            transition-left-to-right = false;
          };
          modules = [
            "custom/coffee" # O botão principal (gatilho)
            "custom/quit"
            "custom/reboot"
            "custom/lock"
          ];
        };

        "custom/coffee" = {
          format = "";
          tooltip = false;
        };

        "custom/quit" = {
          format = "󰗽";
          tooltip = false;
          on-click = "hyprctl dispatch exit";
        };

        "custom/reboot" = {
          format = "";
          tooltip = false;
          on-click = "systemctl reboot";
        };

        "custom/lock" = {
          format = "";
          tooltip = false;
          on-click = "systemctl poweroff";
        };

        "custom/bluetooth" = {
          format = "󰂯";
          tooltip = false;
          on-click = "wezterm start --class wezterm-floating -e bluetui";
        };

        "tray" = {
          # Espaçamento entre os ícones (Steam, Discord, etc)
          spacing = 10;
          icon-size = 20;
        };
      };
    };

    style = ''
             * {
                 border: none;
                 font-family: "JetBrainsMono Nerd Font";
             }

             window#waybar {
                 background-color: #0f0f0f;
                 border-radius: 8px;
             }

             #workspaces {
                 margin: 0 4px;
             }

             #workspaces button {
                 padding: 0;

                 /* O TRUQUE DA CENTRALIZAÇÃO: */
                 /* Definimos uma margem vertical de 10px (50px barra - 30px círculo = 20px / 2). */
                 /* O primeiro valor é vertical (cima/baixo), o segundo é horizontal (lados). */
                 margin: 17.5px 5px;

                 /* Definimos um tamanho base fixo */
                 min-width: 15px;
                 min-height: 15px;

                 font-size: 0; /* Impede expansão horizontal por texto vazio */
                 background-color: #1f1f1f;
                 color: transparent;
                 border-radius: 999px; /* Perfeitamente redondo */
                 transition: all 0.3s ease-in-out;
              }

             #workspaces button.occupied {
                 background-color: #6791c9;
             }

             #workspaces button.active {
                 background-color: #6791c9;

                 /* Garante que a margem vertical de 10px permaneça no estado ativo */
                 margin: 17.5px 5px;

                 min-width: 30px; /* Estende horizontalmente para criar a pílula */
                 min-height: 15px; /* Mantém a altura fixa */
                 border-radius: 999px; /* Mantém as pontas redondas */
             }

             /* Tira o brilho azul padrão quando clica */
            #workspaces button:hover {
                 /* Mantém a cor original de fundo para não ficar branco */
                 background-color: #1f1f1f;
                 background-image: none;
                 box-shadow: none;
                 text-shadow: none;
             }

             /* Garante que se o ocupado ou ativo sofrer hover, mantenha o azul */
             #workspaces button.occupied:hover,
             #workspaces button.active:hover {
                 background-color: #6791c9;
                 background-image: none;
             }

             /* Estilo base para ambos os cavas */
            #cava {
                margin: 10px 10px;
                border-radius: 8px;
                padding: 0 5px;
                color: #6791c9; /* O mesmo azul dos seus workspaces */
                background-color: #1f1f1f;
            }

            /* Estilo específico se quiser diferenciar ou ajustar margens */
            #cava.left {
                margin-right: 15px;
                letter-spacing: 1px;
                /* Garante que a fonte monospaçada mantenha o alinhamento */
                font-family: "JetBrainsMono Nerd Font";
                font-size: 10px;
                padding-bottom: 0;
            }

            #cava.right {
                margin-left: 15px;
                letter-spacing: 1px;
                /* Garante que a fonte monospaçada mantenha o alinhamento */
                font-family: "JetBrainsMono Nerd Font";
                font-size: 10px;
                padding-bottom: 0;

            }

            /* Quando o Cava estiver "dormindo" (sem som), ele fica invisível */
            #cava.sleep {
                color: transparent;
                margin: 0;
                padding: 0;
            }

            /*Menu Button*/
            #custom-nixos, #custom-coffee, #custom-bluetooth, #custom-quit, #custom-reboot, #custom-lock {
                background-color: #1f1f1f;
                color: #ffffff; /* Ícone em branco */

                /* Margem e Round como você pediu */
                margin: 10px;
                border-radius: 8px;
                border: none;
                padding: 0;
                padding-left: 5px;
                padding-right: 13px;

                /* Ajuste de tamanho para ficar proporcional */
                font-family: "JetBrainsMono Nerd Font";
                font-size: 20px;

                /* Transição suave para combinar com o resto da barra */
                transition: all 0.3s ease-in-out;
            }

            #custom-coffee {
              font-size: 17px;
              padding-right: 15px;
            }

            #custom-bluetooth {
              padding-left: 9px;
              padding-right: 9px;
            }

            #custom-quit {
              margin-right: 0;
              padding-left: 13px;
              padding-right: 15px;
              border-right: 1px solid #0f0f0f;
              border-radius: 8px 0px 0px 8px;
            }

            #custom-reboot {
              margin-left: 0;
              margin-right: 0;
              padding-left: 12px;
              padding-right: 16px;
              border-radius: 0;
            }

            #custom-lock {
              margin-left: 0;
              padding-left: 11px;
              padding-right: 17px;
              border-left: 1px solid #0f0f0f;
              border-radius: 0px 8px 8px 0px;

            }

            #clock {
              font-size: 12pt;
              font-family: "JetBrainsMono Nerd Font";
              font-weight: bold;
              margin: 10px;
              border-radius: 8px;
              border: none;
              color: #ffffff;
              background-color: #1f1f1f;
              padding: 0px 10px;
            }

            #tray {
          background-color: #1f1f1f;

          margin: 10px;
          border-radius: 8px;

          /*
             CENTRALIZAÇÃO MANUAL:
             Como não podemos usar display/line-height, o padding define o tamanho.
             Ajuste o padding-left/right para dar o respiro horizontal necessário.
          */
          padding-left: 10px;
          padding-right: 10px;
          padding-top: 0px;
          padding-bottom: 0px;

          /* Define uma altura mínima para alinhar com o restante da barra */
          min-height: 30px;
      }
    '';
  };
}
