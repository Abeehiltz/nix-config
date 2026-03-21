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

    ../programs/kitty
    ../programs/git
    ../programs/zen-browser
    ../programs/yazi
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
    lazygit
    fastfetch
    jq
    unzip

    # Applications
    vesktop
    piper # To manage mouse buttons


    # Kubernetes
    talosctl
    kompose
    kubectl
    kubernetes-helm

    # Fonts
    fira-code
    fira-code-symbols
    nerd-fonts.fira-code
  ];


}
