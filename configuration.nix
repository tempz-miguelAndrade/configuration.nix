{ config, pkgs, ... }: { 


    imports = [ ./hardware-configuration.nix ./programas.nix ./visual.nix ];




    # Bootloader
  boot.loader = {
    efi = {
      # Mude para false para aceitar o modo Removível
      canTouchEfiVariables = false; 
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      configurationLimit = 3;
      efiInstallAsRemovable = true; 
    };
    timeout = 5;
  };




    # Kernel mais recente
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Parâmetros para melhorar a performance da placa Intel e bateria
  boot.kernelParams = [ "i915.enable_fbc=1" "i915.enable_guc=2" ];

  # Aceleração de hardware para Intel (essencial para vídeos e COSMIC)
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
    ];
  };




  # Rede e Hardware
  networking.hostName = "nixos-tempz";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false; # Evita quedas de Wi-Fi em notebooks

  # Controle térmico para processadores Intel modernos
  services.thermald.enable = true;

  # Bluetooth (Essencial para notebooks Acer)
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  nixpkgs.config.allowUnfree = true;

  # Otimizações de Sistema e Nix Store
  nix.settings = {
    max-jobs = "auto"; 
    auto-optimise-store = true; # Crucial para economizar espaço no seu SSD de 512GB
    experimental-features = [ "nix-command" "flakes" ]; # Habilita as ferramentas modernas do Nix
    download-buffer-size = 67108864; # 64MB: mais estável que 250MB para downloads grandes
  };

  # Manutenção Automática
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Mantém a performance do SSD NVMe ao longo do tempo
  services.fstrim.enable = true;

  # Deixa o sistema mais fluido usando compressão na RAM
  zramSwap.enable = true;

  hardware.enableAllFirmware = true;




    # Teclado e Idioma
    i18n.defaultLocale = "pt_BR.UTF-8";

    # Configura o console (TTY)
    console.keyMap = "br-abnt2";

    # Configura o teclado para o X11 e Wayland (COSMIC)
    services.xserver.xkb = {
        layout = "br";
        variant = "";
    };

    # Garante que o layout do teclado seja aplicado corretamente no ambiente Wayland
    services.xserver.exportConfiguration = true;




    # Usuário
    users.users.tempz = {
        isNormalUser = true;
        extraGroups = [ 
            "wheel"           # Permite usar sudo
            "networkmanager"  # Permite trocar de Wi-Fi
            "video"           # Acesso à placa de vídeo e brilho da tela
            "audio"           # Acesso direto ao som
            "lp"              # Gerenciamento de Bluetooth
            "input"           # Controle de periféricos
        ];
    };




    # Áudio (Pipewire de alta performance)
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true; # Ótimo para compatibilidade com apps antigos/jogos
        pulse.enable = true;
        jack.enable = true;      # Suporte a áudio profissional/baixa latência
    };

    # Configuração de Monitores (X11 Fallback)
    # Nota: O COSMIC (Wayland) tem seu próprio gestor, mas isso ajuda no login (Greeter)
    services.xserver.displayManager.setupCommands = ''
        ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
                                       --output eDP-1 --mode 1366x768 --pos 1920x0 --rotate normal
    '';




    # Interface COSMIC
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;

    # Otimização para apps Electron no COSMIC/Wayland
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    # Fontes necessárias para o visual e ícones do Starship
    fonts.packages = with pkgs; [
        nerd-fonts.fira-code
        nerd-fonts.jetbrains-mono
    ];

    # Starship (Prompt do terminal)
    programs.starship.enable = true;





    # Versão do sistema (Não altere)
    system.stateVersion = "24.11";

} 