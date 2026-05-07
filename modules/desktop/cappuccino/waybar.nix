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
          format = "{:%H:%M}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            on-scroll = 1;
            format = {
              months = "<span color='#6791c9'><b>{}</b></span>";
              days = "<span color='#ffffff'><b>{}</b></span>";
              weekdays = "<span color='#6791c9'><b>{}</b></span>";
              today = "<span color='#6791c9'><b>{}</b></span>";
            };
          };
          actions = {
            on-click = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

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
          sleep_timer = 1;
          hide_on_silence = true;
        };

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
          sleep_timer = 1;
          hide_on_silence = true;
        };

        "group/power" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 500;
            children-class = "not-power";
            transition-left-to-right = false;
          };
          modules = [
            "custom/coffee"
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

      #clock:hover {}

      #calendar {
        background: #1f1f1f;
        border: none;
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 12pt;
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
        margin: 17.5px 5px;
        min-width: 15px;
        min-height: 15px;
        font-size: 0;
        background-color: #1f1f1f;
        color: transparent;
        border-radius: 999px;
        transition: all 0.3s ease-in-out;
      }

      #workspaces button {
        background-color: #6791c9;
      }

      #workspaces button.empty {
        background-color: #1f1f1f;
      }

      #workspaces button.active {
        background-color: #6791c9;
        margin: 17.5px 5px;
        min-width: 30px;
        min-height: 15px;
        border-radius: 999px;
      }

      #workspaces button.empty:hover {
        background-color: #6791c9;
        background-image: none;
        box-shadow: none;
        text-shadow: none;
      }

      #workspaces button:hover,
      #workspaces button.active:hover {
        background-color: #1f1f1f;
        background-image: none;
      }

      #cava {
        margin: 10px 10px;
        border-radius: 8px;
        padding: 0 5px;
        color: #6791c9;
        background-color: #1f1f1f;
      }

      #cava.left {
        margin-right: 15px;
        letter-spacing: 1px;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 10px;
        padding-bottom: 0;
      }

      #cava.right {
        margin-left: 15px;
        letter-spacing: 1px;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 10px;
        padding-bottom: 0;
      }

      #cava.sleep {
        color: transparent;
        margin: 0;
        padding: 0;
      }

      #custom-nixos, #custom-coffee, #custom-bluetooth, #custom-quit, #custom-reboot, #custom-lock {
        background-color: #1f1f1f;
        color: #ffffff;
        margin: 10px;
        border-radius: 8px;
        border: none;
        padding: 0;
        padding-left: 5px;
        padding-right: 13px;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 20px;
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

      #custom-nixos:hover, #custom-coffee:hover, #custom-bluetooth:hover, #custom-quit:hover, #custom-reboot:hover, #custom-lock:hover {
        background-color: #ffffff;
        color: #1f1f1f;
        transition: all 0.2s ease;
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
        padding-left: 10px;
        padding-right: 10px;
        padding-top: 0px;
        padding-bottom: 0px;
        min-height: 30px;
      }
    '';
  };
}
