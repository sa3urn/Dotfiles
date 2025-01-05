let
  var = (import /home/sa3urn/Dotfiles/variables/.).var;
in 
{
  home-manager.users.${var.system.user-name} = { pkgs, ... }: {
    programs.kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = 0;
        resize_debounce_time    = 0;

        font_size               = 12;
        font_family             = var.style.font;
        foreground              = var.style.color.foreground;
        background              = var.style.color.background;
        selection_foreground    = var.style.color.background;
        selection_background    = var.style.color.text;
        cursor                  = var.style.color.text;
        cursor_text_color       = var.style.color.background;
        url_color               = var.style.color.text;
        active_border_color     = var.style.color.foreground;
        inactive_border_color   = var.style.color.background;
        bell_border_color       = var.style.color.yellow;
        active_tab_foreground   = var.style.color.background;
        active_tab_background   = var.style.color.magenta;
        inactive_tab_foreground = var.style.color.foreground;
        inactive_tab_background = var.style.color.background;
        tab_bar_background      = var.style.color.background;
        mark1_foreground        = var.style.color.background;
        mark1_background        = var.style.color.foreground;
        mark2_foreground        = var.style.color.background;
        mark2_background        = var.style.color.magenta;
        mark3_foreground        = var.style.color.background;
        mark3_background        = var.style.color.blue;

        color0                  = var.style.color.black;
        color8                  = var.style.color.black;
        color1                  = var.style.color.red;
        color9                  = var.style.color.red;
        color2                  = var.style.color.green;
        color10                 = var.style.color.green;
        color3                  = var.style.color.yellow;
        color11                 = var.style.color.yellow;
        color4                  = var.style.color.blue;
        color12                 = var.style.color.blue;
        color5                  = var.style.color.magenta;
        color13                 = var.style.color.magenta;
        color6                  = var.style.color.cyan;
        color14                 = var.style.color.cyan;
        color7                  = var.style.color.text;
        color15                 = var.style.color.text;
      };
    };
  };
}
