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
        modules-left = ["clock" "hyprland/window"];
        modules-center = ["hyprland/workspaces"];
        modules-right = ["tray" "bluetooth" "network" "pulseaudio" "hyprland/language" "battery"];

        "hyprland/window" = {
          format = "{}";
          rewrite = {"" = "q3e4ir@nixos";};
          };
        "hyprland/language" = {
          format = "{long}";
          };
        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            default = "";
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            active = "󱓻";
            urgent = "󱓻";
            };
          "persistent_workspaces" = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
           };
          };
        "memory" = {
          interval = 5;
          format = "󰍛 %";
          max-length = 10;
          };
        "bluetooth" = {
          format = "󰂯";
          on-click = "blueman-manager";
          };
        "tray" = {
          spacing = 10;
          };
        "clock" = {
          format = "  {:%I:%M %p |   %a %d %b %Y}";
          tooltip-format = "{calendar}";
          };
        "network" = {
          format-wifi = "{icon}";
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          format-ethernet = "󰀂";
          format-disconnected = "󰖪";
          tooltip-format-wifi = "{icon} {essid}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-ethernet = "󰀂  {ifname}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-disconnected = "Disconnected";
          on-click = "nm-connection-editor";
          interval = 5;
          nospacing = 1;
          };
        "pulseaudio" = {
          format = "{icon}: {volume}%";
          nospacing = 1;
          format-muted = "󰝟";
          format-icons = {
            headphone = "";
            default = ["󰖀" "󰕾" ""];
            };
          on-click = "pavucontrol";
          scroll-step = 1;
          };
        "battery" = {
          format = "{icon} {capacity}%";
          format-icons = {
            charging = ["󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
            default = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            };
          format-full = "Charged ";
          interval = 5;
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
        border-radius: 0;
        min-height: 0;
        font-family: JetBrainsMono Nerd Font;
        font-size: 13px;
      }
      
      window#waybar {
        background-color: #181825;
        transition-property: background-color;
        transition-duration: 0.5s;
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
      
      #memory,
      #window,
      #custom-power,
      #battery,
      #backlight,
      #pulseaudio,
      #network,
      #clock,
      #bluetooth,
      #language,
      #tray {
        border-radius: 4px;
        margin: 6px 3px;
        padding: 6px 12px;
        background-color: #1e1e2e;
        color: #181825;
      }
      
      #custom-power {
        margin-right: 6px;
      }
      
      #memory {
        background-color: #fab387;
      }
      
      #battery {
        background-color: #f38ba8;
      }
      
      @keyframes blink {
        to {
          background-color: #f38ba8;
          color: #181825;
        }
      }
      
      #battery.warning,
      #battery.critical,
      #battery.urgent {
        background-color: #ff0048;
        color: #181825;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
      #window{
        background-color: #f2cdcd;
        border: none;
        border-radius: 0;
        min-height: 0;
        font-family: JetBrainsMono Nerd Font;
        font-size: 13px;
      }
      
      window#waybar {
        background-color: #181825;
        transition-property: background-color;
        transition-duration: 0.5s;
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
      
      #memory,
      #window,
      #custom-power,
      #battery,
      #backlight,
      #pulseaudio,
      #network,
      #clock,
      #bluetooth,
      #language,
      #tray {
        border-radius: 4px;
        margin: 6px 3px;
        padding: 6px 12px;
        background-color: #1e1e2e;
        color: #181825;
      }
      
      #custom-power {
        margin-right: 6px;
      }
      
      #memory {
        background-color: #fab387;
      }
      
      #battery {
        background-color: #f38ba8;
      }
      
      @keyframes blink {
        to {
          background-color: #f38ba8;
          color: #181825;
        }
      }
      
      #battery.warning,
      #battery.critical,
      #battery.urgent {
        background-color: #ff0048;
        color: #181825;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
      #window{
        background-color: #f2cdcd;
      }
      
      #language{
        background-color: #e095d9;
      }
      
      #battery.charging {
        background-color: #a6e3a1;
      }
      
      #backlight {
        background-color: #fab387;
      }
      
      #pulseaudio {
        background-color: #f9e2af;
      }
      
      #network {
        background-color: #94e2d5;
        padding-right: 17px;
      }
      
      #clock {
        font-family: JetBrainsMono Nerd Font;
        background-color: #cba6f7;
      }
      
      #bluetooth {
        background-color: #87b4fb;
      }
      
      
      tooltip {
        border-radius: 8px;
        padding: 15px;
        background-color: #131822;
      }
      
      tooltip label {
        padding: 5px;
        background-color: #131822;
      }
      #battery.charging {
        background-color: #a6e3a1;
      }
      
      #backlight {
        background-color: #fab387;
      }
      
      #pulseaudio {
        background-color: #f9e2af;
      }
      
      #network {
        background-color: #94e2d5;
        padding-right: 17px;
      }
      
      #clock {
        font-family: JetBrainsMono Nerd Font;
        background-color: #cba6f7;
      }
      
      #bluetooth {
        background-color: #87b4fb;
      }
      
      
      tooltip {
        border-radius: 8px;
        padding: 15px;
        background-color: #131822;
      }
      
      tooltip label {
        padding: 5px;
        background-color: #131822;
      }
    '';
  };
}
