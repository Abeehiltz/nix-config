{ inputs, ... }:
{
  imports = [ 
    inputs.noctalia.homeModules.default 
    ./bar.nix
    ./dock.nix
    ./theming.nix
    ./desktop.nix
    ./control-center.nix
  ];
  
  programs.noctalia = {
    enable = true;

    settings.shell = {
      font_family = "FiraCode Nerd Font Mono";
      setup_wizard_enabled = false;
      niri_overview_type_to_launch_enabled = true;
      avatar_path = "/home/abee/.avatar";
      middle_click_opens_widget_settings = false;

      panel = {
        session_placement = "floating";
        open_near_click_control_center = true;
      };
    };

    settings.osd = {
      kinds = {
        brightness = false;
        wifi = false;
        bluetooth = false;
        caffeine = false;
      };
    };

    settings = {
      appLauncher = {
        enableClipboardHistory = true;
        autoPasteClipboard = false;
        enableClipPreview = true;
        clipboardWrapText = true;
        clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
        clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";
        position = "center";
        pinnedApps = [
    
        ];
        useApp2Unit = false;
        sortByMostUsed = true;
        terminalCommand = "kitty -e";
        customLaunchPrefixEnabled = false;
        customLaunchPrefix = "";
        viewMode = "grid";
        showCategories = true;
        iconMode = "tabler";
        showIconBackground = false;
        enableSettingsSearch = true;
        enableWindowsSearch = true;
        enableSessionSearch = true;
        ignoreMouseInput = false;
        screenshotAnnotationTool = "";
        overviewLayer = false;
        density = "default";
      };
      controlCenter = {
        position = "close_to_bar_button";
        diskPath = "/";
        shortcuts = {
          left = [
            {
              id = "Notifications";
            }
            {
              id = "Network";
            }
            {
              id = "NoctaliaPerformance";
            }
            {
              id = "PowerProfile";
            }
          ];
          right = [
            {
              id = "KeepAwake";
            }
            {
              id = "NightLight";
            }
            {
              id = "WallpaperSelector";
            }
          ];
        };
        cards = [
          {
            enabled = true;
            id = "profile-card";
          }
          {
            enabled = true;
            id = "shortcuts-card";
          }
          {
            enabled = true;
            id = "audio-card";
          }
          {
            enabled = false;
            id = "brightness-card";
          }
          {
            enabled = true;
            id = "weather-card";
          }
          {
            enabled = true;
            id = "media-sysmon-card";
          }
        ];
      };
      systemMonitor = {
        cpuWarningThreshold = 80;
        cpuCriticalThreshold = 90;
        tempWarningThreshold = 80;
        tempCriticalThreshold = 90;
        gpuWarningThreshold = 80;
        gpuCriticalThreshold = 90;
        memWarningThreshold = 80;
        memCriticalThreshold = 90;
        swapWarningThreshold = 80;
        swapCriticalThreshold = 90;
        diskWarningThreshold = 80;
        diskCriticalThreshold = 90;
        diskAvailWarningThreshold = 20;
        diskAvailCriticalThreshold = 10;
        batteryWarningThreshold = 20;
        batteryCriticalThreshold = 5;
        enableDgpuMonitoring = false;
        useCustomColors = false;
        warningColor = "";
        criticalColor = "";
        externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
      };
      notifications = {
        enabled = true;
        enableMarkdown = false;
        density = "default";
        monitors = [
    
        ];
        location = "top_right";
        overlayLayer = true;
        backgroundOpacity = 1;
        respectExpireTimeout = false;
        lowUrgencyDuration = 3;
        normalUrgencyDuration = 8;
        criticalUrgencyDuration = 15;
        clearDismissed = true;
        saveToHistory = {
          low = false;
          normal = false;
          critical = true;
        };
        sounds = {
          enabled = false;
          volume = 0.5;
          separateSounds = false;
          criticalSoundFile = "";
          normalSoundFile = "";
          lowSoundFile = "";
          excludedApps = "discord,firefox,chrome,chromium,edge";
        };
        enableMediaToast = false;
        enableKeyboardLayoutToast = true;
        enableBatteryToast = true;
      };
      osd = {
        enabled = true;
        location = "top_right";
        autoHideMs = 2000;
        overlayLayer = true;
        backgroundOpacity = 1;
        enabledTypes = [
          0
          1
          2
        ];
        monitors = [
    
        ];
      };
      audio = {
        volumeStep = 5;
        volumeOverdrive = false;
        cavaFrameRate = 30;
        visualizerType = "linear";
        mprisBlacklist = [
    
        ];
        preferredPlayer = "";
        volumeFeedback = false;
      };
      brightness = {
        brightnessStep = 5;
        enforceMinimum = true;
        enableDdcSupport = false;
      };
      colorSchemes = {
        useWallpaperColors = true;
        predefinedScheme = "Monochrome";
        darkMode = true;
        schedulingMode = "off";
        manualSunrise = "06:30";
        manualSunset = "20:00";
        generationMethod = "faithful";
        monitorForColors = "DP-1";
      };
      templates = {
        activeTemplates = [
          {
            enabled = true;
            id = "zenBrowser";
          }
          {
            enabled = true;
            id = "kitty";
          }
          {
            enabled = true;
            id = "discord";
          }
          {
            enabled = true;
            id = "yazi";
          }
          {
            enabled = true;
            id = "qt";
          }
          {
            enabled = true;
            id = "gtk";
          }
          {
            enabled = true;
            id = "steam";
          }
          {
            enabled = false; # To enable when it handles starship from nixos config
            id = "starship";
          }
        ];
        enableUserTheming = false;
      };
      nightLight = {
        enabled = false;
        forced = false;
        autoSchedule = true;
        nightTemp = "4000";
        dayTemp = "6500";
        manualSunrise = "06:30";
        manualSunset = "18:30";
      };
      plugins = {
        autoUpdate = false;
      };

    };
  }; 
}
