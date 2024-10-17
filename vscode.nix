{ config, pkgs, ... }:

{
  home-manager.users.q3e4ir = { pkgs, ... }: {
    programs.vscode.enable = true;

    ### USER SETTINGS ###
    programs.vscode.userSettings = {
      "workbench.colorTheme" = "Catppuccin Mocha";
      "editor.minimap.enabled" = false;
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
