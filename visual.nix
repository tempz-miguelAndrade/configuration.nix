{ pkgs, ... }: {
  # Isso cria atalhos (aliases) para você abrir os apps do dashboard rápido
  programs.bash.shellAliases = {
    dash1 = "cmatrix & neofetch & cava"; # Exemplo de combo
    rebuild = "sudo nixos-rebuild switch";
  };

  # Ativa o Starship (aquele terminal com ícones)
  programs.starship.enable = true;

  # Configuração para abrir apps ao iniciar (Autostart)
  # Nota: No COSMIC, isso geralmente é feito via interface, 
  # mas vamos garantir que as ferramentas de dashboard estejam prontas.
  environment.systemPackages = with pkgs; [
    cava    
    peaclock
    neo
    neofetch
    btop
    ncdu
    cool-retro-term   
  ];

  # Se você quiser criar apelidos (aliases), coloque-os aqui fora:
  environment.shellAliases = {
    ll = "ls -l";
  };
}
