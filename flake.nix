{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    driftwm-flake = {
      url = "github:malbiruk/driftwm";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    zen-browser-flake = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        # IMPORTANT: To ensure compatibility with the latest Firefox version, use nixpkgs-unstable.
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    apple-fonts.url= "github:Lyndeno/apple-fonts.nix";

    pebble-icons.url = "github:fleugle/Pebble-Icon-Theme-flake";

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

# import modules/ automatically
  outputs = inputs: inputs.flake-parts.lib.mkFlake 
    {inherit inputs;} 
    (inputs.import-tree ./modules);
}
