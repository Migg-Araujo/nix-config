{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./home.nix

    # Hyprland Configuration
    ../../modules/desktop/hyprland.nix
  ];

  # Exclusive PC Packages
  home.packages = with pkgs; [
    inputs.tpanel.packages.${system}.default
  ];
}
