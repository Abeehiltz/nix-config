{
  outputs,
  inputs,
  username,
  hostname,
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
  ];


  home = {
    username = username;
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
    sessionVariables = {
      EDITOR = "vim";
    };
  };

  home.packages = with pkgs; [
    vim
    eza    # Modern ls
    fd     # Find alternative
    zoxide # Better cd
    ouch   # unified compression helper
    btop
    dysk
    lazygit
    jq
    unzip
    cliphist
    openvpn


    # Applications
    vesktop
    feishin # Music player
    mpv # media player for feishin
    solaar # logitech mouse
    obsidian
    jellyfin-desktop
    xivlauncher

    # Kubernetes
    talosctl
    kompose
    kubectl
    kubernetes-helm

    # Fonts
    fira-code
    fira-code-symbols
    nerd-fonts.fira-code

    # affinity-nix https://github.com/mrshmllow/affinity-nix
    inputs.affinity-nix.packages.x86_64-linux.v3
  ];


}
