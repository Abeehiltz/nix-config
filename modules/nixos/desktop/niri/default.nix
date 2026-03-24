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

  # repeated with home-manager config to fix https://github.com/sodiboo/niri-flake/issues/509
  # Update 2026-03-24: commented after moving to SDDM since it seems to be fixed now. To remove in a few days.
#  xdg.portal = {
#    enable = true;
#    xdgOpenUsePortal = true;
#    extraPortals = [ pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk ];
#    config.niri = { 
#      default = [ "gtk" "gnome" ];
#      "org.freedesktop.impl.portal.Access" = "gtk";
#      "org.freedesktop.impl.portal.Notification" = "gtk";
#      "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
#      "org.freedesktop.impl.portal.FileChooser" = "gtk";
#    };
#    config.common.default = [ "gtk" "gnome" ];
#  };

  environment.systemPackages = with pkgs; [
    kitty
    xwayland-satellite
    wl-clipboard
  ];

  # Enable security services
#  services.gnome.gnome-keyring.enable = true;
#  security.polkit.enable = true;
#  security.pam.services = {
#    gdm.enableGnomeKeyring = true;
#  };
#
#  systemd.user.services.xdg-desktop-portal = {
#    after = [ "xdg-desktop-autostart.target" ];
#  };
#
#  systemd.user.services.xdg-desktop-portal-gtk = {
#    after = [ "xdg-desktop-autostart.target" ];
#  };
#
#  systemd.user.services.xdg-desktop-portal-gnome = {
#    after = [ "xdg-desktop-autostart.target" ];
#  };
#
#  systemd.user.services.niri-flake-polkit = {
#    after = [ "xdg-desktop-autostart.target" ];
#  };

  # Configure SDDM
  services.displayManager = {
    enable = true;
    sddm = {
      enable = true;
      wayland = {
        compositor = "kwin";
        enable = true;
      };
    };
  };
}
