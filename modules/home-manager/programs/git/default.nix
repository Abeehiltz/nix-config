{ username, ...}:
{
  programs.git = {
    enable = true;
    userName = username;
    userEmail = "36138393+Abeehiltz@users.noreply.github.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
