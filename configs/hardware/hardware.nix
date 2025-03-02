let
  var = (import /home/sa3urn/Desktop/Dotfiles/variables/.).var;
in
{
  boot.loader = {
    systemd-boot.enable      = true;
    efi.canTouchEfiVariables = true;
  };

   services.pipewire = {
    enable            = true;
    audio.enable      = true;
    jack.enable       = true;
    pulse.enable      = true;
    alsa.enable       = true;
    alsa.support32Bit = true;
  };

  networking = {
    hostName = var.system.user-name; 
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 1701 9001 7777 ];
      allowedUDPPortRanges = [{from = 4000; to = 4007;} {from = 7000; to = 8010;}];
    };
  };

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