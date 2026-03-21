{pkgs, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;

      preload = ["/home/migg/Wallpapers/wallpaper1.jpg"];

      wallpaper = [",/home/migg/Wallpapers/wallpaper1.jpg"];
    };
  };
}
