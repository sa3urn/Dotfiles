{ config, pkgs, ... }:

{
  home-manager.users.sa3urn = { pkgs, ... }: {
    programs.waybar.enable = true;
    programs.waybar.settings = {
      mainBar = {
        layer = "top";
        position = "top";
        spacing = 0;
        height = 15;

        modules-left = ["clock" "custom/separator" "hyprland/workspaces"];
        modules-center = [];
        modules-right = ["hyprland/language" "custom/separator" "network" "custom/separator" "bluetooth" "custom/separator" "pulseaudio" "custom/separator" "battery"];

        "clock" = {
          format = "{:%I:%M %p}";
          timezone = "Europe/Kyiv";
          };

        "custom/separator"= {
          "format"= "";
          "interval"= "once";
          "tooltip" = false;
        };

        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            "active" = "";
            "default" = "";
          };

          "persistent_workspaces" = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
           };
          };

        "network" = {
          format-wifi = "{icon}";
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          format-ethernet = "󰀂 " ;
          format-disconnected = "󱘖 ";
          on-click = "nm-connection-editor";
          interval = 5;
          nospacing = 1;
          tooltip = false;
          };

        "bluetooth" = {
          format-on = "󰂯";
          format-off = "󰂲";
          format-connected = "󰂱";
          format-connected-battery = "󰂱 {device_battery_percentage}%";
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
      background-color: rgba(17, 25, 40, 0.7);
      }
      
      #window,
      #battery,
      #pulseaudio,
      #network,
      #clock,
      #bluetooth,
      #language,
      #workspaces button {
        padding: 6px 12px;
      }

      #workspaces {
        background-color: transparent;
      }
      
      #workspaces button.active {
      }

      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
      }
      
      #workspaces button.urgent {
      }
      
      #battery {
      }
      
      
      #battery.warning,
      #battery.critical,
      #battery.urgent {
        color: #f38ba8;
      }
      
      #network {
      }
      
      #clock {
      }
      
    '';
  };
}
