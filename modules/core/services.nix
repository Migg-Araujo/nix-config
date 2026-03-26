{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    protonvpn-gui
    proton-vpn-cli
    udiskie
  ];

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

  # Proton VPN
  networking.firewall.checkReversePath = false;

  # Extra Utilities
  services.gvfs.enable = true;
  services.udisks2.enable = true;

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
