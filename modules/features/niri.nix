{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, ... }: {
    
    imports = [ inputs.niri-flake.nixosModules.niri ];
    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    home-manager.sharedModules = [
      {
        programs.niri = self.dots.currentConfigs.niri-conf // {package = pkgs.niri;};
      }
    ];

  };
}
