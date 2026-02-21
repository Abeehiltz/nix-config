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
  programs.niri {
    enable = true;
  };

  security.polkit.enable = true; 
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.swaylock = {};

  environment.systemPackages = with pkgs; [
    kitty
    xwayland-satellite
  ];
};
