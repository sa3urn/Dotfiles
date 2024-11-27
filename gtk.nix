{ config, pkgs, ... }:

{
  home-manager.users.sa3urn = { pkgs, ... }: {
    gtk.enable = true;
    gtk.theme.name = "Tokyonight-Dark-B";
    gtk.iconTheme.name = "Tokyonight-Dark";
    gtk.theme.package = pkgs.tokyo-night-gtk;
    gtk.gtk3.extraConfig.Settings = ''gtk-application-prefer-dark-theme=1'';
    gtk.gtk4.extraConfig.Settings = ''gtk-application-prefer-dark-theme=1'';
  };
}
