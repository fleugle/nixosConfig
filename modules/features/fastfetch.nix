{ self, inputs, ... }: {
  flake.nixosModules.fastfetch = { config, pkgs, ... }:
  let
    accent = self.dots.currentColorConfs.colors.accent;
    secondaryAccent = self.dots.currentColorConfs.colors.secondary-accent;

    # Read the python script and replace default colors with system colors
    rawScript = builtins.readFile ./fastfetch-animated.py;

    scriptWithColors = builtins.replaceStrings
      [ "default=\"#4d6fb7\"" "default=\"#77b6e1\"" ]
      [ "default=\"#${accent}\"" "default=\"#${secondaryAccent}\"" ]
      rawScript;
  in
  {
    environment.systemPackages = [
      (pkgs.writers.writePython3Bin "fastfetch-animated" { } scriptWithColors)
    ];
  };
}
