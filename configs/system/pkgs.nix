{pkgs, inputs, config, ...}:
{
  environment.systemPackages = with pkgs; [
    git
    firefox
    vscodium
    python311
    wine
    wine64
    qbittorrent
    prismlauncher
    wpsoffice
    obsidian
    gnome.gnome-software
    appimage-run
    discord
    telegram-desktop
    droidcam
    linuxKernel.packages.linux_hardened.v4l2loopback
    tor-browser
    bottles
    blender
    nimble
  ];
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    oxygen
    kate
    okular
    elisa

  ];
  services.flatpak.enable = true;
  fonts.packages = with pkgs; [monocraft];
}