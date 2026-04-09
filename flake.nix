{
    description = "Abee flake";

    inputs = {
        # NixOS official package source version 25.05
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        # Home Manager
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        # nixOS Hardware for optimisation
        nixos-hardware.url = "github:nixos/nixos-hardware";
    
        # niri-flake to configure niri through nix
        niri-flake = {
          url = "github:sodiboo/niri-flake";
          inputs.nixpkgs.follows = "nixpkgs";
        };

        # Noctalia shelll
        noctalia = {
          url = "github:noctalia-dev/noctalia-shell";
          inputs.nixpkgs.follows = "nixpkgs";
        };

        # silent SDDM theme
        silentSDDM = {
          url = "github:uiriansan/SilentSDDM";
          inputs.nixpkgs.follows = "nixpkgs";
        };
  
        # Zen browser
        zen-browser = {
          url = "github:0xc000022070/zen-browser-flake";
          inputs.nixpkgs.follows = "nixpkgs";
        };

        firefox-addons = {
          url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
          inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-darwin = {
          url = "github:nix-darwin/nix-darwin/master";
          inputs.nixpkgs.follows = "nixpkgs";
        };

        affinity-nix = {
          url = "github:mrshmllow/affinity-nix";
          inputs.nixpkgs.follows = "nixpkgs";
        };

        nvf = {
          url = "github:NotAShelf/nvf";
          inputs.nixpkgs.follows = "nixpkgs";
       };

    };

    outputs = { self, nixpkgs, home-manager, nix-darwin, niri-flake, affinity-nix, nvf, ... }@inputs: 
      let
        inherit (self) outputs;

        # Function for Home Manager configuration
        mkHomeConfiguration = 
          system: username: hostname:
          home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
            extraSpecialArgs = {
              inherit inputs outputs username hostname self;
              hmModules = "${self}/modules/home-manager";
              themeFolder = ./theming;
            };
            modules = [
              ./home/${username}/${hostname}
            ];
          }; 

        # Function for NixOS system configuration
        mkNixosConfiguration =
          hostname: username:
          nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs outputs hostname username;
              nixosModules = "${self}/modules/nixos";
              themeFolder = ./theming;
            };
            modules = [ 
              ./hosts/${hostname} 
            ];
          };

        # Function for MacOS
        mkDarwinConfiguration = 
          hostname: username:
          nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            specialArgs = {
              inherit inputs outputs hostname username;
              darwinModules = "${self}/modules/darwin";
              themeFolder = ./theming;
            };
            modules = [ ./hosts/${hostname} ];
          };

      in {
        nixosConfigurations = {
          abeeNix = mkNixosConfiguration "abeeNix" "abee";
        };

        darwinConfigurations = {
          "BabeeMac" = mkDarwinConfiguration "BabeeMac" "abee";
        };

        homeConfigurations = {
          "abee@abeeNix" = mkHomeConfiguration "x86_64-linux" "abee" "abeeNix";
          "abee@BabeeMac" = mkHomeConfiguration "aarch64-darwin" "abee" "BabeeMac";
        };
      };

   
}
