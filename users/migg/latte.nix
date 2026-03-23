{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./home.nix

    # I3WM Configuration
    ../../modules/desktop/i3wm.nix
  ];

  # Exclusive Notebook Packages
  home.packages = with pkgs; [
    dmenu
    i3status
    feh
  ];
}
