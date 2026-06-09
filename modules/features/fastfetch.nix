{ self, inputs, ... }: {
  flake.nixosModules.fastfetch = { config, pkgs, ... }: {
    environment.systemPackages = [
      (pkgs.writers.writePython3Bin "fastfetch-animated" { } (builtins.readFile ./fastfetch-animated.py))
    ];
  };
}
