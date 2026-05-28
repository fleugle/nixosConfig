{ self, inputs, ... }: {
  flake.colorThemes =
  rec{
    purpleBlueColors = rec{
      background = "090910"; # Dark blue-black. low saturation
      background-lighter = "222225"; #
      foreground = "C0C0C1"; # Bright gray
      dark-accent = "261E71"; # Dark purple-blue
      accent = "C575D8"; # Purple
      secondary-accent = "75D8C5"; # Cyan
      tertiary-accent = "D8C575"; # Yellow
      quaternary-accent = "d46f88"; # Red
      inactive-accent = "595959"; # Gray
      highlight = "bbbbbb"; # Gray-purple. low saturation
      shadow = "090910"; # Dark blue-black. low saturation

      icon-set-name = "Adwaita-purple";

      wallpaper-absolute-path = "/etc/nixos/home/dots/wallpapers/purple.jpg";

      
    };

    currentColorTheme = purpleBlueColors;

    themes = rec {
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
        color_foreground = "#${currentColorTheme.foreground}"
        color_lighter_background = "#${currentColorTheme.background-lighter}" 
        color_highlight = "#${currentColorTheme.highlight}"
        color_dark_accent = "#${currentColorTheme.dark-accent}"
        color_secondary_active = "#${currentColorTheme.secondary-accent}"
        color_inactive_accent = "#${currentColorTheme.inactive-accent}"
        color_accent = "#${currentColorTheme.accent}"
        color_tertiary_accent = "#${currentColorTheme.tertiary-accent}"
        color_quaternary_accent = "#${currentColorTheme.quaternary-accent}"

        [username]
        show_always = true
        style_user = "bold bg:color_accent fg:color_dark_accent"
        style_root = "bold bg:color_accent fg:color_dark_accent"
        format = '[ $user ]($style)'

        [nix_shell]
        disabled = false
        format = '[[  nix-shell :](bold fg:color_dark_accent bg:color_accent)]($style)'
        style = "bold bg:color_accent fg:color_dark_accent"

        [directory]
        style = "bold fg:color_dark_accent bg:color_tertiary_accent"
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
        format = '[[ $symbol $branch ](bold fg:color_dark_accent bg:color_secondary_active)]($style)'

        [git_status]
        style = "bold bg:color_secondary_active"
        format = '[[($all_status$ahead_behind )](bold fg:color_dark_accent bg:color_secondary_active)]($style)'

        [nodejs]
        symbol = ""
        style = "bold bg:color_dark_accent"#83a598
        format = '[[ $symbol( $version) ](bold fg:color_dark_accent bg:color_highlight)]($style)'

        [c]
        symbol = " "
        style = "bold bg:color_dark_accent"
        format = '[[ $symbol( $version) ](bold fg:color_foreground bg:color_highlight)]($style)'

        [cpp]
        symbol = " "
        style = "bold bg:color_dark_accent"
        format = '[[ $symbol( $version) ](bold fg:color_foreground bg:color_highlight)]($style)'

        [rust]
        symbol = ""
        style = "bold bg:color_dark_accent"
        format = '[[ $symbol( $version) ](bold fg:color_foreground bg:color_highlight)]($style)'

        [golang]
        symbol = ""
        style = "bold bg:color_dark_accent"
        format = '[[ $symbol( $version) ](bold fg:color_foreground bg:color_highlight)]($style)'

        [php]
        symbol = ""
        style = "bold bg:color_dark_accent"
        format = '[[ $symbol( $version) ](bold fg:color_foreground bg:color_highlight)]($style)'

        [java]
        symbol = ""
        style = "bold bg:color_dark_accent"
        format = '[[ $symbol( $version) ](bold fg:color_foreground bg:color_highlight)]($style)'

        [kotlin]
        symbol = ""
        style = "bold bg:color_dark_accent"
        format = '[[ $symbol( $version) ](bold fg:color_foreground bg:color_highlight)]($style)'

        [haskell]
        symbol = ""
        style = "bold bg:color_dark_accent"
        format = '[[ $symbol( $version) ](bold fg:color_foreground bg:color_highlight)]($style)'

        [python]
        symbol = ""
        style = "bold bg:color_dark_accent"
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
          font:   "AdwaitaMono Propo 15";

          bg0:    #${currentColorTheme.background}80;
          bg1:    #${currentColorTheme.background-lighter}80;
          bg2:    #${currentColorTheme.accent}E6;

          hl0:    #${currentColorTheme.highlight}60;

          fg0:    #${currentColorTheme.foreground};
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
          font:       "AdwaitaMono Propo 18";
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
    };

    currentThemes = themes;
  };
}

  