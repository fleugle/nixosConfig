{
  inputs = {

    #__FLAKE'S-BASE__###############################################__MAIN-REPO-CHANNEL-&--FLAKE-PARTS__##
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # NUR (Nix User Repository) - a collection of user-contributed Nix packages and modules, 
    # which is a great way to access a wide variety of software and configurations that may 
    # not be available in the main nixpkgs repository.
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    wrapper-modules = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ######################################################################################################
    

    
    #__USER-SPECIFIC-SETTINGS__###################################################__HM-MODULE-&-STYLIX__##
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #-----------------------------------------------------------------------------------------------------
    apple-fonts.url= "github:Lyndeno/apple-fonts.nix";

    pebble-icons.url = "path:/home/fleugle/my-flakes/Pebble-Icon-Theme-flake"; #"github:fleugle/Pebble-Icon-Theme-flake";
    ######################################################################################################



    ##__CUSTOM-WM'S__#####################################################################################
    driftwm-flake = {
      url = "github:malbiruk/driftwm";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    ######################################################################################################



    ##__CUSTOM-USER-APPS__################################################################################
    # ZEN BROWSER, my favourite custom web browser, based on firefox but with a lot of custom features and
    # optimizations for performance and privacy.
    zen-browser-flake = { 
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        # IMPORTANT: To ensure compatibility with the latest Firefox version, use nixpkgs-unstable.
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    #-----------------------------------------------------------------------------------------------------
    # Affinity V3. A tough one - requires WINE to run, but it's the only way to get Affinity Designer on 
    # Linux, which is my go-to design software. 
    # affinity-nix.url = "github:mrshmllow/affinity-nix"; 

    #-----------------------------------------------------------------------------------------------------
    # Daily-updated VS Code extensions from marketplace
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #-----------------------------------------------------------------------------------------------------
    # lazyvim-flake = {
    #   url = "github:pfassina/lazyvim-nix";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     home-manager.follows = "home-manager";
    #   };
    # };
    ######################################################################################################

  };

  # Automatically import all modules from the `modules` directory, which is organized into subdirectories 
  # for features and hosts.
  outputs = inputs: inputs.flake-parts.lib.mkFlake 
    {inherit inputs;} 
    (inputs.import-tree ./modules);
}
