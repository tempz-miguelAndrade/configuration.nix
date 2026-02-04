{ pkgs, ... }: {
  programs.bash.shellAliases = {
    ll = "ls -l";
    rebuild = "sudo nixos-rebuild switch -I nixos-config=/sudo nixos-rebuild switch -I nixos-config=//home/tempz/Documentos/minha-config-nixOS/configuration.nix";
    limpar = "sudo nix-collect-garbage -d";
    matrix = "neo -D";
  };

  programs.starship.enable = true;
  
  # Variáveis de ambiente para o Pywal ou Temas
  environment.sessionVariables = {
    EDITOR = "vim";
  };
}
