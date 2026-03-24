{ pkgs, ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      format = "$character$username $directory$git_branch$git_status[❯](bold yellow)[❯](bold purple)[❯](bold blue) ";

      username = {
        style_user = "bold green";
        format = "[$user]($style)";
        show_always = true;
      };

      directory = {
        style = "bold blue";
        truncation_length = 3;
        truncate_to_repo = false;
      };

      character = {
        success_symbol = "[  ➜](bold green)";
        error_symbol = "[  ➜](bold red)";
      };

      git_branch.format = "[$symbol$branch]($style yellow )";
    };
  };
}
