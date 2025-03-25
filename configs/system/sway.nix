{pkgs, outputs, inputs, ... }:
let
  var = (import /home/sa3urn/Desktop/Dotfiles/variables/.).var;
in 
{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';
  };
  home-manager.users.${var.system.user-name} = { pkgs, ... }: {
    wayland.windowManager.sway = {
      enable = true;
      config = rec {
        defaultWorkspace = "workspace number 1";
        
        startup = [
          {command = "codium";}
          {command = "nm-applet";}
          {command = "swaybg --image ~/wallpaper.png --mode fill";}
        ];
        fonts = {
          names = [ "Monocraft Nerd Font" ];
        };
        colors = {
          focused =
          {
            background = "#000000";
            border = "#323232";
            childBorder = "#323232";
            indicator = "#000000";
            text = "#ffffff";
          };
          unfocused =
          {
            background = "#000000";
            border = "#323232";
            childBorder = "#323232";
            indicator = "#000000";
            text = "#ffffff";
          };
          focusedInactive =
          {
            background = "#000000";
            border = "#323232";
            childBorder = "#323232";
            indicator = "#000000";
            text = "#ffffff";
          };
          placeholder =
          {
            background = "#000000";
            border = "#323232";
            childBorder = "#323232";
            indicator = "#000000";
            text = "#ffffff";
          };
          urgent =
          {
            background = "#000000";
            border = "#323232";
            childBorder = "#323232";
            indicator = "#000000";
            text = "#ffffff";
          };
        };
        gaps = {
          bottom = 10;
          horizontal = 10;
          inner = 10;
          left = 10;
          outer = 10;
          right = 10;
          top = 10;
          vertical = 10;
        };
        bars = [
          {
            position = "top";
            command = "waybar";
          }
        ];
        input = {
          "*"={
            xkb_layout = "us,ru";
            xkb_options = "grp:win_space_toggle";
          };
        };
        keybindings = {
          "Mod4+1" = "workspace number 1";
          "Mod4+2" = "workspace number 2";
          "Mod4+3" = "workspace number 3";
          "Mod4+4" = "workspace number 4";
          "Mod4+5" = "workspace number 5";
          "Mod4+6" = "workspace number 6";
          "Mod4+7" = "workspace number 7";
          "Mod4+8" = "workspace number 8";
          "Mod4+9" = "workspace number 9";
          "Mod4+0" = "workspace number 10";
          "Mod4+Shift+1" = "move container to workspace number 1";
          "Mod4+Shift+2" = "move container to workspace number 2";
          "Mod4+Shift+3" = "move container to workspace number 3";
          "Mod4+Shift+4" = "move container to workspace number 4";
          "Mod4+Shift+5" = "move container to workspace number 5";
          "Mod4+Shift+6" = "move container to workspace number 6";
          "Mod4+Shift+7" = "move container to workspace number 7";
          "Mod4+Shift+8" = "move container to workspace number 8";
          "Mod4+Shift+9" = "move container to workspace number 9";
          "Mod4+Shift+0" = "move container to workspace number 10";
          "--locked XF86AudioMute" = "exec pactl set-sink-mute \@DEFAULT_SINK@ toggle";
          "--locked XF86AudioLowerVolume" = "exec pactl set-sink-volume \@DEFAULT_SINK@ -5%";
          "--locked XF86AudioRaiseVolume" = "exec pactl set-sink-volume \@DEFAULT_SINK@ +5%";
          "--locked XF86AudioMicMute" = "exec pactl set-source-mute \@DEFAULT_SOURCE@ toggle";
          "--locked XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
          "--locked XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
          "--locked XF86AudioPlay" = "exec playerctl play";
          "--locked XF86AudioPause" = "exec playerctl pause";
          "--locked Mod4+XF86AudioRaiseVolume" = "exec playerctl next";
          "--locked Mod4+XF86AudioLowerVolume" = "exec playerctl previous";
          "--locked XF86AudioNext" = "exec playerctl next";
          "--locked XF86AudioPrev" = "exec playerctl previous";
          "--locked Mod4+XF86AudioMute" = "exec playerctl play-pause";

          "Mod4+Left" = "resize shrink width 10px";
          "Mod4+Down" = "resize grow height 10px";
          "Mod4+Up" = "resize shrink height 10px";
          "Mod4+Right" = "resize grow width 10px";
          "Mod4+w" = "kill";
          "Mod4+a" = "exec dmenu_run -l 56 -fn 'Monocraft Nerd Font'";
          "Mod4+f" = "fullscreen";

        };
      };
    };
  };
}
