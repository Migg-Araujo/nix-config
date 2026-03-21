{pkgs, ...}:

{
  programs.wezterm = {
    enable = true;
  };

  imports = [
    ./zsh.nix
    ./starship.nix
  ];
}
