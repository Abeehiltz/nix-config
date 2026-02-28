{ lib, config, pkgs, ... }
:
let
  apps = import ./applications.nix { inherit pkgs; };
in
{
  programs.niri.settings.binds = with config.lib.niri.actions; {
    # Noctalia commands
    # Toggle launcher
    "Super+Space".action.spawn-sh = "noctalia-shell  ipc call launcher toggle"; 
    # Volume
    "XF86AudioRaiseVolume".action.spawn-sh = "noctalia-shell ipc call volume increase"; 
    "XF86AudioLowerVolume".action.spawn-sh = "noctalia-shell ipc call volume decrease"; 
    "XF86AudioMute".action.spawn-sh = "noctalia-shell ipc call volume muteOutput"; 


    # Opening programs
    "Super+T".action.spawn = apps.terminal;

    # Open overview
    "Super+TAB" = {
      action = toggle-overview;
      repeat = false;
    };

    # close window
    "Super+Q" = {
      action = close-window;
      repeat = false;
    };

    # Focus window
    "Super+Left".action = focus-column-left;
    "Super+Right".action=focus-column-right;
    "Super+Up".action=focus-window-up;
    "Super+Down".action=focus-window-down;
    "Super+U".action=focus-workspace-up;
    "Super+D".action=focus-workspace-down;


    # Move Window
    "Super+Ctrl+Left".action=move-column-left;
    "Super+Ctrl+Right".action=move-column-right;
    "Super+Ctrl+Up".action=move-window-up;
    "Super+Ctrl+Down".action=move-window-down;

    "Super+Ctrl+Alt+Left".action=move-column-to-monitor-left;
    "Super+Ctrl+Alt+Right".action=move-column-to-monitor-right;
    "Super+Ctrl+Alt+Up".action=move-column-to-workspace-up;
    "Super+Ctrl+Alt+Down".action=move-column-to-workspace-down;

    "Super+Ctrl+Alt+U".action=move-workspace-up;
    "Super+Ctrl+Alt+D".action=move-workspace-down;

    # Move app to monitor
    #"Super+Ctrl+Alt+Left".action = move-window-to-monitor-left;
    #"Super+Ctrl+Alt+Right".action = move-window-to-monitor-right;

    # Move app to workspace
    #"Super+Ctrl+Alt+Up".action = move-window-to-workspace-up;
    #"Super+Ctrl+Alt+Down".action = move-window-to-workspace-down;
    
    # move focused window in and out of column
    "Super+BracketLeft".action=consume-or-expel-window-left;
    "Super+BracketRight".action=consume-or-expel-window-right;

    # Move window on the right to current column
    "Super+Comma".action=consume-window-into-column;
    "Super+Period".action=expel-window-from-column;

    # Fullscreen
    "Super+Shift+F".action=fullscreen-window;
    "Super+F".action=maximize-column;
    "Super+Ctrl+F".action=expand-column-to-available-width;
    
    # Floating
    "Super+V".action = toggle-window-floating;
  };
}
