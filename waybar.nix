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
        
        "hyprland/language" = {
          format = "  {short}";
          };
        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            "1" = "󰘐 VScode";
            "2" = "󰈹 Firefox";
            "3" = " Spotify   Telegram";
            "4" = "󱓻";
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
           };
          };
        "bluetooth" = {
          format-on = "󰂯 {status}";
          format-off = "󰂲";
          format-connected = "󰂯 {device_alias}";
          format-connected-battery = "󰂯 {device_alias} {device_battery_percentage}%";
          on-click = "blueman-manager";
          };
        "clock" = {
          format = "  {:%I:%M %p |   %a %d %b %Y}";
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
        "battery" = {
          format = "{icon} {capacity}%";
          format-icons = {
            charging = ["󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
            default = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            };
          interval = 1;
          states = {
            warning = 20;
            critical = 10;
            };
          tooltip = false;
          };
        };
      };

    programs.waybar.style = ''
    * {
        border: none;
        min-height: 0;
        font-family: JetBrainsMono Nerd Font;
        font-size: 13px;
      }
      
      window#waybar {
        background-color: transparent;
      }
      
      window#waybar.hidden {
        opacity: 0.5;
      }
      
      #workspaces {
        background-color: transparent;
      }
      
      #workspaces button {
        all: initial;
        min-width: 0;
        box-shadow: inset 0 -3px transparent;
        padding: 6px 18px;
        margin: 6px 3px;

        border-radius: 4px;
        background-color: #1e1e2e;
        color: #cdd6f4;
      }
      
      #workspaces button.active {
        color: #1e1e2e;
        background-color: #cdd6f4;
      }
      
      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        color: #1e1e2e;
        background-color: #cdd6f4;
      }
      
      #workspaces button.urgent {
        background-color: #f38ba8;
      }
      
      #window,
      #battery,
      #pulseaudio,
      #network,
      #clock,
      #bluetooth,
      #language,
      #pulseaudio-slider,
      #tray {
        border-radius: 4px;
        margin: 6px 3px;
        padding: 6px 18px;
        background-color: #1e1e2e;
         color: #cdd6f4;
      }
      
      #battery {
        margin-right: 15px;
      }
      
      #memory {
      }

      @keyframes blink {
        to {
          color: #181825;
        }
      }
      
      #battery.warning,
      #battery.critical,
      #battery.urgent {
        color: #181825;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
      #window{
      }
      
      #language{
      }
      
      #backlight {
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
      
      #bluetooth {
      }
    '';
  };
}
