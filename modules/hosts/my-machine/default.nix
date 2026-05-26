{self, inputs, ...}: {

  flake.nixosConfigurations.nixOS = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.nixOSConfig
      self.nixosModules.myHomeManager
    ];
  };

}