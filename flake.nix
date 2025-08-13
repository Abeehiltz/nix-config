{
    description = "Abee NixOS flake";

    inputs = {
        # NixOS official package source version 25.05
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs: 
      let
        lib = nixpkgs.lib;
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        nixosConfigurations = {
          abeeNix = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              # Import the previous configuration.nix we used,
              # so the old configuration file still takes effect
              ./configuration.nix
            ];
          };
        };

        homeConfigurations = {
          abee = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ 
              ./home.nix 
            ];
          };
        };
    };
}
