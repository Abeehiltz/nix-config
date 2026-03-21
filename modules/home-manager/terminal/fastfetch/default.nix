{ self, config, pkgs, ... }:
{
  home.file.".config/fastfetch/fastfetch.png".source = "${self}/theming/fastfetch.png";

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "~/.config/fastfetch/fastfetch.png";
        type = "kitty";
        width = 18;
        height = 18;
        padding = {
          top = 1;
          bottom = 1;
          right = 2;
        };
      };
      display = {
        key.width = 5;
        size.binaryPrefix = "jedec";
        separator = "";
        percent = {
          color.green = "#31748f";
          color.yellow = "#f6c177";
          color.red = "#eb6f92";
        };
      };
      modules = [
        "break"
        {
          type = "title";
          key = " ";
        }
        "break"
        {
          type = "os";
          key = " ";
          keyColor = "38;2;235;111;146";
          format = "{name}";
        }
        {
          type = "kernel";
          key = " ";
          keyColor = "38;2;235;111;146";
        }
        {
          type = "packages";
          key = " ";
          keyColor = "38;2;235;111;146";
        }
        "break"
        {
          type = "wm";
          key = " ";
          keyColor = "38;2;235;111;146";
        }
        {
          type = "terminal";
          key = "  ";
          keyColor = "38;2;235;111;146";
        }
        {
          type = "shell";
          key = " ";
          keyColor = "38;2;235;111;146";
        }
        "break"
        {
          type = "cpu";
          key = " ";
          keyColor = "38;2;235;111;146";
          format = "{name}";
        }
        {
          type = "gpu";
          key = " ";
          keyColor = "38;2;235;111;146";
          hideType = "integrated";
        }
        {
          type = "memory";
          key = " ";
          keyColor = "38;2;235;111;146";
        }
        {
          type = "disk";
          key = " ";
          keyColor = "38;2;235;111;146";
          folders = "/";
        }
        "break"
        { 
          type = "colors";
          block.range = [8 15];
        }
      ];
    };
  };
}
