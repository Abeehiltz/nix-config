{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.umbriel.homeModules.default
    ./appearance.nix
    ./settings.nix
    ./keybinds.nix
    ./autostart.nix
    ./windows-rules.nix
    ./workspaces.nix
  ];

  programs.umbriel.settings.include.optional.files = ["~/.config/umbriel/noctalia.toml"];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      inputs.luciole.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.xdg-desktop-portal-umbriel
    ];
    config.umbriel = {
      default = [
        "umbriel"
        "gtk"
      ];
      "org.freedesktop.impl.portal.FileChooser" = [
        "luciole"
        "gtk"
      ];
    };
    config.common."org.freedesktop.impl.portal.FileChooser" = [
      "luciole"
      "gtk"
    ];
  };
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = ["kitty.desktop"];
    };
  };
}
