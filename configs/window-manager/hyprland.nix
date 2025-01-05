{pkgs, ... }:
let
  var = (import /home/sa3urn/Dotfiles/variables/.).var;
in 
{
  programs.hyprland.enable = true;
  home-manager.users.${var.system.user-name} = { pkgs, ... }: {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        monitor = ",preferred,auto,1";

        input = {
          kb_layout = "us,ru";
          kb_options = "grp:win_space_toggle";
          repeat_delay = 300;
          repeat_rate = 50;
          follow_mouse = 1;
          sensitivity = -0.1;

          touchpad = {
              natural_scroll = true;
              disable_while_typing = false;
              scroll_factor = 0.2;
          };
        };

        general = {
          gaps_in = 25;
          gaps_out = 50;
          border_size = 0;
          layout = "dwindle";
          allow_tearing = false;
        };

        dwindle = {
          pseudotile = "yes";
          preserve_split = "yes";
        };

        decoration = {
          rounding = 0;
          active_opacity = 0.95;
          inactive_opacity = 0.95;

          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            new_optimizations = true;
          };
        };

        layerrule = [
          "blur,waybar"
        ];

        animations = {
          enabled = "yes";
          bezier = "myBezier, 1, 1, 1, 1";

          animation = [
            "windows, 1, 1, myBezier"
            "windowsOut, 1, 1, default, popin 80%"
            "border, 1, 1, default"
            "borderangle, 1, 1, default"
            "fade, 1, 1, default"
            "workspaces, 1, 1, default"
          ];
        };

        misc = {
          force_default_wallpaper = 0 ;
          disable_splash_rendering = true;
          disable_hyprland_logo = true;
        };

        exec-once = var.autostart;
        bind = var.binds.bind;
        binde = var.binds.binde;

        windowrule = [
          "workspace 1, VSCodium"
          "workspace 2, firefox"
          "workspace 3, Spotify"
          "workspace 4, steam"

          "float, menu"
          "size 1000 500, menu"
          "move 460 530, menu"
          "pin, menu"
          "opacity 0.9, menu"
          "stayfocused, menu"
        ];
      };
    };
  };
}
