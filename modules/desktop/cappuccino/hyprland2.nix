{
  pkgs,
  inputs,
  args,
  lib,
  ...
}: let
  # Hyprland
  border_size = 0;
  gaps_in = 5;
  gaps_out = 10;
  gaps_ws = -10;
  rounding = 8;
  active_border_col = "rgba(6791c9ff)";
  inactive_border_col = "rgba(00000000)";

  # Apps
  terminal = "wezterm";
  floating_terminal = "wezterm start --class wezterm-floting";
  editor = "wezterm -e nvim";
  browser = "librewolf --new-window";
  filemanager = "wezterm -e superfile";
  floating_filemanager = "wezterm start --class wezterm-floating -e superfile";
  bluetooth = "wezterm start --class wezterm-floating -e bluetui";
  audiomanager = "wezterm start --class wezterm-floating -e pulsemixer";
  launcher = "wofi --show drun";
  notify_panel = "swaync-client -t -sw";

  # Wallpaper Path
  wallpaper_path = "/home/migg/Wallpapers/wallpaper1.jpg";
in {
  imports = [
    ./hyprlock.nix
    ./hyprshot.nix
    ./wofi.nix
    ./waybar.nix
    ./swaync.nix
    ./gtk.nix
  ];

  home.packages = with pkgs; [
    ags
    swaybg
    phinger-cursors
  ];

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    package = pkgs.phinger-cursors;
    name = "phinger-cursors-dark";
    size = 16;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua"; # Mudado para usar o novo formato em Lua
    xwayland.enable = true;
    systemd.variables = ["--all"];

    plugins = with pkgs.hyprlandPlugins; [
      # hyprexpo
    ];

    settings = {
      monitor = [
        "HDMI-A-1,1920x1080@75,0x0,1"
      ];

      input = {
        kb_layout = "br";
        kb_variant = "";
        kb_model = "abnt2";
        sensitivity = -0.7;
        scroll_method = "2 fg";
      };

      env = [
        "XCURSOR_SIZE,8"
        "XCURSOR_THEME,phinger-cursors-dark"
        "HYPRSHOT_DIR,/home/migg/Pictures/Screenshots"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
      ];

      general = {
        border_size = border_size;
        gaps_in = gaps_in;
        gaps_out = gaps_out;
        gaps_workspaces = gaps_ws;
        layout = "master";
        resize_on_border = true;
        col_active_border = active_border_col;
        col_inactive_border = inactive_border_col;
      };

      cursor = {
        inactive_timeout = 0;
      };

      misc = {
        disable_hyprland_logo = true;
        force_default_wallpaper = 1;
        vrr = 1;
      };

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };

      decoration = {
        rounding = rounding;
        active_opacity = 1.0;
        inactive_opacity = 0.75;
        fullscreen_opacity = 1.0;

        blur = {
          enabled = false;
          size = 4;
          passes = 3;
          new_optimizations = true;
          xray = false;
          special = true;
          brightness = 1;
          noise = 0.02;
          contrast = 1;
          popups = true;
          popups_ignorealpha = 0.6;
        };
        shadow = {
          enabled = false;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          {
            _args = [
              "zoom"
              0.05
              0.7
              0.1
              1.0
            ];
          }
        ];
        animation = [
          {
            _args = [
              "windows"
              1
              1
              "zoom"
              "slide"
            ];
          }
          {
            _args = [
              "windowsIn"
              1
              1
              "zoom"
              "slide"
            ];
          }
          {
            _args = [
              "windowsOut"
              1
              1
              "zoom"
              "slidevert"
            ];
          }
          {
            _args = [
              "windowsMove"
              1
              1
              "zoom"
              "slide"
            ];
          }
          {
            _args = [
              "fade"
              1
              2
              "zoom"
            ];
          }
          {
            _args = [
              "workspaces"
              1
              1
              "zoom"
              "slide"
            ];
          }
        ];
      };

      master = {
        allow_small_split = false;
        special_scale_factor = 0.8;
        mfact = 0.5;
        new_on_top = false;
        orientation = "left";
        smart_resizing = true;
        drop_at_cursor = true;
      };

      windowrule = [
        "float on, center on, size 800 600, match:class org.pulseaudio.pavucontrol"
        "float on, center on, size 1200 800, match:class (com.ghostty.floating|wezterm-floating)"
        "float on, center on, size 900 700, match:class GalaxyBudsClient"
        "float on, center on, size 900 700, match:class (org.kde.kdeconnect.sms|org.kde.kdeconnect.app)"
        "opacity 1 2, match:float 1"
      ];

      gesture = [
        {
          _args = [
            3
            "horizontal"
            "workspace"
          ];
        }
      ];

      bindm = [
        {
          _args = [
            "SUPER"
            "mouse:273"
            (lib.generators.mkLuaInline "resizewindow")
          ];
        }
        {
          _args = [
            "SUPER"
            "mouse:272"
            (lib.generators.mkLuaInline "movewindow")
          ];
        }
      ];

      bind = [
        # print
        {
          _args = [
            "SHIFT, Print"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"hyprshot -m output\")")
          ];
        }
        {
          _args = [
            ", Print"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"hyprshot -m region\")")
          ];
        }

        # apps
        {
          _args = [
            "SUPER, T"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${terminal}\")")
          ];
        }
        {
          _args = [
            "SUPER, F"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${filemanager}\")")
          ];
        }
        {
          _args = [
            "SUPER, E"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${editor}\")")
          ];
        }
        {
          _args = [
            "SUPER, B"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${browser}\")")
          ];
        }
        {
          _args = [
            "SUPER, A"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${audiomanager}\")")
          ];
        }
        {
          _args = [
            "SUPER, D"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"discord\")")
          ];
        }
        {
          _args = [
            "SUPER, S"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"steam\")")
          ];
        }

        {
          _args = [
            "SUPER_SHIFT, T"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${floating_terminal}\")")
          ];
        }
        {
          _args = [
            "SUPER_SHIFT, F"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${floating_filemanager}\")")
          ];
        }
        {
          _args = [
            "SUPER_SHIFT, B"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${bluetooth}\")")
          ];
        }

        # launcher
        {
          _args = [
            "SUPER, Space"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${launcher}\")")
          ];
        }
        {
          _args = [
            "SUPER, N"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${notify_panel}\")")
          ];
        }

        # hyprland
        {
          _args = [
            "SUPER, Q"
            (lib.generators.mkLuaInline "hl.dsp.window.close()")
          ];
        }
        {
          _args = [
            "SUPER, C"
            (lib.generators.mkLuaInline "hl.dsp.window.close()")
          ];
        }
        {
          _args = [
            "SUPER_SHIFT, Q"
            (lib.generators.mkLuaInline "hl.dsp.window.force_close()")
          ];
        }
        {
          _args = [
            "SUPER_CTRL, F"
            (lib.generators.mkLuaInline "hl.dsp.window.fullscreen(0)")
          ];
        }
        {
          _args = [
            "SUPER_SHIFT, Space"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"hyprctl dispatch togglefloating; hyprctl dispatch resizeactive exact 1200 800; hyprctl dispatch centerwindow;\")")
          ];
        }
        {
          _args = [
            "SUPER_SHIFT, P"
            (lib.generators.mkLuaInline "hl.dsp.window.pin()")
          ];
        }

        # lock
        {
          _args = [
            "SUPER_SHIFT, L"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"hyprlock\")")
          ];
        }

        # change focus
        {
          _args = [
            "SUPER, left"
            (lib.generators.mkLuaInline "hl.dsp.focus_window(\"l\")")
          ];
        }
        {
          _args = [
            "SUPER, right"
            (lib.generators.mkLuaInline "hl.dsp.focus_window(\"r\")")
          ];
        }
        {
          _args = [
            "SUPER, up"
            (lib.generators.mkLuaInline "hl.dsp.focus_window(\"u\")")
          ];
        }
        {
          _args = [
            "SUPER, down"
            (lib.generators.mkLuaInline "hl.dsp.focus_window(\"d\")")
          ];
        }

        # move active
        {
          _args = [
            "SUPER_SHIFT, left"
            (lib.generators.mkLuaInline "hl.dsp.move_window(\"l\")")
          ];
        }
        {
          _args = [
            "SUPER_SHIFT, right"
            (lib.generators.mkLuaInline "hl.dsp.move_window(\"r\")")
          ];
        }
        {
          _args = [
            "SUPER_SHIFT, up"
            (lib.generators.mkLuaInline "hl.dsp.move_window(\"u\")")
          ];
        }
        {
          _args = [
            "SUPER_SHIFT, down"
            (lib.generators.mkLuaInline "hl.dsp.move_window(\"d\")")
          ];
        }

        # workspaces
        {
          _args = [
            "SUPER, 1"
            (lib.generators.mkLuaInline "hl.dsp.workspace(1)")
          ];
        }
        {
          _args = [
            "SUPER, 2"
            (lib.generators.mkLuaInline "hl.dsp.workspace(2)")
          ];
        }
        {
          _args = [
            "SUPER, 3"
            (lib.generators.mkLuaInline "hl.dsp.workspace(3)")
          ];
        }
        {
          _args = [
            "SUPER, 4"
            (lib.generators.mkLuaInline "hl.dsp.workspace(4)")
          ];
        }
        {
          _args = [
            "SUPER, 5"
            (lib.generators.mkLuaInline "hl.dsp.workspace(5)")
          ];
        }
        {
          _args = [
            "SUPER, 6"
            (lib.generators.mkLuaInline "hl.dsp.workspace(6)")
          ];
        }
        {
          _args = [
            "SUPER, 7"
            (lib.generators.mkLuaInline "hl.dsp.workspace(7)")
          ];
        }

        # send to workspaces
        {
          _args = [
            "SUPER_SHIFT, 1"
            (lib.generators.mkLuaInline "hl.dsp.movetoworkspacesilent(1)")
          ];
        }
        {
          _args = [
            "SUPER_SHIFT, 2"
            (lib.generators.mkLuaInline "hl.dsp.movetoworkspacesilent(2)")
          ];
        }
        {
          _args = [
            "SUPER_SHIFT, 3"
            (lib.generators.mkLuaInline "hl.dsp.movetoworkspacesilent(3)")
          ];
        }
        {
          _args = [
            "SUPER_SHIFT, 4"
            (lib.generators.mkLuaInline "hl.dsp.movetoworkspacesilent(4)")
          ];
        }
        {
          _args = [
            "SUPER_SHIFT, 5"
            (lib.generators.mkLuaInline "hl.dsp.movetoworkspacesilent(5)")
          ];
        }
        {
          _args = [
            "SUPER_SHIFT, 6"
            (lib.generators.mkLuaInline "hl.dsp.movetoworkspacesilent(6)")
          ];
        }
        {
          _args = [
            "SUPER_SHIFT, 7"
            (lib.generators.mkLuaInline "hl.dsp.movetoworkspacesilent(7)")
          ];
        }
      ];

      workspace = [
        "1, monitor:HDMI-A-1, default:true"
        "2, monitor:HDMI-A-1"
        "3, monitor:HDMI-A-1"
        "4, monitor:HDMI-A-1"
        "5, monitor:HDMI-A-1"
      ];

      binde = [
        # resize active
        {
          _args = [
            "SUPER_CTRL, left"
            (lib.generators.mkLuaInline "hl.dsp.resize_active(-20, 0)")
          ];
        }
        {
          _args = [
            "SUPER_CTRL, right"
            (lib.generators.mkLuaInline "hl.dsp.resize_active(20, 0)")
          ];
        }
        {
          _args = [
            "SUPER_CTRL, up"
            (lib.generators.mkLuaInline "hl.dsp.resize_active(0, -20)")
          ];
        }
        {
          _args = [
            "SUPER_CTRL, down"
            (lib.generators.mkLuaInline "hl.dsp.resize_active(0, 20)")
          ];
        }
        {
          _args = [
            "SUPER_CTRL, equal"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"hyprctl dispatch layoutmsg mfact exact 0.5;\")")
          ];
        }

        # move active (Floating Only)
        {
          _args = [
            "SUPER_ALT, left"
            (lib.generators.mkLuaInline "hl.dsp.move_active(-20, 0)")
          ];
        }
        {
          _args = [
            "SUPER_ALT, right"
            (lib.generators.mkLuaInline "hl.dsp.move_active(20, 0)")
          ];
        }
        {
          _args = [
            "SUPER_ALT, up"
            (lib.generators.mkLuaInline "hl.dsp.move_active(0, -20)")
          ];
        }
        {
          _args = [
            "SUPER_ALT, down"
            (lib.generators.mkLuaInline "hl.dsp.move_active(0, 20)")
          ];
        }
        {
          _args = [
            "SUPER_ALT, equal"
            (lib.generators.mkLuaInline "hl.dsp.center_window()")
          ];
        }

        # speaker and mic volume control
        {
          _args = [
            ", XF86AudioRaiseVolume"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 10%+\")")
          ];
        }
        {
          _args = [
            ", XF86AudioLowerVolume"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 10%-\")")
          ];
        }
        {
          _args = [
            ", XF86AudioMute"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle\")")
          ];
        }
        {
          _args = [
            ", XF86AudioMicMute"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle\")")
          ];
        }
      ];

      exec_once = [
        "${pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all && systemctl --user stop hyprland-session.target && systemctl --user start hyprland-session.target"
        "waybar"
        "swaybg -i ${wallpaper_path} -m fill"
        "hyprctl setcursor phinger-cursors-dark 16"
        "protonvpn connect"
      ];

      exec_shutdown = [
        "systemctl --user stop hyprland-session.target"
      ];
    };
  };
}
