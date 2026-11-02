{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";

    plugins = with pkgs.yaziPlugins; {
      inherit toggle-pane compress;
    };

    keymap = {
      mgr.prepend_keymap = [
        {
          on = "T";
          run = "plugin toggle-pane max-preview";
          desc = "Maximize or restore the preview pane";
        }
        {
          on = [
            "c"
            "a"
            "a"
          ];
          run = "plugin compress";
          desc = "Archive selected files";
        }
      ];
    };
    settings = {
      preview = {
        max_width = 3840;
        max_height = 2160;
        cache_dir = "~/.cache/yazi";
      };

      opener = {
        feh-fullscreen = [
          {
            run = "feh -F -Z --start-at %s1 %d1";
            desc = "Open in feh (fullscreen)";
            orphan = true;
          }
        ];
        video-opener = [
          {
            run = "cine %s1";
            desc = "Open with Cine";
            orphan = true;
          }
        ];
      };
      open.prepend_rules = [
        {
          mime = "image/*";
          use = "feh-fullscreen";
        }
        {
          mime = "video/*";
          use = "video-opener";
        }
      ];
    };
  };
}
