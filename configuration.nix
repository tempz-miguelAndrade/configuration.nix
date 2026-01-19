
 { config, pkgs, ... }: { 

    imports = [ ./hardware-configuration.nix ./programas.nix ./visual.nix ];


    # Bootloader (Grub)
    boot.loader.systemd-boot.enable = false; 

    boot.loader.efi.canTouchEfiVariables = true;

    boot.loader.grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;

    };


    # Kernel mais recente
    boot.kernelPackages = pkgs.linuxPackages_latest;


    # Rede e Hardware
    networking.hostName = "nixos-tempz";

    networking.networkmanager.enable = true;

    nixpkgs.config.allowUnfree = true;


    # Otimizações
    nix.settings.download-buffer-size = 250000000;

    nix.settings.max-jobs = 1;

    hardware.enableAllFirmware = true;


    # Teclado e Idioma
    console.keyMap = "br-abnt2";

    i18n.defaultLocale = "pt_BR.UTF-8";

    services.xserver.xkb = {
        layout = "br";
        variant = "";
    };


    # Usuário
    users.users.tempz = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "video" ];
    };


    # Áudio e Vídeo
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
    };

    hardware.graphics.enable = true;

    services.xserver.displayManager.setupCommands = ''
        ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output eDP-1 --mode 1366x768 --pos 1920x0 --rotate normal
    '';


    # Interface COSMIC
    services.desktopManager.cosmic.enable = true;

    services.displayManager.cosmic-greeter.enable = true;

    programs.starship.enable = true;


    # Versão do sistema (Não altere)
    system.stateVersion = "24.11";

} 