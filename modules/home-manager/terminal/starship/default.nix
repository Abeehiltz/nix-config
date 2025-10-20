{
  lib,
  pkgs,
  ...
}:
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableTransience = true;

    settings = {
      add_newline = true;
      command_timeout = 1300;
      scan_timeout = 50;
      character = {
        success_symbol = "[](bold green) ";
        error_symbol = "[✗](bold red) ";
      };
    };
  };
}
