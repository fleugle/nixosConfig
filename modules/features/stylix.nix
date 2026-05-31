{ self, inputs, ... }: {
  flake.nixosModules.stylix = { pkgs, config, ... }: {
    imports = [inputs.stylix.nixosModules.stylix];

    stylix = {
      enable = false;

      polarity = "dark";

      fonts = {
        serif = {
          name = "New York Nerd Font";
          package = inputs.apple-nerd-fonts.packages.${pkgs.system}.ny;
        };

        sansSerif = {
          package = inputs.apple-nerd-fonts.packages.${pkgs.system}.sf-pro-nerd;
          name = "SFProDisplay Nerd Font";
        };
        
        monospace = {
          package = inputs.apple-nerd-fonts.packages.${pkgs.system}.sf-mono-nerd;
          name = "SFMono Nerd Font";
        };
      };
    };
  };
}