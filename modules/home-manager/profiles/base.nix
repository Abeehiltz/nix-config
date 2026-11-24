{
  username,
  pkgs,
  ...
}:
{
  imports = [
    ../terminal/fish
    ../terminal/starship
    ../terminal/zoxide
    ../terminal/eza
    ../terminal/fd
    ../terminal/fzf
    ../terminal/jq
    ../terminal/git
    ../terminal/ssh
    ../terminal/nvim
    ../terminal/btop
    ../terminal/fastfetch
  ];

  home = {
    inherit username;
    homeDirectory =
      if pkgs.stdenv.hostPlatform.isDarwin then "/Users/${username}" else "/home/${username}";
    sessionVariables.EDITOR = "vim";
    sessionPath = [ "$HOME/.local/bin" ];
  };

  home.packages = with pkgs; [
    ouch
    dysk
    yq-go
    unzip
    zip
  ];
}
