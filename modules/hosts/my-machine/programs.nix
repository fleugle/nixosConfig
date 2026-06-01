{self, inputs, ...}: {

  # All system-wide programs and settings for them
  flake.nixosModules.systemPrograms = { pkgs, ... }:   
  {

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      fastfetch
      tree
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
        settings = builtins.fromTOML self.dots.currentConfigs.starship-conf;
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

  # All user-wide programs and settings for them for SHARED module (for every user on the system)
  flake.homeModules.userPrograms = { config, pkgs, ... }:
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
    
    imports = [ inputs.zen-browser-flake.homeModules.beta ];

    # User-only packages
    home.packages = with pkgs; [
      
      # Nix-seach-tv -----------------------------------
      ns
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

        profiles.default = {
          extensions = with pkgs.vscode-extensions; [
            jnoortheen.nix-ide # nix language support
          ];
          userSettings = {
            "files.autoSave" = "afterDelay";  # or "onFocusChange", "onWindowChange", "off"
            "explorer.confirmDelete" = false;
            "git.confirmSync"= false;
            "workbench.colorCustomizations" = {
              "[Stylix]" = {
                "editor.wordHighlightBackground" = "#${self.dots.currentColorConfs.colors.secondary-accent}20";
                "editor.selectionBackground" = "#${self.dots.currentColorConfs.colors.accent}20";
                "sideBar.background" = "#${self.dots.currentColorConfs.base16Scheme.base00}";
                "activityBar.background" = "#${self.dots.currentColorConfs.base16Scheme.base00}";
                "editor.background" = "#${self.dots.currentColorConfs.base16Scheme.base01}";
              };
            };
          };
        };
      };

      
     

      kitty = {
       enable = true;
      };

      wezterm = {
        enable = true;
        extraConfig = ''
          local wezterm = require 'wezterm'

          local config = wezterm.config_builder()

          config.cursor_blink_rate = 800

          config.window_decorations = 'NONE'
          config.enable_tab_bar = false

          config.color_scheme = 'carbonfox'

          config.default_cursor_style = 'SteadyBar'

          config.colors = {
            cursor_bg = "#${self.dots.currentColorConfs.colors.foreground}",
            cursor_border = "#${self.dots.currentColorConfs.colors.foreground}",
          }

          config.window_background_opacity = 0.7

          return config
        '';
      };



      ghostty = {
       enable = true;
       #package = pkgs.ghostty-bin;
       settings = {
         background-opacity = 0.7;

         cursor-style = "bar";

         theme = "Adwaita Dark";

       };
      };


    };
  };

  # All fleugle user programs and settings for them
  flake.homeModules.fleuglePrograms = { config, pkgs, ... }: {

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

      # Entertainment ----------------------------------
      readest # A convenient and cool Epub reader
      # ------------------------------------------------

      # Davinci Resolve --------------------------------
      #davinci-resolve
      # ------------------------------------------------

      # Tool to re-encode media files ------------------
      ffmpeg
      # ------------------------------------------------

      # Obsidian ---------------------------------------
      obsidian
      # ------------------------------------------------
    ];

    programs = {

      # Zen Browser and its config
      zen-browser = {
        enable = true;
        nativeMessagingHosts = [pkgs.firefoxpwa];
      };

      git = {
        enable = true;
        settings = {
          user.name = "Fleugle⭐";
          user.email = "nikita.elagin@outlook.com";
        };
      };
    };
  };
}
