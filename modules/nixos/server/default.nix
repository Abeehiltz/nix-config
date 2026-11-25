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
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIxS+EO9has3Kcuo+O+kNRroyWMjV+RUfOATTzEmmVzR"
    ];
  };
  users.groups.${username}.gid = 3001;

  programs.fish.enable = true;

  # Needed so you can deploy remotely as your user (no password set in the container)
  security.sudo.wheelNeedsPassword = false;
  nix.settings.trusted-users = [
    "root"
    username
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    dnsutils
    git # needed if you ever build/clone on the container
  ];
}
