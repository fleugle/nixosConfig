{self, inputs, ...}: {

  # NixOS config
  flake.nixosModules.gnome = { config, pkgs, ... }:
  {
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us,ru";
      variant = "";
    };

    environment.systemPackages = with pkgs; [
      gnome-extension-manager

      gnomeExtensions.blur-my-shell
      gnomeExtensions.dash2dock-lite
      gnomeExtensions.all-in-one-clipboard
    ];
  };
}