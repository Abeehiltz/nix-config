{pkgs, ...}: {
  stylix = {
    enable = true;
    polarity = "dark";

    # Rosé Pine Moon from the base16-schemes package
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";

    opacity = {
      terminal = 0.95;
      desktop = 0.9;
      applications = 0.9;
      popups = 0.9;
    };

    targets = {
      wayprompt.enable = false;
      zen-browser.enable = false; # Disable to use blur
      #      zen-browser.profileNames = [
      #       "default"
      #    ];
    };
    # Optional extras
    fonts = {
      monospace = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans Mono";
      };
      sizes.terminal = 12;
    };
  };
}
