{
  config,
  pkgs,
  inputs,
  ...
}:
let
  strata = inputs.strata.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  programs.umbriel.enable = true;
  imports = [
    #    ./settings.nix
    #    ./keybinds.nix
    #    ./autostart.nix
    #    ./windows-rules.nix
    #    ./workspaces.nix
  ];

  #  xdg.portal = {
  #    enable = true;
  #    xdgOpenUsePortal = true;
  #    extraPortals = [
  #      strata.fileChooserPortal
  #    ];
  #          config.niri = {
  #            default = [
  #              "strata"
  #              "gnome"
  #              "gtk"
  #            ];
  #      "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
  #      "org.freedesktop.impl.portal.FileChooser" = "strata";
  #    };
  #        config.common.default = [
  #          "strata"
  #          "gnome"
  #          "gtk"
  #        ];
  #  };
}
