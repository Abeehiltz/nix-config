{
  lib,
  pkgs,
  ...
}:
{
  # Zsh setup
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;


    shellAliases = {
      # eza aliases
      ls   = "eza --icons=always";
      ll   = "eza -lg --icons=always";
      lls  = "eza -lg -s newest --icons=always";
      la   = "eza -lag --icons=always";
      las  = "eza -lag -s newest --icons=always";
      lt   = "eza -lTg --icons=always";
      lt2  = "eza -lTg --level=2 --icons=always";
      lt3  = "eza -lTg --level=3 --icons=always";
      lt4  = "eza -lTg --level=4 --icons=always";
      lta2 = "eza -lTag --level=2 --icons=always";
      lta3 = "eza -lTag --level=3 --icons=always";
      lta4 = "eza -lTag --level=4 --icons=always";

      # git
      lg = "lazygit";
    };

    history = {
      append = true;
      size = 10000;
    };

  };

}
