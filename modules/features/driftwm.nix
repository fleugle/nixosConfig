{ inputs, ... }: {
  flake.nixosModules.driftwm = { pkgs, lib, ... }: {

    services.displayManager.sessionPackages = [ inputs.driftwm-flake.packages.${pkgs.stdenv.hostPlatform.system}.default ];
    environment.systemPackages = [ inputs.driftwm-flake.packages.${pkgs.stdenv.hostPlatform.system}.default ];

    systemd.user.services.driftwm = {
      serviceConfig.ExecStart = lib.mkForce
        "${inputs.driftwm-flake.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/driftwm";
    };

    home-manager.sharedModules = [
      ({ config, ... }: {
        home.file.".config/driftwm/config.toml".source =
          config.lib.file.mkOutOfStoreSymlink
            "${config.home.homeDirectory}/nixosConfig/modules/hosts/my-machine/dots/files/driftwm-config.toml";
      })
    ];

  };
  
}