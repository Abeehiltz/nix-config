{ ... }: {
  wayland.windowManager.hyprland.settings = {

    "$mainMod" = "Super";
  
    bind = [
      # Window/Session actions
      "$mainMod, Q, killactive,"

      # App shortcut
      "$mainMod, T, exec, $term"
      "$mainMod, B, exec, $browser"
    ];
  };
}
