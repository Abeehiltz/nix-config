{
  outputs,
  username,
  hostname,
  pkgs,
  ...
}:
{
  imports = [
    ../terminal/zsh
    ../terminal/ohmyposh
    ../programs/git
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
