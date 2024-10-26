{ config, pkgs, ... }:

{
  home-manager.users.q3e4ir = { pkgs, ... }: {
    programs.waybar.enable = true;
    programs.waybar.settings = {
      mainBar = {
        layer = "top";
        position = "top";
        spacing = 0;
        height = 25;

        modules-left = ["clock" "hyprland/workspaces"];
        modules-center = [];
        modules-right = ["network" "bluetooth" "pulseaudio" "pulseaudio/slider" "hyprland/language" "battery"];

        "clock" = {
          format = "  {:%I:%M %p |   %a %d %b}";
          locale = "uk_UA.UTF-8";
          timezone = "Europe/Kyiv";
          };
        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            "1" = " VScodium";
            "2" = "󰈹 Floorp";
            "3" = " Spotify   Telegram";
            "4" = " Steam";
            "5" = "󱓻";
            "6" = "󱓻";
            "7" = "󱓻";
            "8" = "󱓻";
            "9" = "󱓻";
            };
          "persistent_workspaces" = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
           };
          };

        "network" = {
          format-wifi = "⇣{bandwidthDownBytes}  | {icon} |  ⇡{bandwidthUpBytes}";
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          format-ethernet = "⇣{bandwidthDownBytes} | 󰀂 | ⇡{bandwidthUpBytes}" ;
          format-disconnected = "⇣{bandwidthDownBytes}  | 󱘖 | ⇡{bandwidthUpBytes}";
          on-click = "nm-connection-editor";
          interval = 5;
          nospacing = 1;
          tooltip = false;
          };

        "bluetooth" = {
          format-on = "󰂯 {status}";
          format-off = "󰂲";
          format-connected = "󰂯 {device_alias}";
          format-connected-battery = "󰂯 {device_alias} {device_battery_percentage}%";
          on-click = "blueman-manager";
          };
        "pulseaudio" = {
          format = "{icon}  {volume}%";
          format-muted = "󰝟";
          format-icons = {
            default = ["󰖀" "󰕾" ""];
            };
          on-click = "pavucontrol";
          smooth-scrolling-threshold=0;
          scroll-step = 0;
          tooltip = false;
          };

          "pulseaudio/slider" = {
            "min" = 0;
            "max" = 150;
            "orientation" = "horizontal";
            };
          "hyprland/language" = {
          format = "  {short}";
          };

          "battery" = {
            format = "{icon} {capacity}%";
            format-icons = {
              charging = ["󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
              default = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            };
            interval = 1;
            tooltip = false;
            states = {
              warning = 20;
              critical = 10;
            };
          };
        };
      };

    programs.waybar.style = ''
    * {
        font-family: JetBrainsMono Nerd Font;
        font-size: 13px;
      }
      
      window#waybar {
        background-color: transparent;
      }
      
      #window,
      #battery,
      #pulseaudio,
      #network,
      #clock,
      #bluetooth,
      #language,
      #pulseaudio-slider,
      #workspaces button {
        border-radius: 4px;
        margin: 6px 3px;
        padding: 6px 18px;
        background-color: #1e1e2e;
         color: #cdd6f4;
      }
      
      #pulseaudio:hover,
      #network:hover,
      #bluetooth:hover,
      #pulseaudio-slider:hover,
      #workspaces button:hover {
        color: #1e1e2e;
        background-color: #cdd6f4;
      }

     #pulseaudio-slider:hover {
        color: #cdd6f4;
        background-color: #1e1e2e;
      }

      #workspaces {
        background-color: transparent;
      }
      
      #workspaces button.active {
        color: #1e1e2e;
        background-color: #cdd6f4;
      }
      
      
      #workspaces button.urgent {
        background-color: #f38ba8;
      }
      
      #battery {
        margin-right: 15px;
      }
      
      #memory {
      }
      
      #battery.warning,
      #battery.critical,
      #battery.urgent {
        color: #f38ba8;
      }

      #pulseaudio-slider slider {
          min-height: 0px;
          min-width: 0px;
          opacity: 0;
      }
      #pulseaudio-slider trough {
          min-height: 10px;
          min-width: 80px;
          border-radius: 5px;
      }
      
      #network {
        min-width:  225px;
      }
      
      #clock {
        margin-left: 15px;
      }
      
    '';
  };
}
