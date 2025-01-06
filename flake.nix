# Nixos configuraion
{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    inputs.ayugram-desktop.packages.${pkgs.system}.ayugram-desktop
  ];
}