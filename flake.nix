{
    description = "Abee flake";

    inputs = {
        # NixOS official package source version 25.05
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        # Home Manager
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs: 
      let
        inherit (self) outputs;

        # Function for Home Manager configuration
        mkHomeConfiguration = 
          system: username: hostname:
          home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs { inherit system; };
            extraSpecialArgs = {
              inherit inputs outputs username hostname;
              hmModules = "${self}/modules/home-manager";
            };
            modules = [
              ./home/${username}/${hostname}
            ];
          }; 
      in {
        nixosConfigurations = {
          abeeNix = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit inputs outputs;
              username = "abee";
              hostname = "abeeNix";
            };
            modules = [
              ./hosts/abeeNix
            ];
          };
        };

        homeConfigurations = {
          "abee@abeeNix" = mkHomeConfiguration "x86_64-linux" "abee" "abeeNix";
        };
      };

   
}
