let
  var = (import /home/sa3urn/Desktop/Dotfiles/variables/.).var;
in
{
  users.users.${var.system.user-name} = {
    isNormalUser = true;
    extraGroups  = ["audio" "networkmanager" "wheel" "input" "adbusers"];
  };
}