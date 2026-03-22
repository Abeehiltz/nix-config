{ lib, pkgs, username, ...}:
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

      # 1password ssh signing
      gpg.format = "ssh";
      "gpg \"ssh\"" = {
        program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      };
      commit = {
        gpgsign = true;
      };

      user = {
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIxS+EO9has3Kcuo+O+kNRroyWMjV+RUfOATTzEmmVzR";
      };
    };
  };
}
