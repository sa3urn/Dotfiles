{pkgs, outputs, inputs, ... }:
let
  var = (import /home/sa3urn/Desktop/Dotfiles/variables/.).var;
in 
{
  hardware.graphics.enable = true;
  programs.dconf.enable = true;
  hardware.graphics.enable32Bit = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma";
  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = var.system.user-name;
  };
}
