{pkgs, ... }:
let
  var = (import /home/sa3urn/Dotfiles/variables/.).var;
in 
{
  system.stateVersion                = var.system.nix-version;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree         = true;
  documentation.nixos.enable         = false;

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone      = "Europe/Kyiv";
  environment.variables = {
    SUDO_EDITOR    = "codium";
    SYSTEMD_EDITOR = "codium";
    EDITOR         = "codium";
    VISUAL         = "codium";
  };
}