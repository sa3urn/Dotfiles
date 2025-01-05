let
  var = (import /home/sa3urn/Dotfiles/variables/.).var;
in
{
  networking = {
    hostName = var.system.user-name; 
    wireless.iwd.enable = true;
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
  };
}