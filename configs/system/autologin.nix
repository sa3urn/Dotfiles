let
  var = (import /home/sa3urn/Dotfiles/variables/.).var;
in
{
  services = {
    getty.autologinUser = var.system.user-name;
    greetd = {
      enable = true;
      settings.default_session = {
        user    = var.system.user-name;
        command = "Hyprland";
      };
    };
  };
}