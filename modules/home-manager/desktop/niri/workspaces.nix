{ ... }: {
  programs.niri.settings.workspaces = {
    "steam" = {
      open-on-output = "Microstep MPG322UX OLED 0x01010101";
      name = "steam";
    };
    "discord" = {
      open-on-output = "Acer Technologies XB271HU A #ASO7TBPV1Ovd";
      name = "discord";
    };
  };
}
