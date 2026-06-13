{ inputs, ... }: {

  flake.nixosModules.myHomeManager = { ... }: {
    imports = [
      inputs.home-manager.nixosModules.default
    ];

    home-manager = {
      extraSpecialArgs = { inherit inputs; };
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup"; # files backups when HM overrides the thing
    };
  };

}