{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, config, ... }: {
    
    #imports = [ inputs.niri-flake.nixosModules.niri ];
    programs.niri = {
      enable = true;
      package = pkgs.niri;
      
    };

    home-manager.sharedModules = [
      ({ config, lib, ... }: {
        home.file.".config/niri/config.kdl".source =
          config.lib.file.mkOutOfStoreSymlink
            "${config.home.homeDirectory}/nixosConfig/modules/features/files/niri-config.kdl";
      })
    ];

  };
}
