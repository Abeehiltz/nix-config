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
  sddm-theme = inputs.silentSDDM.packages.${pkgs.system}.default.override {
      theme = "silvia"; # select the config of your choice
      extraBackgrounds = [  vivianBackground ];
      theme-overrides = {
            # Available options: https://github.com/uiriansan/SilentSDDM/wiki/Options
            "LoginScreen" = {
              background = "${vivianBackground.name}";
            };
            "LockScreen" = {
              background = "${vivianBackground.name}";
            };
          };
  };
in {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;
    package = pkgs.kdePackages.sddm;
    theme = sddm-theme.pname;
    extraPackages = sddm-theme.propagatedBuildInputs;
      settings = {
        # required for styling the virtual keyboard
        General = {
          GreeterEnvironment = "QML2_IMPORT_PATH=${sddm-theme}/share/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
          InputMethod = "qtvirtualkeyboard";
        };
      }; 
  };

  services.xserver.enable = true;
  services.xserver.updateDbusEnvironment = true;

  # Enable Hyprland 
  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    xwayland.enable = true; # Xwayland can be disabled.
  };

  # Enable security services
  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;
  security.pam.services = {
    hyprlock = { };
    gdm.enableGnomeKeyring = true;
  };


  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = [
    sddm-theme
    pkgs.kitty
    pkgs.kdePackages.qtmultimedia
  ];


}
