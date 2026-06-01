{ self, inputs, ... }: {
  flake.nixosModules.stylix = { pkgs, config, ... }: {
    imports = [inputs.stylix.nixosModules.stylix];

    stylix = {
      enable = true;

      #base16Scheme = "${pkgs.base16-schemes}/share/themes/chalk.yaml"; #chalk.yaml #gruvbox-material-dark-hard.yaml 

      base16Scheme = self.dots.currentColorConfs.base16Scheme;

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