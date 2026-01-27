{ config, pkgs, inputs, ... }:

{
    # Fonts
    fonts.packages = with pkgs.nerd-fonts; [
    fira-code
    jetbrains-mono
    bigblue-terminal
  ];

}
