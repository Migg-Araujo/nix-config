{
  config,
  pkgs,
  ...
}: let
  # Poimandres colors
  poimandres = {
    bg = "#0f0f0f";
    fg = "#a6accd";
    blue = "#89ddff";
    teal = "#5de4c7";
    pink = "#d0679d";
    selection = "#303340";
  };
in {
  home.packages = [
    pkgs.bluetui
  ];

  xdg.configFile."bluetui/style.toml".text = ''
    [style]
    # Background Colors
    background = "${poimandres.bg}"
    foreground = "${poimandres.fg}"

    # Border Color
    border_color = "${poimandres.blue}"

    # Selection Colors
    selection_bg = "${poimandres.selection}"
    selection_fg = "${poimandres.teal}"

    # Cases Colors
    success_color = "${poimandres.teal}"
    error_color = "${poimandres.pink}"
  '';
}
