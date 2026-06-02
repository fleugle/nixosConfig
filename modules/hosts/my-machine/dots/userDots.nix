{ self, inputs, ... }: {
  flake.dots = rec {

    # Colors configs for stylix and other programs that can use them, for SHARED module (for every user on the system)
    # You can define multiple color schemes here and switch between them by changing the `currentColorConfs` attribute.
    # The `base16Scheme` attribute is structured to be compatible with base16 themes, which makes it easier to create new color schemes by simply providing different base16 values.
    # The `colors` attribute is a more direct mapping of the colors used in the system, which can be used by programs that don't follow the base16 structure.
   
    # Example of how to define a custom color scheme:
    purpleBlueCustom = rec {
      base16Scheme = {
        base00 = "171717";  # background - darkest
        base01 = "222222";  # slightly lighter background
        base02 = "353535";  # background-lighter - selection bg
        base03 = "535353";  # inactive-accent - comments
        base04 = "8080a0";  # dark UI text
        base05 = "C0C0C0";  # foreground - main text
        base06 = "d6d6d6";  # light foreground
        base07 = "e9e9e9";  # lightest - rarely used
        base08 = "d46f88";  # quaternary-accent - red (errors)
        base09 = "D8C575";  # tertiary-accent - yellow (numbers)
        base0A = "c9b860";  # yellow variant (warnings)
        base0B = "75D8C5";  # secondary-accent - cyan (strings)
        base0C = "60c9b8";  # cyan variant
        base0D = "8899dd";  # blue-purple (functions)
        base0E = "C575D8";  # accent - purple (keywords)
        base0F = "c47d5a";  # dark-accent - special}
      };
      
      colors = {
        background         = base16Scheme.base00;
        background-lighter = base16Scheme.base02;
        foreground         = base16Scheme.base05;
        dark-accent        = "261E71";
        accent             = base16Scheme.base0E;
        secondary-accent   = base16Scheme.base0B;
        tertiary-accent    = base16Scheme.base09;
        quaternary-accent  = base16Scheme.base08;
        inactive-accent    = base16Scheme.base03;
        highlight          = base16Scheme.base06;
        shadow             = base16Scheme.base00;
        warm-accent        = base16Scheme.base0F;
      };
    };

    default = rec {
      base16Scheme = {
        base00 = "171717";
        base01 = "1a1a1a";
        base02 = "222222";
        base03 = "474747";
        base04 = "7d7d7d";
        base05 = "929292";
        base06 = "cacaca";
        base07 = "e0e0e0";
        base08 = "e25a58";
        base09 = "d2744c";
        base0A = "d4b146";
        base0B = "a6b63f";
        base0C = "3ebca7";
        base0D = "369ccf";
        base0E = "8d66f9";
        base0F = "d650a7";
      };

      colors = {
        background         = base16Scheme.base00;
        background-lighter = base16Scheme.base02;
        foreground         = base16Scheme.base05;
        dark-accent        = "261E71";
        accent             = base16Scheme.base0F;
        secondary-accent   = base16Scheme.base0C;
        tertiary-accent    = base16Scheme.base0A;
        quaternary-accent  = base16Scheme.base0E;
        inactive-accent    = base16Scheme.base03;
        highlight          = base16Scheme.base06;
        shadow             = base16Scheme.base00;
        warm-accent        = base16Scheme.base0F;
      };
    };

    # The `paths` attribute is for any file paths that you want to manage through this configuration, such as wallpapers or config file paths for other programs.
    paths = {
      wallpaper-absolute-path = "/etc/nixos/home/dots/wallpapers/purple.jpg";
      
      system-config-path = "/etc/nixos";
    };

    currentColorConfs = default;

    configs = rec {
      fastfetch-conf = {
        # The "$schema" key needs to be quoted because '$' is a special character in Nix
        "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

        # We will handle the logo path declaratively below.
        # Fastfetch itself will expand the tilde '~' at runtime.
        logo = {
          source = "/etc/nixos/home/dots/fastfetch-logos/nixos-purple-blue.png";
          type = "auto";
          height = 17;
          width = 36;
          padding = {
            top = 3;
            bottom = 3;
            left = 2;

          };
          #color = {
          #  "1" = "#${dark-accent}";
          #  "2" = "#${accent}";
          #};
        };

        display = {
          separator = " ";
        };

      
        modules = [
          "break"
          "break"
          "break"
          {
            type = "custom";
            format = "               ";
          }
          "break"
          {
            type = "title";
            keyWidth = 10;
          }
          "break"
          {
            type = "os";
            key = " ";
            keyColor = "34"; # Note: JSON numbers can be strings in Nix if the program expects a string
          }
          {
            type = "kernel";
            key = " ";
            keyColor = "34";
          }
          {
            type = "packages";
            format = "{}";
            key = " ";
            keyColor = "34";
          }
          {
            type = "shell";
            key = " ";
            keyColor = "34";
          }
          {
            type = "terminal";
            key = " ";
            keyColor = "34";
          }
          {
            type = "wm";
            key = " ";
            keyColor = "34";
          }
          {
            type = "cursor";
            key = " ";
            keyColor = "34";
          }
          {
            type = "terminalfont";
            key = " ";
            keyColor = "34";
          }
          {
            type = "uptime";
            key = " ";
            keyColor = "34";
          }
          {
            type = "datetime";
            format = "{1}-{3}-{11}";
            key = " ";
            keyColor = "34";
          }
          {
            type = "media";
            key = "󰝚 ";
            keyColor = "34";
          }
          "break"
          {
            type = "custom";
            format = "               ";
          }
          "break"
          "break"
        ];


      };

      starship-conf = ''

        "$schema" = 'https://starship.rs/config-schema.json'

        format = """
        [░▒▓](color_dark_accent)\
        [   ](bg:color_dark_accent fg:color_foreground)\
        [▓▒░](bg:color_accent fg:color_dark_accent)\
        $nix_shell\
        $username\
        [▓▒░](bg:color_tertiary_accent fg:color_accent)\
        $directory\
        [▓▒░](fg:color_tertiary_accent bg:color_secondary_active)\
        $git_branch\
        $git_status\
        [▓▒░](fg:color_secondary_active bg:color_highlight)\
        $c\
        $cpp\
        $rust\
        $golang\
        $nodejs\
        $php\
        $java\
        $kotlin\
        $haskell\
        $python\
        [▓▒░](fg:color_highlight bg:color_dark_accent)\
        $docker_context\
        $conda\
        $pixi\
        [▓▒░](fg:color_dark_accent bg:color_lighter_background)\
        $time\
        [ ](fg:color_lighter_background)\
        $line_break$character"""

        palette = 'theme'

        [palettes.theme]
        color_foreground = "#${currentColorConfs.colors.foreground}"
        color_background = "#${currentColorConfs.colors.background}"
        color_lighter_background = "#${currentColorConfs.colors.background-lighter}" 
        color_highlight = "#${currentColorConfs.colors.highlight}"
        color_dark_accent = "#${currentColorConfs.colors.dark-accent}"
        color_secondary_active = "#${currentColorConfs.colors.secondary-accent}"
        color_inactive_accent = "#${currentColorConfs.colors.inactive-accent}"
        color_accent = "#${currentColorConfs.colors.accent}"
        color_tertiary_accent = "#${currentColorConfs.colors.tertiary-accent}"
        color_quaternary_accent = "#${currentColorConfs.colors.quaternary-accent}"

        [username]
        show_always = true
        style_user = "bold bg:color_accent fg:color_background"
        style_root = "bold bg:color_accent fg:color_background"
        format = '[ $user ]($style)'

        [nix_shell]
        disabled = false
        format = '[[  nix-shell :](bold fg:color_background bg:color_accent)]($style)'
        style = "bold bg:color_accent fg:color_background"

        [directory]
        style = "bold fg:color_background bg:color_tertiary_accent"
        format = "[ $path ]($style)"
        truncation_length = 3
        truncation_symbol = "…/"

        [directory.substitutions]
        "Documents" = "󰈙 "
        "Downloads" = " "
        "Music" = "󰝚 "
        "Pictures" = " "
        "Developer" = "󰲋 "

        [git_branch]
        symbol = ""
        style = "bold bg:color_secondary_active"
        format = '[[ $symbol $branch ](bold fg:color_background bg:color_secondary_active)]($style)'

        [git_status]
        style = "bold bg:color_secondary_active"
        format = '[[($all_status$ahead_behind )](bold fg:color_background bg:color_secondary_active)]($style)'

        [nodejs]
        symbol = ""
        style = "bold bg:color_background"#83a598
        format = '[[ $symbol( $version) ](bold fg:color_background bg:color_highlight)]($style)'

        [c]
        symbol = " "
        style = "bold bg:color_background"
        format = '[[ $symbol( $version) ](bold fg:color_foreground bg:color_highlight)]($style)'

        [cpp]
        symbol = " "
        style = "bold bg:color_background"
        format = '[[ $symbol( $version) ](bold fg:color_foreground bg:color_highlight)]($style)'

        [rust]
        symbol = ""
        style = "bold bg:color_background"
        format = '[[ $symbol( $version) ](bold fg:color_foreground bg:color_highlight)]($style)'

        [golang]
        symbol = ""
        style = "bold bg:color_background"
        format = '[[ $symbol( $version) ](bold fg:color_foreground bg:color_highlight)]($style)'

        [php]
        symbol = ""
        style = "bold bg:color_background"
        format = '[[ $symbol( $version) ](bold fg:color_foreground bg:color_highlight)]($style)'

        [java]
        symbol = ""
        style = "bold bg:color_background"
        format = '[[ $symbol( $version) ](bold fg:color_foreground bg:color_highlight)]($style)'

        [kotlin]
        symbol = ""
        style = "bold bg:color_background"
        format = '[[ $symbol( $version) ](bold fg:color_foreground bg:color_highlight)]($style)'

        [haskell]
        symbol = ""
        style = "bold bg:color_background"
        format = '[[ $symbol( $version) ](bold fg:color_foreground bg:color_highlight)]($style)'

        [python]
        symbol = ""
        style = "bold bg:color_background"
        format = '[[ $symbol( $version) ](bold fg:color_foreground bg:color_highlight)]($style)'

        [docker_context]
        symbol = ""
        style = "bold bg:color_highlight"
        format = '[[ $symbol( $context) ](bold fg:color_foreground bg:color_dark_accent)]($style)'

        [conda]
        style = "bold bg:color_highlight"
        format = '[[ $symbol( $environment) ](bold fg:color_foreground bg:color_dark_accent)]($style)'

        [pixi]
        style = "bold bg:color_highlight"
        format = '[[ $symbol( $version)( $environment) ](bold fg:color_foreground bg:color_dark_accent)]($style)'

        [time]
        disabled = false
        time_format = "%R"
        style = "bold bg:color_lighter_background"
        format = '[[  $time ](bold fg:color_foreground bg:color_lighter_background)]($style)'

        [line_break]
        disabled = false

        [character]
        disabled = false
        success_symbol = '[](bold fg:color_secondary_active)'
        error_symbol = '[](bold fg:color_quaternary_accent)'
        vimcmd_symbol = '[](bold fg:color_secondary_active)'
        vimcmd_replace_one_symbol = '[](bold fg:color_tertiary_accent)'
        vimcmd_replace_symbol = '[](bold fg:color_tertiary_accent)'
        vimcmd_visual_symbol = '[](bold fg:color_accent)'    
      '';

      rofi-theme = ''
        * {
          font:   "SFProDisplay Nerd Font 15";

          bg0:    #${currentColorConfs.colors.background}80;
          bg1:    #${currentColorConfs.colors.background-lighter}80;
          bg2:    #${currentColorConfs.colors.accent}E6;

          hl0:    #${currentColorConfs.colors.highlight}60;

          fg0:    #${currentColorConfs.colors.foreground};
          fg1:    #FFFFFF;
          fg2:    #DEDEDE80;

          background-color:   transparent;
          text-color:         @fg0;

          margin:     0;
          padding:    0;
          spacing:    0;
        }

        window {
          width: 500px;
          height: 300px;

          background-color:   @bg0;

          border: 1px;
          border-color: @hl0;

          location:       center;
          border-radius:  15;

        }

        inputbar {
          font:       "SFProDisplay Nerd Font 18";
          padding:    12px;
          spacing:    12px;
          children:   [ icon-search, entry ];
        }

        icon-search {
          expand:     false;
          filename:   "search";
          size: 28px;
        }

        icon-search, entry, element-icon, element-text {
          vertical-align: 0.5;
        }

        entry {
          font:   inherit;

          placeholder         : "Search";
          placeholder-color   : @fg2;
        }

        message {
          border:             2px 0 0;
          border-color:       @bg1;
          background-color:   @bg1;
        }

        textbox {
          padding:    8px 24px;
        }

        listview {
          lines:      10;
          columns:    1;

          fixed-height:   false;
          border:         1px 0 0;
          border-color:   @bg1;
        }

        element {
          padding:            8px 16px;
          spacing:            16px;
          background-color:   transparent;
        }

        element normal active {
          text-color: @bg2;
        }

        element alternate active {
          text-color: @bg2;
        }

        element selected normal, element selected active {
          background-color:   @bg2;
          text-color:         @fg1;
        }

        element-icon {
          size:   1em;
        }

        element-text {
          text-color: inherit;
        }
      '';

      purple-icon-theme = pkgs : {
        name = "Pebble-Purple";
        package = inputs.pebble-icons.packages.${pkgs.system}.pebble-purple;
      };

      default-icon-theme = pkgs : {
        name = "Pebble";
        package = inputs.pebble-icons.packages.${pkgs.system}.pebble;
      };

      currentIconTheme = default-icon-theme;
    };

    currentConfigs = configs;
  };
}

  