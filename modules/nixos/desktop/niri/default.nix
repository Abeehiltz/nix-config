{ pkgs, inputs, themeFolder, ... 
}: let
  vivianBackground = pkgs.stdenv.mkDerivation {
    name = "vivian.mkv";
    src = "${themeFolder}/vivian.mkv";
    dontUnpack = true;
    installPhase = ''
      cp $src $out
    '';
  };
in {
  imports = [ inputs.niri-flake.nixosModules.niri ];

  nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  environment.systemPackages = with pkgs; [
    kitty
    xwayland-satellite
    wl-clipboard
  ];
}
