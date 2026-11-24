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
      #url = "github:sodiboo/niri-flake";
      url = "github:epireyn/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Umbriel
    umbriel.url = "github:noctalia-dev/umbriel/cachix";

    # Noctalia shelll
    noctalia.url = "github:noctalia-dev/noctalia/cachix";

    # Greeter
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Noctalia filepicker
    luciole.url = "github:noctalia-dev/luciole/cachix";

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

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dw-proton.url = "github:imaviso/dwproton-flake";
    nixos-xivlauncher-rb = {
      url = "github:The1Penguin/nixos-xivlauncher-rb";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-yazi-plugins = {
      url = "github:lordkekz/nix-yazi-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # File explorer Strata
    #strata.url = "github:lgse/strata";

    #    raphael-rs-src = {
    #      url = "github:KonaeAkira/raphael-rs";
    #      flake = false;
    #    };
    ani2xcur-src = {
      url = "github:nicdgonzalez/ani2xcur";
      flake = false;
    };

    llm-agents.url = "github:numtide/llm-agents.nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      niri-flake,
      nvf,
      dw-proton,
      nixos-xivlauncher-rb,
      millennium,
      stylix,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      pkgsFor =
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

      # Function for Home Manager configuration
      mkHomeConfiguration =
        system: username: hostname:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          extraSpecialArgs = {
            inherit
              inputs
              outputs
              username
              hostname
              self
              ;
            hmModules = "${self}/modules/home-manager";
            themeFolder = ./theming;
          };
          modules = [
            stylix.homeModules.stylix
            ./home/${username}/${hostname}
          ];
        };

      # Function for NixOS system configuration
      mkNixosConfiguration =
        hostname: username:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit
              inputs
              outputs
              hostname
              username
              ;
            nixosModules = "${self}/modules/nixos";
            themeFolder = ./theming;
          };
          modules = [
            ./hosts/${hostname}
            # For xivlauncher-rb
            nixos-xivlauncher-rb.nixosModules.default
          ];
        };

      # Function for MacOS
      mkDarwinConfiguration =
        hostname: username:
        nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            inherit
              inputs
              outputs
              hostname
              username
              ;
            darwinModules = "${self}/modules/darwin";
            themeFolder = ./theming;
          };
          modules = [ ./hosts/${hostname} ];
        };

    in
    {
      # packages.x86_64-linux.raphael-rs = (pkgsFor "x86_64-linux").callPackage ./pkgs/raphael-rs {
      #   src = inputs.raphael-rs-src;
      # };
      packages.x86_64-linux.ani2xcur = (pkgsFor "x86_64-linux").callPackage ./pkgs/ani2xcur {
        src = inputs.ani2xcur-src;
      };

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
