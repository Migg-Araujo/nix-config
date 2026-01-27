{ config, pkgs, inputs, ... }:

{
  # --- SOM (Pipewire) ---
  # O Pipewire é moderno e essencial para áudio de baixa latência e Wayland
  services.pulseaudio.enable = false; # Desativa o antigo para não dar conflito
  security.rtkit.enable = true;      # Necessário para o Pipewire ter prioridade
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true; # Descomente se for trabalhar com produção musical
  };

  # --- BLUETOOTH ---
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; # Gerenciador gráfico de bluetooth (funciona bem no i3 e Hyprland)

  # --- IMPRESSÃO (CUPS) ---
  services.printing.enable = true;

  # --- EXTRAS ÚTEIS NO CORE ---
  # Habilita o suporte a discos externos e pendrives (montagem automática)
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  services.displayManager.ly = {
    enable = true;
    # Configurações opcionais para o Ly (estética cafeteria)
    settings = {
      #animation = "matrix"; # Aquela animação clássica de queda de caracteres
      restore = true;       # Restaura a última sessão usada
    };
  };
}
