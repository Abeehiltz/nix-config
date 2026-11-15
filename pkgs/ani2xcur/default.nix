{
  description = "ani2xcur - install Windows animated cursors on X11/Wayland";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    ani2xcur-src = {
      url = "github:nicdgonzalez/ani2xcur";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ani2xcur-src,
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system}.default = pkgs.rustPlatform.buildRustPackage {
        pname = "ani2xcur";
        version = "0.1.3";
        src = ani2xcur-src;
        cargoLock.lockFile = "${ani2xcur-src}/Cargo.lock";
        meta.mainProgram = "ani2xcur";
      };

      apps.${system}.default = {
        type = "app";
        program = "${self.packages.${system}.default}/bin/ani2xcur";
      };
    };
}
