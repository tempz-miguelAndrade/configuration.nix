{ config, pkgs, ... }: { 
    
    imports = [ ./hardware-configuration.nix ./programas.nix ./visual.nix ];

    # bootloader
    boot.loader.systemd-boot.enable = false; 
    boot.loader.efi.canTouchEfiVariables = true;

    # grubloader
    boot.loader.grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
    };
    
    # kernel
    # Mantenha o latest, o Raptor Lake gosta de kernels novos.
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # rede e hardware
    networking.hostName = "nixos-tempz";
    networking.networkmanager.enable = true;
    nixpkgs.config.allowUnfree = true;

    # otimizações da interface cosmic
    nix.settings.download-buffer-size = 250000000;
    nix.settings.max-jobs = 1;

    # FIRMWARE: Isso é vital para o Raptor Lake
    hardware.enableAllFirmware = true;
    hardware.firmware = [ pkgs.sof-firmware ]; 

    # teclado
    console.keyMap = "br-abnt2";
    i18n.defaultLocale = "pt_BR.UTF-8";

    # teclado pra interface
    services.xserver.xkb = {
        layout = "br";
        variant = "";
    };
    
    # usuário 
    users.users.tempz = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    };

    # --- ÁUDIO CORRETO (PIPEWIRE + SOF) ---
    
    # RTKit dá prioridade ao processo de áudio para não picotar
    security.rtkit.enable = true;

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # wireplumber é o gerenciador de sessão moderno, vamos garantir que está ativo
        wireplumber.enable = true; 
    };

    # Pacotes úteis para controle de volume caso a interface bugue
    environment.systemPackages = with pkgs; [
        pavucontrol # Controle de volume "clássico" e super confiável
        alsa-utils
    ];

    # --- CORREÇÃO PARA CHIP CONEXANT (RAPTOR LAKE) ---
  boot.kernelParams = [ 
    "snd_hda_intel.power_save=0" 
    "snd_hda_intel.power_save_controller=N"
    # Tenta forçar o reconhecimento dos pinos de áudio
    "snd_hda_intel.model=laptop-dmic" 
  ];

  boot.extraModprobeConfig = ''
    # Algumas placas Conexant precisam deste modelo específico para "acordar"
    options snd-hda-intel model=alc285-hp-spectre
  '';

    hardware.graphics.enable = true;

    # ferramentas e programas
    programs.starship.enable = true;

    # interface cosmic
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;

    # versão
    system.stateVersion = "24.11";
}