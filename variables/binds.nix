let 
  user-name = (import /home/sa3urn/Dotfiles/variables/system.nix).user-name;
in
{
  binds = {
    bind = [
      "SUPER, A, exec, hyprctl dispatch closewindow menu; kitty --class menu sway-launcher-desktop"
      "SUPER, W, killactive"
      "SUPER, Q, fullscreen "

      "SUPER, S, exec, hyprctl dispatch closewindow menu; kitty --class menu pulsemixer"
      "SUPER, B, exec, hyprctl dispatch closewindow menu; kitty --class menu bluetui"
      "SUPER, N, exec, hyprctl dispatch closewindow menu; kitty --class menu impala"

      "SUPER, T, exec, hyprctl dispatch closewindow menu;  kitty --class menu tg"
      "SUPER, F, exec, firefox"
      "SUPER, Return, exec, kitty"

      ", PRINT, exec, hyprshot -o /home/${user-name}/Screenshots -m region"
      "SUPER, PRINT, exec, hyprshot -o /home/${user-name}/Screenshots -m output"

      "SUPER, Left, movefocus, l"
      "SUPER, Right, movefocus, r"
      "SUPER, Up, movefocus, u"
      "SUPER, Down, movefocus, d"
          
      "SUPER SHIFT, Left, movewindow, l"
      "SUPER SHIFT, Right, movewindow, r"
      "SUPER SHIFT, Up, movewindow, u"
      "SUPER SHIFT, Down, movewindow, d"

      "SUPER, 1, workspace, 1"
      "SUPER, 2, workspace, 2"
      "SUPER, 3, workspace, 3"
      "SUPER, 4, workspace, 4"
      "SUPER, 5, workspace, 5"
      "SUPER, 6, workspace, 6"
      "SUPER, 7, workspace, 7"
      "SUPER, 8, workspace, 8"
      "SUPER, 9, workspace, 9"
      "SUPER, 0, workspace, 10"
      "SUPER SHIFT, 1, movetoworkspace, 1"
      "SUPER SHIFT, 2, movetoworkspace, 2"
      "SUPER SHIFT, 3, movetoworkspace, 3"
      "SUPER SHIFT, 4, movetoworkspace, 4"
      "SUPER SHIFT, 5, movetoworkspace, 5"
      "SUPER SHIFT, 6, movetoworkspace, 6"
      "SUPER SHIFT, 7, movetoworkspace, 7"
      "SUPER SHIFT, 8, movetoworkspace, 8" 
      "SUPER SHIFT, 9, movetoworkspace, 9"
      "SUPER SHIFT, 0, movetoworkspace, 10"
      "SUPER, mouse_down, workspace, +1"
      "SUPER, mouse_up, workspace, -1"
      ];

    binde = [
      "SUPER CTRL, Left, resizeactive, -50 0"
      "SUPER CTRL, Right, resizeactive, 50 0"
      "SUPER CTRL, Up, resizeactive, 0 -50"
      "SUPER CTRL, Down, resizeactive, 0 50"
      ",XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
      ",XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
      ",XF86AudioMute, exec, pactl set-sink-volume @DEFAULT_SINK@ 0"
      ",XF86AudioPlay, exec, playerctl play"
      ",XF86AudioPause, exec, playerctl pause"
      "SUPER, XF86AudioRaiseVolume, exec, playerctl next"
      "SUPER, XF86AudioLowerVolume, exec, playerctl previous"
      ",XF86AudioNext, exec, playerctl next"
      ",XF86AudioPrev, exec, playerctl previous"
      "SUPER, XF86AudioMute, exec, playerctl play-pause"
      ",XF86MonBrightnessUp, exec, brightnessctl set 10%+"
      ",XF86MonBrightnessDown, exec, brightnessctl set 10%-"
    ];
  };
}