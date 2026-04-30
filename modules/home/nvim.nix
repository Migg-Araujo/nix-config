{
  pkgs,
  inputs,
  ...
}: {
  home.file = {
    ".config/nvim" = {
      recursive = true;
      source = "${inputs.tnvim.packages.x86_64-linux.default}";
    };
  };

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      withPython3 = true;
      withNodeJs = true;
      withRuby = true;
    };
  };

  home = {
    packages = with pkgs; [
      gcc
      neovide

      # nix
      nil # Language Server
      statix # Lints and suggestions
      deadnix # Find and remove unused
      alejandra # Code Formatter

      # lua
      luarocks

      # ts
      typescript

      gdu
      ripgrep
    ];
  };
}
