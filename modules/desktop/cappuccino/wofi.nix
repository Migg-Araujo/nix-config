{
  config,
  pkgs,
  ...
}: {
  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      allow_images = true;
      image_size = 32;
      insensitive = true;
      no_actions = true;

      width = 400;
      height = 600;
      prompt = "Search...";
    };

    style = ''
      /* Main Window */
      window {
        margin: 0px;
        border: none;
        background-color: #0f0f0f;
        border-radius: 8px;
        font-family: "JetBrainsMono Nerd Font", "Inter";
        font-size: 12pt;
      }

      /* Search Box */
      #input {
        margin: 10px;
        border: none;
        border-radius: 0px;
        border-bottom: 2px solid #1f1f1f;
        color: #ffffff;
        background-color: #0f0f0f;
        padding: 10px;
        outline: none;
        box-shadow: none;
      }

      #input:focus {
        margin: 10px;
        border: none;
        border-radius: 0px;
        border-bottom: 2px solid #1f1f1f;
        color: #ffffff;
        background-color: #0f0f0f;
        padding: 10px;
        outline: none;
        box-shadow: none;
      }

      /* Items's Container */
      #inner-box {
        margin: 10px;
        border: none;
        background-color: transparent;
      }

      /* Item */
      #entry {
        padding: 8px;
        border: none;
        outline: none;
        border-radius: 8px;
      }

      /* Item Selected's Text */
      #text {
        color: #ffffff;
        font-weight: bold;
      }


      /* Item Selected */
      #entry:selected {
        background-color: #1f1f1f;
        border: none;
        outline: none;
      }

      /* Item Selected's Text */
      #text:selected {
        color: #6791c9;
        font-weight: bold;
      }

      /* Icons Ajusts */
      #img {
        margin-right: 20px;
      }

      /* Scrollbar */
      scrollbar {
        width: 0;
        margin: 0;
        opacity: 0;
        border: none;
      }

      overshoot {
        background-image: none;
        background-color: transparent;
      }
    '';
  };
  xdg.desktopEntries.ranger = {
    name = "Ranger";
    exec = "wezterm -e ranger";
    noDisplay = true;
  };
}
