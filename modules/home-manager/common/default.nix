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
    ../terminal/eza
    ../terminal/fd
    ../terminal/fzf
    ../terminal/jq
    ../terminal/k9s
    ../terminal/lazygit

    ../programs/kitty
    ../programs/git
    ../programs/zen-browser
    ../programs/yazi
    ../programs/gallery-dl
    ../programs/nvim
    ../programs/beets
    ../programs/feh
    ../programs/btop
    ../programs/luciole
    ../programs/vesktop
    ../programs/obs-studio
    ../programs/obsidian
    ../programs/mpv

    ../services/rsync-backups
    ../services/cliphist

    ../theming/stylix
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
    ouch # unified compression helper
    dysk
    yq-go
    unzip
    zip
    openvpn
    dnsutils
    openssl
    ansible
    inetutils
    imagemagick
    ffmpeg-full
    unrar

    # Applications
    lact
    feishin # Music player
    cine # Video player
    solaar # logitech mouse
    jellyfin-desktop
    nicotine-plus
    #inputs.strata.packages.${pkgs.stdenv.hostPlatform.system}.default
    winbox
    outputs.packages.${pkgs.stdenv.hostPlatform.system}.ani2xcur
    blender

    vintagestory
    qbittorrent
    iloader
    gimp
    krita
    blender
    lutris
    telegram-desktop
    sgdboop

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
