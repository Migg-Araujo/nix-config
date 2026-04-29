{
  pkgs,
  inputs,
  args,
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
  floating_terminal = "wezterm start --class wezterm-floating";
  editor = "wezterm -e nvim";
  browser = "librewolf --new-window";
  filemanager = "wezterm -e superfile";
  floating_filemanager = "wezterm start --class wezterm-floating -e superfile";
  bluetooth = "wezterm start --class wezterm-floating -e bluetui";
  audiomanager = "wezterm start --class wezterm-floating -e pulsemixer";
  launcher = "wofi --show drun";

  # Wallpaper Path
  wallpaper_path = "/home/migg/Wallpapers/wallpaper1.jpg";
in {
  imports = [
    ./hyprlock.nix
    ./hyprshot.nix
    ./wofi.nix
  ];

  home.packages = with pkgs; [
    ags
    swaybg
    phinger-cursors
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.phinger-cursors;
    name = "phinger-cursors-dark";
    size = 8;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.variables = ["--all"];

    plugins = with pkgs.hyprlandPlugins; [
      # hyprexpo
    ];

    settings = {
      # See https://wiki.hyprland.org/Configuring/Multi-GPU
      # env = "AQ_DRM_DEVICES,/dev/dri/card2";

      monitor = [
        "DP-1,1920x1080@60,0x0,1"
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

      #-- General
      general = {
        border_size = border_size;
        gaps_in = gaps_in;
        gaps_out = gaps_out;
        gaps_workspaces = gaps_ws;
        layout = "master";
        resize_on_border = true;
        "col.active_border" = active_border_col;
        "col.inactive_border" = inactive_border_col;
      };

      cursor.inactive_timeout = 0;

      misc = {
        disable_hyprland_logo = true;
        force_default_wallpaper = 1;
        vfr = true;
        vrr = 1;
      };

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };

      #-- Decoration
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

      #-- Animations
      animations = {
        enabled = true;
        bezier = [
          "zoom, 0.05, 0.7, 0.1, 1.0"
        ];
        animation = [
          "windows, 1, 1, zoom, slide"
          "windowsIn, 1, 1, zoom, slide"
          "windowsOut, 1, 1, zoom, slidevert"
          "windowsMove, 1, 1, zoom, slide"
          "fade, 1, 2, zoom"
          "workspaces, 1, 1, zoom, slide"
        ];
      };

      #-- Layout : Master
      master = {
        allow_small_split = false;
        special_scale_factor = 0.8;
        mfact = 0.5;
        new_on_top = false;
        orientation = "left";
        smart_resizing = true;
        drop_at_cursor = true;
      };

      #-- Window Rules
      windowrule = [
        "float on, center on, size 800 600, match:class org.pulseaudio.pavucontrol"
        "float on, center on, size 1200 800, match:class (com.ghostty.floating|wezterm-floating)"
        "float on, center on, size 900 700, match:class GalaxyBudsClient"
        "float on, center on, size 900 700, match:class (org.kde.kdeconnect.sms|org.kde.kdeconnect.app)"
      ];

      gesture = [
        "3, horizontal, workspace"
      ];

      bindm = [
        "SUPER,mouse:273,resizewindow"
        "SUPER,mouse:272,movewindow"
      ];

      bind = [
        # print
        "SHIFT, Print, exec, hyprshot -m output"
        ", Print, exec, hyprshot -m region"

        # apps
        "SUPER, T, exec, ${terminal}"
        "SUPER, F, exec, ${filemanager}"
        "SUPER, E, exec, ${editor}"
        "SUPER, B, exec, ${browser}"
        "SUPER, A, exec, ${audiomanager}"
        "SUPER, D, exec, discord"
        "SUPER, S, exec, steam"

        "SUPER_SHIFT, T, exec, ${floating_terminal}"
        "SUPER_SHIFT, F, exec, ${floating_filemanager}"
        "SUPER_SHIFT, B, exec, ${bluetooth}"

        # tpanel
        "SUPER_SHIFT, C, exec, ags toggle control-center"
        "SUPER_SHIFT, R, exec, ags quit; ${inputs.tpanel.packages.${pkgs.system}.default}/bin/tpanel"
        "SUPER, Space, exec, ${launcher}"

        # hyprland
        "SUPER, Q, killactive"
        "SUPER, C, killactive"
        "SUPER_SHIFT, Q, forcekillactive"
        "SUPER_CTRL, F, fullscreen, 0"
        "SUPER_SHIFT, Space, exec, hyprctl dispatch togglefloating; hyprctl dispatch resizeactive exact 1200 800; hyprctl dispatch centerwindow;"
        "SUPER_SHIFT, P, exec, hyprctl dispatch pin"

        # lock
        "SUPER_SHIFT, L, exec, hyprlock"

        # change focus
        "SUPER, left,  movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up,    movefocus, u"
        "SUPER, down,  movefocus, d"

        # move active
        "SUPER_SHIFT, left,  movewindow, l"
        "SUPER_SHIFT, right, movewindow, r"
        "SUPER_SHIFT, up,    movewindow, u"
        "SUPER_SHIFT, down,  movewindow, d"

        # workspaces
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"

        # send to workspaces
        "SUPER_SHIFT, 1, movetoworkspacesilent, 1"
        "SUPER_SHIFT, 2, movetoworkspacesilent, 2"
        "SUPER_SHIFT, 3, movetoworkspacesilent, 3"
        "SUPER_SHIFT, 4, movetoworkspacesilent, 4"
        "SUPER_SHIFT, 5, movetoworkspacesilent, 5"
        "SUPER_SHIFT, 6, movetoworkspacesilent, 6"
        "SUPER_SHIFT, 7, movetoworkspacesilent, 7"
      ];

      # Workspaces
      workspace = [
        "1, monitor:DP-1, default:true"
        "2, monitor:DP-1"
        "3, monitor:DP-1"
        "4, monitor:DP-1"
        "5, monitor:DP-1"
        "6, monitor:DP-1"
        "7, monitor:DP-1"
      ];

      binde = [
        # resize active
        "SUPER_CTRL, left,  resizeactive, -20 0"
        "SUPER_CTRL, right, resizeactive, 20 0"
        "SUPER_CTRL, up,    resizeactive, 0 -20"
        "SUPER_CTRL, down,  resizeactive, 0 20"
        "SUPER_CTRL, equal, exec, hyprctl dispatch layoutmsg mfact exact 0.5;"

        # move active (Floating Only)
        "SUPER_ALT, left,  moveactive, -20 0"
        "SUPER_ALT, right, moveactive, 20 0"
        "SUPER_ALT, up,    moveactive, 0 -20"
        "SUPER_ALT, down,  moveactive, 0 20"
        "SUPER_ALT, equal, exec, hyprctl dispatch centerwindow;"

        # speaker and mic volume control
        " , XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 10%+"
        " , XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 10%-"
        " , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        " , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];

      "exec-once" = [
        "${inputs.tpanel.packages.${pkgs.system}.default}/bin/tpanel"
        "swaybg -i ${wallpaper_path} -m fill"
        "hyprctl setcursor phinger-cursors-dark 16"
        "protonvpn connect"
      ];
    };
  };
}
