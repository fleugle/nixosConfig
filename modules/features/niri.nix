{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, config, ... }: {
    
    #imports = [ inputs.niri-flake.nixosModules.niri ];
    programs.niri = {
      enable = true;
      package = pkgs.niri;
      
    };

    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];

    home-manager.sharedModules = [
      ({ config, lib, ... }: {

        services.awww.enable = true;

        home.packages = with pkgs; [
          
        ];

        home.file.".config/niri/config.kdl".source =
          config.lib.file.mkOutOfStoreSymlink
            "${self.dots.paths.system-config-path}/modules/features/files/niri-config.kdl";
      })
    ];

  };
}
