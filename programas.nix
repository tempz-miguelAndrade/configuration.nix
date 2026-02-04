{ pkgs, ... }: 

let
  # --- CATEGORIA: ESSENCIAIS E TERMINAL ---
  essenciais = with pkgs; [
    git           # Controle de versão
    vim           # Editor de texto via terminal
    wget          # Download de arquivos via CLI
    curl          # Transferência de dados com URLs
    unzip         # Descompactador de arquivos
    starship      # Prompt personalizado
    ncdu          # Analisador de uso de disco
  ];

  # --- CATEGORIA: COMUNICAÇÃO E ENTRETENIMENTO ---
  social = with pkgs; [
    discord       # Chat e comunidades
    spotify       # Música
    obsidian      # Notas e organização
    tor-browser   # Navegação privada
    firefox       # Navegador principal
  ];

  # --- CATEGORIA: DESENVOLVIMENTO E TOOLS ---
  dev = with pkgs; [
    vscode        # Editor de código
    figlet        # Letras grandes no terminal
    pywal         # Gerador de cores baseado no wallpaper
  ];

  # --- CATEGORIA: SISTEMA E HARDWARE (Otimizado para i5 13th Gen) ---
  sistema = with pkgs; [
    gparted       # Gerenciador de partições
    pavucontrol   # Controle de áudio visual (GUI)
    networkmanagerapplet # Ícone de Wi-Fi
    alsa-utils    # amixer, alsamixer
    alsa-tools    # Ferramentas avançadas
    libva-utils   # vainfo para testar vídeo
    intel-gpu-tools # Monitor da GPU Intel (intel_gpu_top)
    pkgs.wdisplays      # GUI para gerenciar telas (substituto visual do Fn+F7)
    pkgs.wev            # Wayland Event Viewer (para debugar se a tecla está respondendo)
    pkgs.brightnessctl  # Controle de brilho via terminal (caso o Fn de brilho falhe)
  ];

  # --- CATEGORIA: COSMIC NATIVE ---
  cosmic-apps = with pkgs; [
    cosmic-term   # Terminal nativo
    cosmic-files  # Gerenciador de arquivos nativo
  ];

  # --- CATEGORIA: ESTÉTICA E DIVERSÃO (Movido do visual.nix) ---
  estetica = with pkgs; [
    cava          # Visualizador de som
    neofetch      # Info do sistema
    btop          # Monitor de recursos visual
    cmatrix       # Efeito Matrix clássico
    neo           # Matrix moderno
    peaclock      # Relógio de terminal
    sl            # A locomotiva
  ];

in {
  # Juntando todas as listas em um único local
  environment.systemPackages = 
    essenciais ++ 
    social ++ 
    dev ++ 
    sistema ++ 
    cosmic-apps ++ 
    estetica;
}