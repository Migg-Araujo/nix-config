{pkgs, ...}: {
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Miguel Araújo";
        email = "miguelbzr6@gmail.com";
      };
    };
  };
}
