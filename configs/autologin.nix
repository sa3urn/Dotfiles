let
  user-name = (import /home/sa3urn/Dotfiles/variables/system.nix).user-name;
in
{
  services = {
    getty.autologinUser = user-name;
    greetd = {
      enable = true;
      settings.default_session = {
        user    = user-name;
        command = "Hyprland";
      };
    };
  };
}