{self, inputs, ...}: {
  flake.nixosModules.nixOSHardware = { config, lib, pkgs, modulesPath, ... }:

  {
    imports = [ ];

    boot.initrd.availableKernelModules = [ "ata_piix" "ohci_pci" "ehci_pci" "ahci" "sd_mod" "sr_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
      { device = "/dev/disk/by-uuid/734bbe79-d902-4559-8dc7-4564cc34bf10";
        fsType = "ext4";
      };

    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/C1E6-FBFF";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };

    swapDevices =
      [ { device = "/dev/disk/by-uuid/c47c67d8-be13-4418-ae61-076b2412b652"; }
      ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    virtualisation.virtualbox.guest.enable = true;
  };
}