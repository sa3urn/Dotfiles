{ config, pkgs, ... }:

{
  ### SET VSCODE AS DEFAULT EDITOR ###
  environment.variables.SUDO_EDITOR    = "code";
  environment.variables.SYSTEMD_EDITOR = "code";
  environment.variables.EDITOR         = "code";
  environment.variables.VISUAL         = "code";

  home-manager.users.q3e4ir = { pkgs, ... }: {
    programs.vscode.enable = true;

    ### USER SETTINGS ###
    programs.vscode.userSettings = {
      "workbench.colorTheme" = "Catppuccin Mocha";
      "editor.minimap.enabled" = false;
      "editor.fontFamily" = "JetBrainsMono Nerd Font";
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
      "files.autoSave" = "afterDelay";
      "window.menuBarVisibility" = "toggle";
      "workbench.activityBar.location" = "bottom";
      "workbench.layoutControl.enabled" = false;
      "window.commandCenter" = false;
      "css.validate" = false;
    };

    ### EXTENSIONS ###
    programs.vscode.extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      jnoortheen.nix-ide
    ];
  };
}
