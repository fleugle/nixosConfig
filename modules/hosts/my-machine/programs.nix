{self, inputs, ...}: {

  flake.nixosModules.systemPrograms = { pkgs, lib, ... }:   

  {

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget

      # Fastfetch
      fastfetch

      #gnome-extension-manager
    ];

    # Programms with config
    programs = {

      fish = {
        enable = true;
        shellAliases = {
          nxr = "sudo nixos-rebuild";
          c = "clear";
          nxcg = "sudo nix-collect-garbage"; 
          ff = "fastfetch";
          opn = "xdg-open";
        };
        interactiveShellInit = ''
          set fish_greeting
        '';
      };


      bash = {
        enable = true;
        shellAliases = {
          nxr = "sudo nixos-rebuild";
          c = "clear";
          nxcg = "sudo nix-collect-garbage"; 
          ff = "fastfetch";
          opn = "xdg-open";
        };
      };

      starship = {
        enable = true;
        settings = builtins.fromTOML self.colorThemes.currentThemes.starship-conf;
      };

      java = {
        enable = true;
      };
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };


  };


  flake.homeModules.userPrograms = { config, pkgs, inputs, ... }:
  let
    #zen-flake = builtins.getFlake "github:0xc000022070/zen-browser-flake";

    ns = pkgs.writeShellApplication {
      name = "ns";
      runtimeInputs = with pkgs; [
        fzf
        nix-search-tv
      ];
      text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
    };
  in
  {
    # Importing Zen browser HM module
    imports = [ inputs.zen-browser.homeModules.beta ];

    # User-only packages
    home.packages = with pkgs; [
      # Messengers -------------------------------------
      discord
      telegram-desktop
      # ------------------------------------------------

      # Jetbrains --------------------------------------
      jetbrains.idea
      # ------------------------------------------------

      # School -----------------------------------------
      #teams # Microsoft teams
      teams-for-linux
      # ------------------------------------------------

      # Nix-seach-tv -----------------------------------
      ns
      # ------------------------------------------------

      # Readest ----------------------------------------
      readest
      # ------------------------------------------------

      # Davinci Resolve --------------------------------
      #davinci-resolve
      # ------------------------------------------------
    ];

    
    programs ={

      fzf = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
      };

      # VS Code with extensions
      vscode = {
        enable = true;

        profiles.default.extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide # nix language support
        ];
      };

      # Zen Browser and its config
      zen-browser = {
        enable = true;
        nativeMessagingHosts = [pkgs.firefoxpwa];
      };

      git = {
        enable = true;
        userName = "Fleugle⭐";
        userEmail = "nikita.elagin@outlook.com";
      };

      

      #kitty = {
      #  enable = true;
      #  font.size = 12;
      #  font.name = "AdwaitaMono Nerd Font";
      #};

      wezterm = {
        enable = true;
        extraConfig = ''
          local wezterm = require 'wezterm'

          local config = wezterm.config_builder()

          config.font = wezterm.font("AdwaitaMono Nerd Font")
          config.font_size = 13

          config.cursor_blink_rate = 800

          config.window_decorations = 'NONE'
          config.enable_tab_bar = false

          config.color_scheme = 'carbonfox'

          config.default_cursor_style = 'SteadyBar'

          config.colors = {
            cursor_bg = "#${self.colorThemes.currentColorTheme.foreground}",
            cursor_border = "#${self.colorThemes.currentColorTheme.foreground}",
            background = "#${self.colorThemes.currentColorTheme.background}",
          }

          config.window_background_opacity = 0.7

          return config
        '';
      };



      #ghostty = {
      #  enable = true;
      #  #package = pkgs.ghostty-bin;
      #  settings = {
      #    background = "#${self.colorThemes.currentColorTheme.background}";
      #    #background-opacity = 0.7;

      #    cursor-style = "bar";

      #    font-family = "AdwaitaMono Nerd Font";

      #    font-size = 12;

      #    theme = "Adwaita Dark";

      #  };
      #};


    };
  };
}
