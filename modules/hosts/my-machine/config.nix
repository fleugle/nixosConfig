
{self, inputs, ...}: {

  # NixOS config
  flake.nixosModules.nixOSConfig = { pkgs, lib, ... }: 
  {
    
    imports = [
      self.nixosModules.binCaches

      self.nixosModules.nixOSHardware

      self.nixosModules.HMConfig
      self.nixosModules.stylix

      self.nixosModules.gnome
      self.nixosModules.niri
      #self.nixosModules.driftwm

      self.nixosModules.systemPrograms
    ];

    users = {

      defaultUserShell = pkgs.fish;    

      users = {

        fleugle = {
          isNormalUser = true;
          description = "Nikita Elagin";
          extraGroups = [ "networkmanager" "wheel" ];
        };

      };
    };

    nix.settings.experimental-features = ["nix-command" "flakes"];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Enable CUPS to print documents.
    services.printing.enable = true;
    
    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;
    
    hardware = {
      graphics = {
        enable = true;
        extraPackages = [ pkgs.mesa ];
      };
    };

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    time.timeZone = "Europe/Madrid";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "es_ES.UTF-8";
      LC_IDENTIFICATION = "es_ES.UTF-8";
      LC_MEASUREMENT = "es_ES.UTF-8";
      LC_MONETARY = "es_ES.UTF-8";
      LC_NAME = "es_ES.UTF-8";
      LC_NUMERIC = "es_ES.UTF-8";
      LC_PAPER = "es_ES.UTF-8";
      LC_TELEPHONE = "es_ES.UTF-8";
      LC_TIME = "es_ES.UTF-8";
    };

    networking.hostName = "nixOS"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;
    
      # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;



    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
    
    

    
    # Install firefox.
    #programs.firefox.enable = false;



 
    # Fonts --------------------------------------------------------
    fonts.packages = [
      pkgs.noto-fonts
      pkgs.noto-fonts-cjk-sans
      pkgs.noto-fonts-color-emoji

      pkgs.nerd-fonts.adwaita-mono


      inputs.apple-fonts.packages.${pkgs.system}.sf-mono-nerd
      inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd
      inputs.apple-fonts.packages.${pkgs.system}.ny
    ];
    # --------------------------------------------------------------

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.11";

  };


  # HM module.
  flake.nixosModules.HMConfig = { pkgs, ... }:
  {

    home-manager.sharedModules = [
      { 
        home.stateVersion = "25.11"; 
        home.enableNixpkgsReleaseCheck = false;

        gtk.iconTheme = self.dots.configs.currentIconTheme pkgs;
      }
      self.homeModules.userPrograms
    ];

    
    home-manager.users.fleugle = {
      imports = [ self.homeModules.fleuglePrograms ];
    };
  
  };
}