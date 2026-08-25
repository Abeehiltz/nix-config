{
  lib,
  ...
}:
{
  # Fish setup
  programs.fish = {
    enable = true;
    
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

      # zoxide, better cd
      cd = "z";

      # git
      lg = "lazygit";
    };

    # Fish has built-in autosuggestions and syntax highlighting
    interactiveShellInit = ''
      # Enable vi mode (optional)
      fish_vi_key_bindings
      
      # Set greeting (optional - remove to disable)
      # set fish_greeting
    '';


    functions = {
      # Cleans up the local Nix install: keeps the 5 most recent profile
      # generations, removes garbage, and hard-links duplicate store files.
      nix-cleanup = ''
        set -l keep 5

        echo "📋 Checking profile generations (keeping newest $keep)..."
        set -l gens (nix-env --list-generations | awk '{print $1}')
        set -l total (count $gens)

        if test $total -gt $keep
          set -l n_delete (math $total - $keep)
          set -l to_delete $gens[1..$n_delete]
          echo "🗑  Deleting generations: $to_delete"
          nix-env --delete-generations $to_delete
        else
          echo "   Only $total generation(s), nothing to delete."
        end

        echo "🧹 Collecting garbage (removing unreferenced store paths)..."
        nix-collect-garbage -d

        echo "📦 Optimising store (hard-linking identical files)..."
        nix-store --optimise

        echo "🔍 Verifying store integrity..."
        nix-store --verify --check-contents

        echo "✅ Done."
        du -sh /nix/store 2>/dev/null
      '';
    };

  };

  # Symlink fish's history file to ~/.history.
  home.activation.fishHistoryLink = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.local/share/fish"
    if [ ! -e "$HOME/.history" ]; then
      touch "$HOME/.history"
    fi
    ln -sf "$HOME/.history" "$HOME/.local/share/fish/fish_history"
  '';


  programs.man.generateCaches = false;

}
