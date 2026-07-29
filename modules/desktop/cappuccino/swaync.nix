{pkgs, ...}: {
  home.packages = [
    pkgs.libnotify
  ];

  services.swaync = {
    enable = true;

    settings = {
      positionX = "right";
      positionY = "top";
      layer = "top";
      control-center-margin-top = 10;
      control-center-margin-bottom = 10;
      control-center-margin-right = 10;
      control-center-margin-left = 10;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      fit-to-screen = true;

      widgets = [
        "inhibitors"
        "title"
        "dnd"
        "mpris"
        "notifications"
      ];

      widget-config = {
        title = {
          text = "Notificatons";
          clear-all-button = true;
          button-text = "Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        mpris = {
          image-size = 96;
          image-radius = 8;
        };
      };
    };

    style = ''
      @define-color bg-main #0f0f0f;
      @define-color bg-element #1f1f1f;
      @define-color accent #6791c9;
      @define-color text-main #ffffff;

      * {
        font-family: "JetBrainsMono Nerd Font";
        background-clip: padding-box;
      }

      .floating {
        background: transparent;
      }

      .floating .notification {
        background-color: @bg-element;
        border-radius: 8px;
        padding: 14px;
        margin: 6px 0px;
      }

      .notification-content .summary {
        color: @accent;
        font-size: 11pt;
        font-weight: bold;
      }

      .notification-content .body {
        color: @text-main;
        font-size: 10pt;
      }

      .control-center {
        background-color: @bg-main;
        border-radius: 8px;
        padding: 10px;
        width: 400px;
      }

      .control-center .notification-row .notification {
        background-color: @bg-element;
        border-radius: 8px;
        margin: 6px 4px;
        padding: 12px;
      }

      .control-center .notification-row .notification:hover {
        background-color: @accent;
      }
      .control-center .notification-row .notification:hover .summary {
        color: @bg-element;
      }
      .control-center .notification-row .notification:hover .body {
        color: @bg-element;
      }

      .widget-title {
        background-color: @bg-element;
        margin: 8px;
        padding: 10px;
        border-radius: 8px;
      }

      .widget-title > label {
        color: @text-main;
        font-size: 12pt;
        font-weight: bold;
      }

      .widget-title > button {
        background-color: @bg-main;
        color: @text-main;
        border-radius: 6px;
        padding: 4px 10px;
        font-size: 10pt;
        transition: all 0.3s ease-in-out;
      }
      .widget-title > button:hover {
        background-color: @accent;
        color: @bg-main;
      }

      .widget-dnd {
        background-color: @bg-element;
        margin: 8px;
        padding: 10px;
        border-radius: 8px;
        color: @text-main;
        font-size: 11pt;
      }
      .widget-dnd > switch {
        font-size: 10pt;
        border-radius: 999px;
        background: @bg-main;
      }
      .widget-dnd > switch:checked {
        background: @accent;
      }

      .widget-mpris {
        background-color: @bg-element;
        margin: 8px;
        padding: 12px;
        border-radius: 8px;
        color: @text-main;
      }
      .widget-mpris-player {
        padding: 4px;
      }
      .widget-mpris-title {
        font-weight: bold;
        font-size: 11pt;
        color: @accent;
      }
      .widget-mpris-subtitle {
        font-size: 9pt;
        color: @text-main;
      }
      .widget-mpris-buttons button {
        color: @text-main;
        background-color: @bg-main;
        border-radius: 6px;
        padding: 4px;
        margin: 0 4px;
      }
      .widget-mpris-buttons button:hover {
        background-color: @accent;
        color: @bg-main;
      }
    '';
  };
}
