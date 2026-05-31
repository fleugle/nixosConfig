{ self, inputs, ... }: {
  flake.nixosModules.stylix = { pkgs, config, ... }: {
    imports = [inputs.stylix.nixosModules.stylix];


    # config.lib.stylix.colors = {
    #   base00 = "${self.dots.currentColorTheme.background}";
    #   base08 = "${self.dots.currentColorTheme.quaternary-accent}";
    #   base0A = "${self.dots.currentColorTheme.tertiary-accent}";
    #   base0C = "${self.dots.currentColorTheme.secondary-accent}";
    #   base0E = "${self.dots.currentColorTheme.accent}";
    # };

    stylix = {
      enable = true;

      #base16Scheme = "${pkgs.base16-schemes}/share/themes/chalk.yaml"; #chalk.yaml #gruvbox-material-dark-hard.yaml 

      base16Scheme = {
        base00= "090910";  # background - darkest
        base01= "111118";  # slightly lighter background
        base02= "222225";  # background-lighter - selection bg
        base03= "595959";  # inactive-accent - comments
        base04= "8080a0";  # dark UI text
        base05= "C0C0C1";  # foreground - main text
        base06= "d0d0d2";  # light foreground
        base07= "e8e8ea";  # lightest - rarely used
        base08= "d46f88";  # quaternary-accent - red (errors)
        base09= "D8C575";  # tertiary-accent - yellow (numbers)
        base0A= "c9b860";  # yellow variant (warnings)
        base0B= "75D8C5";  # secondary-accent - cyan (strings)
        base0C= "60c9b8";  # cyan variant
        base0D= "8899dd";  # blue-purple (functions)
        base0E= "C575D8";  # accent - purple (keywords)
        base0F= "261E71";  # dark-accent - special
      };

      polarity = "dark";

      cursor = {
        size = 24;
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
      };

      fonts = {
        serif = {
          name = "New York Nerd Font";
          package = inputs.apple-fonts.packages.${pkgs.system}.ny;
        };

        sansSerif = {
          package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;
          name = "SFProDisplay Nerd Font";
        };
        
        monospace = {
          package = inputs.apple-fonts.packages.${pkgs.system}.sf-mono-nerd;
          name = "SFMono Nerd Font";
        };

        sizes = {
          applications = 12;
          terminal = 12;
          desktop = 11;
          popups = 11;
        };
      };

      # targets = {
      #   #vscode.enable = false;
      
      # };
    };
  };
}