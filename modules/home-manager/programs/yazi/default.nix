{pkgs, inputs, ...}:
{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";
    
    plugins = with pkgs.yaziPlugins; {
      inherit toggle-pane;
    };

    keymap = {
      mgr.prepend_keymap = [
        {
          on = "T";
          run = "plugin toggle-pane max-preview";
          desc = "Maximize or restore the preview pane";
        }
      ];
    };
    settings = {
      preview = {
        max_width = 3840;
        max_height = 2160;
      };
    };
  };
}
