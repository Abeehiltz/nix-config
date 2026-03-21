{ config, pkgs, inputs, ...}
:
{
  imports = [
    inputs.niri-flake.homeModules.niri
    ./settings.nix
    ./keybinds.nix
    ./autostart.nix
    ./windows-rules.nix
  ];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
    config.niri = { 
      default = [ "gtk" "gnome" ];
      "org.freedesktop.impl.portal.Access" = "gtk";
      "org.freedesktop.impl.portal.Notification" = "gtk";
      "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
      "org.freedesktop.impl.portal.FileChooser" = "gtk";
    };
    config.common.default = [ "gtk" "gnome" ];
  };
}
