let
  colors = (import /home/sa3urn/Dotfiles/variables/style.nix).colors;
  font = (import /home/sa3urn/Dotfiles/variables/style.nix).font;
  user-name = (import /home/sa3urn/Dotfiles/variables/system.nix).user-name;
in 
{
  home-manager.users.${user-name} = { pkgs, ... }: {
    programs.kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = 0;
        resize_debounce_time    = 0;

        font_size               = 12;
        font_family             = font;

        foreground             = colors.foreground;
        background             = colors.background;
        selection_foreground   = colors.background;
        selection_background   = colors.text;
        cursor                  = colors.text;
        cursor_text_color       = colors.background;
        url_color               = colors.text;
        active_border_color     = colors.foreground;
        inactive_border_color   = colors.background;
        bell_border_color       = colors.yellow;
        active_tab_foreground   = colors.background;
        active_tab_background   = colors.magenta;
        inactive_tab_foreground = colors.foreground;
        inactive_tab_background = colors.background;
        tab_bar_background      = colors.background;
        mark1_foreground        = colors.background;
        mark1_background        = colors.foreground;
        mark2_foreground        = colors.background;
        mark2_background        = colors.magenta;
        mark3_foreground        = colors.background;
        mark3_background        = colors.blue;

        color0                  = colors.black;
        color8                  = colors.black;
        color1                  = colors.red;
        color9                  = colors.red;
        color2                  = colors.green;
        color10                 = colors.green;
        color3                  = colors.yellow;
        color11                 = colors.yellow;
        color4                  = colors.blue;
        color12                 = colors.blue;
        color5                  = colors.magenta;
        color13                 = colors.magenta;
        color6                  = colors.cyan;
        color14                 = colors.cyan;
        color7                  = colors.text;
        color15                 = colors.text;
      };
    };
  };
}
