{
  outputs,
  inputs,
  username,
  pkgs,
  ...
}:
{
  imports = [
    #    ../terminal/zsh
    #    ../terminal/ohmyposh
    ../terminal/fish
    ../terminal/starship
    ../terminal/zoxide
    ../terminal/fastfetch
    ../terminal/ssh

    ../programs/kitty
    ../programs/git
    ../programs/zen-browser
    ../programs/yazi
    ../programs/gallery-dl
    ../programs/nvim
    ../programs/beets
    ../programs/feh
    ../programs/btop

    ../services/rsync-backups
  ];

  home = {
    username = username;
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
    sessionVariables = {
      EDITOR = "vim";
    };
    sessionPath = [ "$HOME/.local/bin" ];

  };
  xdg.userDirs = {
    setSessionVariables = false;
    enable = true;
    createDirectories = true; # creates the folders if they don't exist
  };

  home.packages = with pkgs; [
    vim
    eza # Modern ls
    fd # Find alternative
    zoxide # Better cd
    ouch # unified compression helper
    dysk
    lazygit
    jq
    yq
    unzip
    zip
    fzf
    cliphist
    openvpn
    dnsutils
    openssl
    ansible
    inetutils
    imagemagick
    ffmpeg-full

    # Applications
    lact
    obs-studio
    vesktop
    feishin # Music player
    mpv # media player for feishin
    cine # Video player
    solaar # logitech mouse
    obsidian
    jellyfin-desktop
    #xivlauncher
    nicotine-plus
    brave # When I need chromium based browser
    #    outputs.packages.x86_64-linux.raphael-rs
    inputs.strata.packages.${pkgs.stdenv.hostPlatform.system}.default

    vintagestory
    qbittorrent
    iloader
    gimp
    krita
    blender
    lutris
    telegram-desktop

    # Kubernetes
    talosctl
    kompose
    kubectl
    kubernetes-helm
    k9s

    # Fonts
    fira-code
    fira-code-symbols
    nerd-fonts.fira-code

    # affinity-nix https://github.com/mrshmllow/affinity-nix
    #inputs.affinity-nix.packages.x86_64-linux.v3
  ];

}
