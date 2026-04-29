{
  config,
  pkgs,
  ...
}: {
  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      allow_images = true; # Habilita o suporte a ícones
      image_size = 24; # Define o tamanho dos ícones (em pixels)
      insensitive = true; # Faz com que 'Firefox' ou 'firefox' deem o mesmo resultado

      # Outras opções úteis
      width = 500;
      height = "300";
      prompt = "Search...";
    };

    style = ''
      /* Janela Principal */
      window {
        margin: 0px;
        border: 2px solid #5fb3b3;
        background-color: #1b1e28;
        border-radius: 12px;
        font-family: "JetBrainsMono Nerd Font", "Inter";
        font-size: 14px;
      }

      /* Caixa de pesquisa */
      #input {
        margin: 10px;
        border: none;
        border-radius: 8px;
        color: #a6accd;
        background-color: #232735;
        padding: 10px;
      }

      /* Container dos itens */
      #inner-box {
        margin: 10px;
        border: none;
        background-color: transparent;
      }

      /* Cada item da lista */
      #entry {
        padding: 8px;
        border-radius: 8px;
      }

      /* Item selecionado */
      #entry:selected {
        background-color: #2e3440;
        outline: none;
      }

      /* Texto do item selecionado */
      #text:selected {
        color: #add7ff;
        font-weight: bold;
      }

      /* Ajuste para os ícones */
      #img {
        margin-right: 12px;
      }

      /* Esconder a scrollbar para um look mais clean */
      #scroll {
        margin: 0px;
        border: none;
      }
    '';
  };
}
