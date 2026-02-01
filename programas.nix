{ pkgs, ... }: 

let
  # --- CATEGORIA: ESSENCIAIS E TERMINAL ---
  essenciais = with pkgs; [
    git           # Controle de versão
    vim           # Editor de texto via terminal
    wget          # Download de arquivos via CLI
    curl          # Transferência de dados com URLs
    unzip         # Descompactador de arquivos
    starship      # Prompt personalizado (que você já usa)
    btop          # Monitor de recursos (bonito e funcional)
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
    figlet        # Letras grandes no terminal (usado no visual)
    pywal         # Gerador de cores baseado no wallpaper
  ];

  # --- CATEGORIA: SISTEMA E HARDWARE (Otimizado para seu i5/Acer) ---
  sistema = with pkgs; [
    gparted       # Gerenciador de partições
    pavucontrol   # Controle de áudio visual (GUI)
    networkmanagerapplet # Ícone de Wi-Fi na barra
    alsa-utils    # Ferramentas de áudio (amixer, alsamixer)
    alsa-tools    # Ferramentas avançadas de áudio
    libva-utils   # Para testar aceleração de vídeo (vainfo)
    intel-gpu-tools # Para monitorar sua GPU Intel 13th Gen
  ];

  # --- CATEGORIA: COSMIC NATIVE ---
  cosmic-apps = with pkgs; [
    cosmic-term   # Terminal nativo do COSMIC
    cosmic-files  # Gerenciador de arquivos nativo
  ];

in {
  # Aqui nós juntamos todas as listas em uma só
  environment.systemPackages = essenciais ++ social ++ dev ++ sistema ++ cosmic-apps;
}