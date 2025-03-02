{pkgs, outputs, inputs, ... }:
let
  var = (import /home/sa3urn/Dotfiles/variables/.).var;
in 
{
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma";
  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = var.system.user-name;
  };

  home-manager.users.${var.system.user-name} = { pkgs, ... }: {
    imports = [inputs.plasma-manager.homeManagerModules.plasma-manager];
    programs.plasma = {
      enable = true;
      kscreenlocker.autoLock = false;
      workspace = {
          clickItemTo = "open";
          colorScheme = "BreezeDark";
          lookAndFeel = "org.kde.breezedark.desktop";
          iconTheme = "breeze-dark";
          theme = "breeze-dark";
          cursor = {
            theme = "breeze_cursors";
            size = 24;
          };
        };
      fonts = {
        general = {
          family = "Monocraft Nerd Font";
          pointSize = 10;
        };
        fixedWidth = {
          family = "Monocraft Nerd Font";
          pointSize = 10;
        };
        small = {
          family = "Monocraft Nerd Font";
          pointSize = 8;
        };
        toolbar = {
          family = "Monocraft Nerd Font";
          pointSize = 10;
        };
        menu = {
          family = "Monocraft Nerd Font";
          pointSize = 10;
        };
        windowTitle = {
          family = "Monocraft Nerd Font";
          pointSize = 10;
        };

      };
      panels = [
        {
          location = "bottom";
          widgets = [
            {
              kickoff = {
                sortAlphabetically = true;
                icon = "nix-snowflake-white";
              };
            }
            {
              iconTasks = {
                launchers = [
                  "applications:firefox.desktop"
                  "applications:org.kde.dolphin.desktop"
                  "applications:org.kde.konsole.desktop"
                ];
                behavior = {
                  showTasks = {
                    onlyInCurrentScreen = true;
                    onlyInCurrentDesktop = true;
                    onlyInCurrentActivity = true;
                  };
                };
              };
            }
            "org.kde.plasma.marginsseparator"
            {
              pager = {
                general = {
                  showWindowOutlines = false;
                  showApplicationIconsOnWindowOutlines = false;
                  showOnlyCurrentScreen = false;
                  navigationWrapsAround = true;
                  displayedText = "desktopNumber";
                  selectingCurrentVirtualDesktop = "doNothing";
                };
              };
            }
            {
              systemTray.items = {
                shown = [
                  "org.kde.plasma.battery"
                ];
                hidden = [
                ];
                configs = {
                  battery.showPercentage = true;
                };
              };
            }
            {
              digitalClock = {
                time = {
                  showSeconds = "always";
                  format = "24h";
                };
                calendar = {
                  firstDayOfWeek = "monday";
                  showWeekNumbers = true;
                  plugins = [ "holidaysevents" "astronomicalevents" ];
                };
              };
            }
          ];
          hiding = "none";
          floating = false;
        }
      ];
      kwin = {
        effects = {
          blur.enable = true;
          dimAdminMode.enable = true;
          wobblyWindows.enable = true;
          minimization.animation = "magiclamp";
        };
        titlebarButtons = {
          left = ["more-window-actions"];
          right = ["keep-above-windows" "minimize" "maximize" "close" ];
        };
        virtualDesktops = {
          number = 4;
          rows = 1;
          names = [
            "Desktop 1"
            "Desktop 2"
            "Desktop 3"
            "Desktop 4"
          ];
        };
      };
      configFile = {
        plasmashellrc."Notification Messages".klipperClearHistoryAskAgain = false;
        #ksmserverrc.General.loginMode = "emptySession";
        ksmserverrc.General.shutdownType = 2;
        kwinrc.MouseBindings.CommandActiveTitlebar2 = "Minimize";
        kwinrc.MouseBindings.CommandAllWheel = "Maximize/Restore";
        kwinrc.MouseBindings.CommandInactiveTitlebar2 = "Minimize";
        kwinrc.MouseBindings.CommandTitlebarWheel = "Previous/Next Desktop";
        kwinrc.Windows.DelayFocusInterval = 0;
        kwinrc.Windows.FocusPolicy = "FocusFollowsMouse";
        kwinrc.Windows.NextFocusPrefersMouse = true;
        kcminputrc.Mouse.XLbInptAccelProfileFlat = true;
        kded5rc.Module-device_automounter.autoload = true;
        kactivitymanagerdrc.activities.Default = "Default";
        kactivitymanagerdrc.activities.Communication = "Communication";
        kactivitymanagerdrc.activities-icons.Default = "activities";
        kactivitymanagerdrc.activities-icons.Communication = "activities";
        kactivitymanagerdrc.main.currentActivity = "Default";
        kxkbrc.Layout.Use = true;
        kxkbrc.Layout.Options = "grp:win_space_toggle,caps:escape";
        kxkbrc.Layout.ResetOldOptions = true;
        kxkbrc.Layout.ShowLayoutIndicator = true;
        systemsettingsrc.systemsettings_sidebar_mode.HighlightNonDefaultSettings = true;
      };
      shortcuts = {
        #"org.kde.konsole.desktop"."_launch" = "Meta+Alt+T";
        kwin = {
          "Window Close" = "Meta+W";
          "Kill Window" = "Meta+Shift+W";
          "Window Minimize" = "Meta+Esc";
          "Overview" = "Meta+Tab";
        };
      };
    };
  };
}
