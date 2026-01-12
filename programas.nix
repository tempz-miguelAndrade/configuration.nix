{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ 
    git vim wget curl htop unzip
    networkmanagerapplet pavucontrol firefox
    gparted neofetch cmatrix
    cosmic-term cosmic-files
    starship pywal figlet vscode 
    spotify discord tor-browser 
  ];
}