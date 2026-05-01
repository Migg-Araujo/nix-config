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
        modules-right = ["custom/coffee"];

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
          # Ação de clique: por padrão o GTK abre o calendário se configurado,
          # mas podemos reforçar ou usar um app externo se preferir.
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
          input_delay = 1;
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
          input_delay = 1;
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

        "custom/coffee" = {
          format = "";
          tooltip = false;
          on-click = "wofi --show drun";
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
      #custom-nixos, #custom-coffee {
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

      #clock {
        font-size: 15px;
        font-family: "JetBrainsMono Nerd Font";
        font-weight: bold;
        margin: 10px;
        border-radius: 8px;
        border: none;
        color: #ffffff;
        background-color: #1f1f1f;
        padding: 0px 10px;

      }
    '';
  };
}
