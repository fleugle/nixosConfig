{ self, ... }: {
  flake.nixosModules.niri = { pkgs, ... }: {
    
    #imports = [ inputs.niri-flake.nixosModules.niri ];
    programs.niri = {
      enable = true;
      package = pkgs.niri;
      
    };

    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];

    home-manager.sharedModules = [
      ({ config, ... }: {

        services.awww.enable = true;

        # home.packages = with pkgs; [
          
        # ];

        home.file.".config/niri/config.kdl".source =
          config.lib.file.mkOutOfStoreSymlink
            "${self.dots.paths.system-config-path}/modules/hosts/my-machine/dots/files/niri-config.kdl";
      })
    ];

  };
}
