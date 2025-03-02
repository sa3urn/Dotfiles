{pkgs, ...}:
let
  var = (import /home/sa3urn/Dotfiles/variables/.).var;
in
{
  home-manager.users.${var.system.user-name} = { pkgs, ... }: {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      userSettings = {
        "editor.minimap.enabled" = false;
        "editor.fontFamily" = "Monocraft Nerd Font";
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "files.autoSave" = "afterDelay";
        "window.menuBarVisibility" = "toggle";
        #"workbench.colorTheme" = "Catppuccin Mocha";
        "workbench.iconTheme" = "catppuccin-mocha";
        "window.customTitleBarVisibility" = "auto";
        "workbench.statusBar.visible" = false;
        "workbench.activityBar.location" = "bottom";
        "terminal.integrated.fontFamily" = "monospace";
        "AREPL.showFooter" = false;
      };
      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc-icons
        alefragnani.project-manager
        jnoortheen.nix-ide
        ms-python.python
      ];
    };
  };
}
