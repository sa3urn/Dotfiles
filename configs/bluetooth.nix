let
  user-name = (import /home/sa3urn/Dotfiles/variables/system.nix).user-name;
in
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Name = user-name;
        ControllerMode = "dual";
        FastConnectable = "true";
        Experimental = "true";
      };
      Policy = {AutoEnable = "true";};
      LE = {EnableAdvMonInterleaveScan = "true";};
    };
  };
}