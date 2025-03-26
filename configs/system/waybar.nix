{pkgs, ... }:
let
  var = (import /home/sa3urn/Desktop/Dotfiles/variables/.).var;
in 
{
  home-manager.users.${var.system.user-name} = { pkgs, ... }: {
    programs.waybar = {
        enable = true;
        settings.mainBar = {
            layer = "top";
            position = "bottom";
            spacing = 0;
            height = 35;
            width = 1920;
            margin-bottom = 0;
            modules-left = ["custom/separator" "clock" "sway/workspaces" "pulseaudio" "custom/separator" "sway/language" "custom/separator" ];
            modules-center = [];
            modules-right = ["tray" "custom/separator"  "network" "custom/separator" "bluetooth" "custom/separator" "battery" "custom/separator"];
            
            "clock" = {
                format = "time: {:%H:%M:%S | date: %A, %B %d}";
                timezone = "Europe/Kyiv";
                interval = 5;
            };
            "custom/separator"= {
                format = "  |  ";
                interval = "once";
                tooltip  = false;
            };
            "sway/workspaces" = {
                on-click = "activate";
                format = "| workspace_number: {name} |";
                current-only = true;
            };  
            "sway/language" = {
                format = "language: {long}";
            };
            "network" = {
                format-wifi = "network: {essid} | signal_strength: {signalStrength}%";
                format-ethernet = "network: ethernet";
                format-disconnected = "network: disconnected";
                interval = 5;
                nospacing = 1;
                tooltip = false;
            };
            "bluetooth" = {
                format-on = "bluetooth: on";
                format-off = "bluetooth: off";
                format-disabled = "bluetooth: disabled";
                format-connected = "bluetooth: {device_alias}";
                format-connected-battery = "bluetooth: {device_alias} | bluetooth_battery: {device_battery_percentage}%";
            };
            "pulseaudio" = {
                format = "volume: {volume}%";
                format-muted = "volume: muted";
                smooth-scrolling-threshold=0;
                scroll-step = 0;
                tooltip = false;
            };
            "tray"= {
                icon-size = 21;
                spacing = 10;
                show-passive-items = true;
            };
            "battery" = {
                format = "battery: {capacity}%";
                format-charging = "battery [charging]: {capacity}%";
                interval = 5;
                tooltip = false;
            };
        };
        
        style = ''
        * {
        font-family: Monocraft Nerd Font;
        font-size: 11px;
        }
            
        window#waybar {
        background-color: rgba(0, 0, 0, 0.4);
        }
            
        #workspaces button {
        border: none;
        background: transparent;
        }   
        #workspaces button:hover {
        border: none;
        background: transparent;
        }   
        '';
    };
  };
}