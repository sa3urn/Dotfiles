let
  user-name = (import /home/sa3urn/Dotfiles/variables/system.nix).user-name;
in
{
  users.users.${user-name} = {
    isNormalUser = true;
    extraGroups  = ["audio" "networkmanager" "wheel" "input"];
  };
}