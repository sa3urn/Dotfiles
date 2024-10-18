{ config, pkgs, ... }:

{
  home-manager.users.q3e4ir = { pkgs, ... }: {
    ### HYPRPAPER ###
    services.hyprpaper.enable = true;
    services.hyprpaper.settings = { 
      preload = "/home/q3e4ir/wallpaper.png";
      wallpaper = "eDP-1, /home/q3e4ir/wallpaper.png";
    };
    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.settings."###" = ''
    ###
    monitor=,preferred,auto,1
    env = XCURSOR_SIZE,24
    input {
      kb_layout = us,ru
      kb_variant =
      kb_model =
      kb_options = grp:win_space_toggle
      kb_rules = 

      follow_mouse = 1

      touchpad {
          natural_scroll = yes
      }

      sensitivity = -0.1
    }

    general {
      gaps_in = 5
      gaps_out = 5
      border_size = 2
      col.active_border = rgb(b4befe)
      col.inactive_border = rgb(1e1e2e)
      layout = dwindle
      allow_tearing = false
    }

    decoration {
      rounding = 5

      blur {
        enabled = true
        size = 3
        passes = 1
      }

      drop_shadow = yes
      shadow_range = 4
      shadow_render_power = 3
      col.shadow = rgba(1a1a1aee)
      active_opacity = 0.97
      inactive_opacity = 0.95
    }

    animations {
      enabled = yes

      bezier = myBezier, 0.05, 0.9, 0.1, 1.05

      animation = windows, 1, 7, myBezier
      animation = windowsOut, 1, 7, default, popin 80%
      animation = border, 1, 10, default
      animation = borderangle, 1, 8, default
      animation = fade, 1, 7, default
      animation = workspaces, 1, 6, default
    }

    dwindle {
      pseudotile = yes
      preserve_split = yes 
    }


    gestures {
      workspace_swipe = off
    }

    misc {
      force_default_wallpaper = 0 
      disable_splash_rendering = true
      disable_hyprland_logo = true
    }

    $mainMod = SUPER
    $editor = codium

    exec-once = waybar
    exec-once = hyprpaper

    windowrulev2 = stayfocused,       class:(Lxpolkit)

    bind = $mainMod, RETURN,                  exec, kitty --hold

    bind = $mainMod, A,                       exec, wofi --show drun

    bind = $mainMod, W,                       killactive, 
    bind = $mainMod, M,                       exit, 
    bind = $mainMod, F,                       togglefloating, 
    bind = $mainMod, J,                       togglesplit, 

    bind = $mainMod, 1,                       workspace, 1
    bind = $mainMod, 2,                       workspace, 2
    bind = $mainMod, 3,                       workspace, 3
    bind = $mainMod, 4,                       workspace, 4
    bind = $mainMod, 5,                       workspace, 5
    bind = $mainMod, 6,                       workspace, 6
    bind = $mainMod, 7,                       workspace, 7
    bind = $mainMod, 8,                       workspace, 8
    bind = $mainMod, 9,                       workspace, 9
    bind = $mainMod, 0,                       workspace, 10

    bind = $mainMod SHIFT, 1,                 movetoworkspace, 1
    bind = $mainMod SHIFT, 2,                 movetoworkspace, 2
    bind = $mainMod SHIFT, 3,                 movetoworkspace, 3
    bind = $mainMod SHIFT, 4,                 movetoworkspace, 4
    bind = $mainMod SHIFT, 5,                 movetoworkspace, 5
    bind = $mainMod SHIFT, 6,                 movetoworkspace, 6
    bind = $mainMod SHIFT, 7,                 movetoworkspace, 7
    bind = $mainMod SHIFT, 8,                 movetoworkspace, 8
    bind = $mainMod SHIFT, 9,                 movetoworkspace, 9
    bind = $mainMod SHIFT, 0,                 movetoworkspace, 10

    bind = $mainMod, mouse_down, workspace,   e+1
    bind = $mainMod, mouse_up, workspace,     e-1

    bindm = $mainMod, mouse:272,              movewindow
    bindm = $mainMod, mouse:273,              resizewindow
    '';
  };
}
