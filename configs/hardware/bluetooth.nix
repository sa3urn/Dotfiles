let
  var = (import /home/sa3urn/Dotfiles/variables/.).var;
in
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Name = var.system.user-name;
        ControllerMode = "dual";
        FastConnectable = "true";
        Experimental = "true";
      };
      Policy = {AutoEnable = "true";};
      LE = {EnableAdvMonInterleaveScan = "true";};
    };
  };
}