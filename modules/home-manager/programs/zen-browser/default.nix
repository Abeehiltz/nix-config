{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    nativeMessagingHosts = [
      pkgs._1password-gui
    ];

    policies = {
      DisableFirefoxStudies = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Cryptomining = true;
      };
    };

    profiles."default".settings = {
      "browser.aboutConfig.showWarning" = false;
      "browser.tabs.warnOnClose" = false;
      "network.http.http3.enabled" = true;
      "zen.workspaces.continue-where-left-off" = true;
      "zen.workspaces.natural-scroll" = true;
      "zen.welcome-screen.seen" = true;
      "zen.view.compact.enable-at-startup" = false;
      "zen.view.grey-out-inactive-windows" = false;
      "zen.view.show-newtab-button-top" = false;

    };

    profiles."default".extensions.packages =
      with inputs.firefox-addons.packages.${pkgs.hostPlatform.system}; [
      ];
  };
}
