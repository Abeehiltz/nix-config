{ pkgs, inputs, ... }:
{
  imports = [ inputs.noctalia.homeModules.default ];
  
  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;

    settings = {
      # configure noctalia here
      bar = {
        density = "default";
        position = "top";
        showCapsule = false;
        widgets = {
          left = [
              {
                id = "Launcher";
              }
              {
                id = "ActiveWindow";
              }
              {
                id = "AudioVisualizer";
                hideWhenIdle = true;
              }
          ];
          center = [
            {
              hideUnoccupied = false;
              id = "Workspace";
            }
          ];
          right = [
            {
              id = "Tray";
            }
            {
              id = "NotificationHistory";
            }
            {
              id = "Volume";
            }
            {
              id = "Microphone";
            }
            {
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              id = "Clock";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
          ];
        };
      };
      colorSchemes.predefinedScheme = "Monochrome";
      location = {
        name = "Luxembourg, Luxembourg";
      };
    };
  }; 
}
