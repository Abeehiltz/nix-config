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
    ../terminal/fish
    ../terminal/ohmyposh
    ../programs/git
    ../programs/zen-browser
   
  ];


  home = {
    username = username;
    homeDirectory = "/home/${username}";
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

    # Applications
    vesktop


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
