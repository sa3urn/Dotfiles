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
  programs.nm-applet.indicator = false;
  
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

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC    = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT   = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC  = "performance";
      CPU_MIN_PERF_ON_AC            = 0;
      CPU_MAX_PERF_ON_AC            = 100;
      CPU_MIN_PERF_ON_BAT           = 0;
      CPU_MAX_PERF_ON_BAT           = 20;
      START_CHARGE_THRESH_BAT0      = 70;
      STOP_CHARGE_THRESH_BAT0       = 80;
    };
  };
}