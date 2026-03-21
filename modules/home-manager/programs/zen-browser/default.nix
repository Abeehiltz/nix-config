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
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    };

    profiles."default".extensions.packages = 
      with inputs.firefox-addons.packages.${pkgs.hostPlatform.system}; [
      ];
  };
}
