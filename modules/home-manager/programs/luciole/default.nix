{ inputs, ... }:
{
  imports = [ inputs.luciole.homeModules.default ];

  programs.luciole = {
    enable = true;
    settings = {
      browser = {
        view_mode = "list";
        show_hidden = true;
        background_opacity = 0.9;
      };
    };
  };
}
