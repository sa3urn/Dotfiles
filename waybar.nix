{inputs, outputs, config, pkgs, ... }:
let
  user-name = "sa3urn";

  ### COLORS ### 
  color-waybar = "rgba(10, 10, 20, 0.8)";
  color-darkgrey = "#181926";
  color-cream = "#f5e0dc";
  color-lightgrey = "#cdd6f4";
  color-grey = "#6c7086";
  color-black = "#45475a";
  color-red = "#f38ba8";
  color-green = "#a6e3a1";
  color-yellow = "#f9e2af";
  color-blue = "#89b4fa";
  color-magenta = "#f5c2e7";
  color-cyan = "#94e2d5";
  color-white = "#bac2de";

in 
{
  ### HOME MANAGER OPTIONS ###
  home-manager.users.${user-name} = { pkgs, ... }: {
    programs.waybar = {
      enable = true;
      settings.mainBar = {
        layer = "top";
        position = "bottom";
        spacing = 0;
        height = 40;
        width = 1200;
        margin-bottom = 5;
        modules-left = ["custom/separator" "clock" "custom/separator" "hyprland/workspaces" "custom/separator" ];
        modules-center = ["custom/spotify-metadata"];
        modules-right = ["custom/separator" "hyprland/language" "custom/separator"  "network" "custom/separator" "bluetooth" "custom/separator" "pulseaudio" "custom/separator" "battery" "custom/separator"];

        "clock" = {
          format = "{:%I:%M %p}";
          timezone = "Europe/Kyiv";
        };

        "custom/separator"= {
          format = "";
          interval = "once";
          tooltip  = false;
        };

        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            active = "";
            default = "";
          };
          "persistent-workspaces"= {
             "*" = 5;
          };
        };  

        "custom/spotify-metadata"= {
          format = "{}";
          max-length = 30;
          interval = 1;
          on-click = "kitty --class menu spotify_player";
          return-type = "json";
          exec = ''status=$(playerctl status); artist=$(playerctl metadata artist); title=$(playerctl metadata title); [[ -z $status ]] && exit; [[ $status == "Playing" ]] && { [[ -z $artist && -z $title ]] && echo "{\"class\": \"playing\", \"text\": \"\"}" || echo "{\"class\": \"playing\", \"text\": \" $artist - $title\"}"; pkill -RTMIN+5 waybar; exit; }; [[ $status == "Paused" ]] && { [[ -z $artist && -z $title ]] && echo "{\"class\": \"paused\", \"text\": \"\"}" || echo "{\"class\": \"paused\", \"text\": \" $artist - $title\"}"; pkill -RTMIN+5 waybar; exit; }'';
        };

        "custom/search"= {
          format = "   ";
          interval = "once";
          on-click = "kitty --class menu sway-launcher-desktop";
          tooltip  = false;
        };

        "hyprland/language" = {
          format = "  {short}";
        };
        
        "network" = {
          format-wifi = "{icon}";
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          format-ethernet = "󰀂 " ;
          format-disconnected = "󱘖 ";
          on-click = "kitty --class menu impala";
          interval = 5;
          nospacing = 1;
          tooltip = false;
        };

        "bluetooth" = {
          format-on = "󰂯";
          format-off = "󰂲";
          format-disabled = "󰂲";
          format-connected = "󰂱";
          format-connected-battery = "󰂱 {device_battery_percentage}%";
          on-click = "kitty --czlass menu bluetui";
        };
        "pulseaudio" = {
          format = "{icon}  {volume}%";
          format-muted = "󰝟";
          format-icons = {
            default = ["󰖀" "󰕾" ""];
          };
          on-click = "kitty --class menu pulsemixer";
          smooth-scrolling-threshold=0;
          scroll-step = 0;
          tooltip = false;
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

      style = ''
      * {
          font-family: JetBrainsMono Nerd Font;
          font-size: 13px;
          color: ${color-white};
        }
        
        window#waybar {
        background-color: ${color-waybar};
        }
        
        #window,
        #battery,
        #pulseaudio,
        #network,
        #clock,
        #bluetooth,
        #language,
        #mpd,
        #workspaces button {
          padding: 6px 12px;
          background-color: transparent;
        }   
      '';
    };