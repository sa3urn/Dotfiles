{pkgs, ... }:
let
  var = (import /home/sa3urn/Dotfiles/variables/.).var;
in 
{
  programs.hyprland.enable = true;
  home-manager.users.${var.system.user-name} = { pkgs, ... }: {
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2.0;
        preload = ["/home/${var.system.user-name}/Dotfiles/wallpaper.jpg"];
        wallpaper = ["eDP-1,/home/${var.system.user-name}/Dotfiles/wallpaper.jpg"];
      };
    };
  };
}
