{
  outputs,
  pkgs,
  username,
  ...
}:
{
  # Nixpkgs configuration
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # Nix settings
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
    };
    optimise.automatic = true;
    package = pkgs.nix;
  };

  users.users.${username} = {
    shell = pkgs.fish;
    description = "Abee user";
    uid = 501;
  };

  users.knownUsers = [ "${username}" ];

  system.primaryUser = "${username}";

  # Add ability to use TouchID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    nerd-fonts.fira-code
  ];

  # Shell setup
  programs.fish.enable = true;

  # TO delete later
        environment.systemPackages = with pkgs; [
          vim
          _1password-cli
          argocd
          eza
          fd
          kubernetes-helm
          lazygit
          zoxide
          lua-language-server
          neofetch
          zsh-powerlevel10k
          prettierd
          stylua
          talosctl
          typescript-language-server
          wget
          yaml-language-server
          yamllint
          zsh-autosuggestions
          zsh-syntax-highlighting
          kubectl
          kompose
          _1password-gui
          obsidian
          zsh
          neovim
          inetutils
          terraform
        ];

}
