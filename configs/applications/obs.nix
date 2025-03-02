{pkgs, inputs, config, ...}:
{
  programs.obs-studio.enable = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''`
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [
      obs-backgroundremoval
      obs-webkitgtk
      wlrobs
      obs-pipewire-audio-capture
      obs-3d-effect
      obs-move-transition
      obs-composite-blur
      looking-glass-obs
      input-overlay
      droidcam-obs
      advanced-scene-switcher
    ];
}