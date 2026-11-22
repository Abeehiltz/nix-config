{ pkgs, inputs, ... }:
{
  modules = [
    inputs.stylix.homeModules.stylix
  ];

  stylix = {
    enable = true;
    polarity = "light";

    # Rosé Pine Moon from the base16-schemes package
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";

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
