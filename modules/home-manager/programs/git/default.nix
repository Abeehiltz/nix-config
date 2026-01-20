{ username, ...}:
{
  programs.git = {
    enable = true;

    settings.user = {
      email = "36138393+Abeehiltz@users.noreply.github.com";
      name = username;
    };


    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
