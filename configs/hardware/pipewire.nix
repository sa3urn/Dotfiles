{
  services.pipewire = {
    enable            = true;
    audio.enable      = true;
    jack.enable       = true;
    pulse.enable      = true;
    alsa.enable       = true;
    alsa.support32Bit = true;
  };
}