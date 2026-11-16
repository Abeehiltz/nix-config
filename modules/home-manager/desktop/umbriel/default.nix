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
  imports = [
    inputs.umbriel.homeModules.default
    ./appearance.nix
    ./settings.nix
    ./keybinds.nix
    ./autostart.nix
    ./windows-rules.nix
    ./workspaces.nix
  ];

  programs.umbriel.settings.include.optional.files = [ "~/.config/umbriel/noctalia.toml" ];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-umbriel
      strata.fileChooserPortal
    ];
    config.umbriel.default = [
      "umbriel"
      "gtk"
    ];

    #          config.niri = {
    #            default = [
    #              "strata"
    #              "gnome"
    #              "gtk"
    #            ];
    #      "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
    #    };
    #        config.common.default = [
    #          "strata"
    #          "gnome"
    #          "gtk"
    #        ];
  };
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "kitty.desktop" ];
    };
  };
}
