{ pkgs, username, ... }:
{
  time.timeZone = "Europe/Luxembourg";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_LU.utf8";
    LC_IDENTIFICATION = "fr_LU.utf8";
    LC_MEASUREMENT = "fr_LU.utf8";
    LC_MONETARY = "fr_LU.utf8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "fr_LU.utf8";
    LC_PAPER = "fr_LU.utf8";
    LC_TELEPHONE = "fr_LU.utf8";
    LC_TIME = "en_GB.UTF-8";
  };

  users.users.${username} = {
    isNormalUser = true;
    uid = 3001;
    shell = pkgs.fish;
    description = "Abee user";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIxS+EO9has3Kcuo+O+kNRroyWMjV+RUfOATTzEmmVzR"
    ];
  };
  users.groups.${username} = {
    gid = 3001;
    members = [ username ];
  };

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };
  nix.optimise.automatic = true;

  services.resolved.enable = true;

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
  ];
}
