{
  programs.vesktop = {
    enable = true;
    vencord.settings = {
      useQuickCss = true;
      transparent = true;
      nativeTitleBar = true;

      notifications = {
        timeout = 5000;
        position = "bottom-right";
        useNative = "not-focused";
        logLimit = 50;
      };

      plugins = {
        AlwaysAnimate.enabled = true;
        BetterUploadButton.enabled = true;
        VolumeBooster.enabled = true;
        Experiments = {
          enabled = true;
          toolbarDevMenu = false;
        };

        NoTrack = {
          enabled = true;
          disableAnalytics = true;
          allowBadgeTracking = true;
        };
        Settings = {
          enabled = true;
          settingsLocation = "aboveNitro";
          includeVencordInfoWhenCopying = true;
        };
        WebKeybinds = {
          enabled = true;
          showNavigationButtons = false;
          overrideCommonKeybinds = true;
        };
        WebScreenShareFixes = {
          enabled = true;
          betterCodecs = true;
        };
      };
    };
  };
}
