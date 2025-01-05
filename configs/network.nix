let
  user-name = (import /home/sa3urn/Dotfiles/variables/system.nix).user-name;
in
{
  networking = {
    hostName = user-name; 
    wireless.iwd.enable = true;
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
  };
}