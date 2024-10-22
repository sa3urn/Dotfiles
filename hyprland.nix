{ config, pkgs, ... }:

{
  home-manager.users.q3e4ir = { pkgs, ... }: {
    ### HYPRPAPER ###
    services.hyprpaper.enable = true;
    services.hyprpaper.settings = { 
      preload = "/home/q3e4ir/wallpaper.jpg";
      wallpaper = "eDP-1, /home/q3e4ir/wallpaper.jpg";
    };
    ### HYPRLAND ###
    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.settings = {
      monitor = ",preferred,auto,1";
      env = "XCURSOR_SIZE,24";
      input = {
        kb_layout = "us,ru";
        kb_options = "grp:win_space_toggle";
        follow_mouse = 1;
        touchpad = {
            natural_scroll = true;
            disable_while_typing = false;
            scroll_factor = 0.2;
        };
        sensitivity = -0.1;
      };
      general = {
        gaps_in = 15;
        gaps_out = 15;
        border_size = 2;
        "col.active_border" = "rgb(b4befe)";
        "col.inactive_border" = "rgb(1e1e2e)";
        layout = "dwindle";
        allow_tearing = false;
      };

      decoration = {
        rounding = 5;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };

        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
        active_opacity = 0.97;
        inactive_opacity = 0.95;
      };

      animations = {
        enabled = "yes";

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      gestures = {
        workspace_swipe = "off";
      };

      misc = {
        force_default_wallpaper = 0 ;
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
      };

      "$mainMod" = "SUPER";
      "$editor" = "codium";
      exec-once = ["waybar" "hyprpaper" "lxsession" "firefox" "telegram-desktop""spotify" "code"];

      windowrule = [
        "workspace 1, Code"
        "workspace 2, firefox"
        "workspace 3, Spotify"
        "workspace 3, org.telegram.desktop"
        "float, blueman-manager"
        "float, pavucontrol"
        "float, nm-connection-editor"
        "size 1000 600, blueman-manager"
        "size 1000 600, pavucontrol"
        "size 1000 600, nm-connection-editor"
        "move 902 57, blueman-manager"
        "move 902 57, pavucontrol"
        "move 902 57, nm-connection-editor"
        "pin, blueman-manager"
        "pin, pavucontrol"
        "pin, nm-connection-editor"
      ];

      bind = [
      "$mainMod, A, exec, wofi --show drun"
      "$mainMod, W, killactive"
      "$mainMod, M, exit"
      "$mainMod, Q, togglefloating"
      "$mainMod, F, exec, firefox"
      "$mainMod, C, exec, code"
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"
      "$mainMod, mouse_down, workspace, +1"
      "$mainMod, mouse_up, workspace, -1"
      "$mainMod SHIFT, mouse_down, exec, amixer set Master 10%+"
      "$mainMod SHIFT, mouse_up, exec, amixer set Master 10%-"
      ];
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
