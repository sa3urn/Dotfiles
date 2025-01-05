{pkgs, ...}:
let
 font = (import /home/sa3urn/Dotfiles/variables/style.nix).font;
  user-name = (import /home/sa3urn/Dotfiles/variables/system.nix).user-name;
in
{
  home-manager.users.${user-name} = { pkgs, ... }: {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      userSettings = {
        "editor.minimap.enabled" = false;
        "editor.fontFamily" = font;
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "files.autoSave" = "afterDelay";
        "window.menuBarVisibility" = "toggle";
        "workbench.colorTheme" = "Catppuccin Mocha";
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
        catppuccin.catppuccin-vsc
        jnoortheen.nix-ide
        ms-python.python
      ];
    };
  };
}
