{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Pipewire Sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Printing (CUPS)
  services.printing.enable = true;

  # Extra Utilities
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    udiskie
  ];

  systemd.user.services.udiskie = {
    description = "udiskie automounter";
    wantedBy = ["graphical-session.target"];
    serviceConfig.ExecStart = "${pkgs.udiskie}/bin/udiskie";
  };

  # LY Display Manager
  services.displayManager.ly = {
    enable = true;
    settings = {
      restore = true;
    };
  };
}
