{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./home.nix

    # Hyprland Configuration
    ../../modules/desktop/cappuccino/hyprland.nix
  ];

  # Exclusive PC Packages
  home.packages = with pkgs; [
    inputs.prismlauncher.packages.${system}.prismlauncher
    steam
    melonds
    gimp
  ];
}
