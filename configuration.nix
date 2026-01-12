{ config, pkgs, ... }: { 
	
	imports = [ ./hardware-configuration.nix ];

	
	# bootloader
	boot.loader.systemd-boot.enable = false; # desativado pra usar o grub
	boot.loader.efi.canTouchEfiVariables = true;


	# grubloader
	boot.loader.grub = {
		enable = true;
		device = "nodev";
		efiSupport = true;
		useOSProber = true;
	};

	
	# kernel
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
	

	# meu usuário 
	users.users.tempz = {
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" "video" ];
	};


	# áudio e vídeo
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		pulse.enable = true;
	};
	hardware.graphics.enable = true;


	# ferramentas e programas
	environment.systemPackages = with 
	pkgs; [ git vim wget
		curl htop unzip
		networkmanagerapplet
		pavucontrol firefox
		gparted neofetch cmatrix
		cosmic-term cosmic-files
		starship pywal
		figlet vscode spotify
		discord tor-browser ];
	programs.starship.enable = true;


	# interface cosmic
	services.desktopManager.cosmic.enable = true;
	services.displayManager.cosmic-greeter.enable = true;


	# versão
	system.stateVersion = "24.11";
}
