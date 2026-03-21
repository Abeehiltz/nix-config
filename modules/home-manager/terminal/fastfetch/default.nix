{
  lib,
  pkgs,
  ...
}:
let
  logo = ./theming/fastfetch.png;
in
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = toString logo;
      }; 
    };
  };
};
