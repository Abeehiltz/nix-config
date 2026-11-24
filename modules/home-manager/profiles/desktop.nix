{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ../programs/kitty
    ../programs/zen-browser
    ../programs/luciole
    ../programs/vesktop
    ../programs/obs-studio
    ../programs/obsidian

    ../services/rsync-backups
    ../services/cliphist

    ../theming/stylix
  ];

  xdg.userDirs = {
    enable = true;
    setSessionVariables = false;
    createDirectories = true;
  };

  home.packages = with pkgs; [
    solaar # logitech mouse
    winbox
    iloader
    telegram-desktop
    outputs.packages.${pkgs.stdenv.hostPlatform.system}.ani2xcur

    # Fonts
    fira-code
    fira-code-symbols
    nerd-fonts.fira-code

    #inputs.strata.packages.${pkgs.stdenv.hostPlatform.system}.default
    # affinity-nix https://github.com/mrshmllow/affinity-nix
    #inputs.affinity-nix.packages.x86_64-linux.v3
  ];
}
