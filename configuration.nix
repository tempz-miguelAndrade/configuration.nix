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

    
    # kernel - Ótima escolha para hardware novo (Raptor Lake)
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # rede e hardware
    networking.hostName = "nixos-tempz";
    networking.networkmanager.enable = true;
    nixpkgs.config.allowUnfree = true;

    # otimizações da interface cosmic
    nix.settings.download-buffer-size = 250000000;
    nix.settings.max-jobs = 1;
    hardware.enableAllFirmware = true;

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
        extraGroups = [ "wheel" "networkmanager" "video" "audio" ]; # Adicionei "audio" por garantia
    };

    # --- ÁUDIO (HDA LEGACY ESTÁVEL) ---

    security.rtkit.enable = true;

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    environment.systemPackages = with pkgs; [
        alsa-utils
        alsa-ucm-conf
    ];

    # Desativa o stack AVS (kernel novo)
    boot.blacklistedKernelModules = [
        "snd_soc_avs"
    ];

    # Força driver HDA legacy (funciona em Raptor Lake)
    boot.extraModprobeConfig = ''
        options snd-hda-intel dmic_detect=0
    '';

# -------------------------------
    hardware.graphics.enable = true;

    # ferramentas e programas
    programs.starship.enable = true;

    # interface cosmic
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;

    # versão
    system.stateVersion = "24.11";
}
