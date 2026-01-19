{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ 
    git vim wget curl unzip
    networkmanagerapplet pavucontrol firefox
    gparted cosmic-term cosmic-files
    starship pywal figlet vscode 
    spotify discord tor-browser 
    alsa-utils alsa-ucm-conf
    alsa-tools pkgs.notion
  ];
}