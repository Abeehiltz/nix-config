{
  config,
  pkgs,
  username,
  hostname,
  hmModules,
  ...
}: {
  imports = [
    "${hmModules}/profiles/base.nix"
    "${hmModules}/profiles/dev.nix"
    "${hmModules}/profiles/media.nix"
    "${hmModules}/profiles/desktop.nix"
    "${hmModules}/profiles/gaming.nix"
    "${hmModules}/profiles/onepassword.nix"

    "${hmModules}/desktop/niri"
    "${hmModules}/desktop/umbriel"
    "${hmModules}/desktop/noctalia-shell"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.
}
