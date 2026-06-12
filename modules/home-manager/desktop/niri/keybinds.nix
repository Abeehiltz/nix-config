{ lib, config, pkgs, ... }
:
let
  apps = import ./applications.nix { inherit pkgs; };
in
{
  programs.niri.settings.binds = with config.lib.niri.actions; {
    # Noctalia commands
    # Toggle launcher
    "Super+Space".action.spawn-sh = "noctalia msg panel-toggle launcher"; 
    
    # Clipboard history
    "Super+V".action.spawn-sh = "noctalia msg panel-toggle clipboard";

    "Super+L".action.spawn-sh = "noctalia msg session lock";
    # Volume
    "XF86AudioRaiseVolume".action.spawn-sh = "noctalia msg volume-up"; 
    "XF86AudioLowerVolume".action.spawn-sh = "noctalia msg volume-down"; 
    "XF86AudioMute".action.spawn-sh = "noctalia msg volume-mute"; 


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
    "Super+Left".action = focus-column-or-monitor-left;
    "Super+Right".action=focus-column-or-monitor-right;
    "Super+Up".action=focus-window-or-workspace-up;
    "Super+Down".action=focus-window-or-workspace-down;
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
    # Same with alt, to also remove the tty swap in gui
    "Alt+Left".action = consume-window-into-column;
    "Alt+Right".action = expel-window-from-column;

    # Fullscreen
    "Super+Shift+F".action=fullscreen-window;
    "Super+F".action=maximize-column;
    "Super+Ctrl+F".action=expand-column-to-available-width;
    
    # Resize column
    "Super+H".action.set-column-width = [ "50%" ];     
    "Super+Minus".action.set-column-width = [ "-10%" ];
    "Super+Equal".action.set-column-width = [ "+10%" ];

    # Floating
    "Super+Z".action = toggle-window-floating;

    # Screenshot settings
    ## Niri inbuilt screenshot tool using same windows keybind
    "Super+Shift+S".action.screenshot = {show-pointer=false; };

    # Screenshot active window and copy to clipboard
    "Ctrl+Print".action.screenshot-window = { write-to-disk=false; };

    # Screenshot active screen
    "Print".action.screenshot-screen = { write-to-disk=false; };

    # 1password
    "Ctrl+Shift+Space".action.spawn-sh = "1password --quick-access";
  };
}
