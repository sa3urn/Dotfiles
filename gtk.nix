{ config, pkgs, ... }:

{
  home-manager.users.q3e4ir = { pkgs, ... }: {
    gtk.enable = true;
    gtk.theme.name = "Juno";
    gtk.theme.package = pkgs.juno-theme;
    gtk.gtk3.extraConfig.Settings = ''gtk-application-prefer-dark-theme=1'';
    gtk.gtk4.extraConfig.Settings = ''gtk-application-prefer-dark-theme=1'';
  };
}
