{ self, inputs, ... }: {
  flake.nixosModules.driftwm = { pkgs, config, lib, ... }: {

    services.displayManager.sessionPackages = [ inputs.driftwm-flake.packages.${pkgs.stdenv.hostPlatform.system}.default ];
    environment.systemPackages = [ inputs.driftwm-flake.packages.${pkgs.stdenv.hostPlatform.system}.default ];

    systemd.user.services.driftwm = {
      serviceConfig.ExecStart = lib.mkForce
        "${inputs.driftwm-flake.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/driftwm";
    };

    home-manager.sharedModules = [
      ({ config, lib, ... }: {
        home.file.".config/driftwm/config.toml".source =
          config.lib.file.mkOutOfStoreSymlink
            "${config.home.homeDirectory}/nixosConfig/modules/features/files/driftwm-config.toml";
      })
    ];

  };
  
}