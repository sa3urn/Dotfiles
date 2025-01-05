let
  var = (import /home/sa3urn/Dotfiles/variables/.).var;
in
{
  users.users.${var.system.user-name} = {
    isNormalUser = true;
    extraGroups  = ["audio" "networkmanager" "wheel" "input"];
  };
}