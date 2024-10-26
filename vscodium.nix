{ config, pkgs, ... }:
{
  ### SET VSCODE AS DEFAULT EDITOR ###
  environment.variables.SUDO_EDITOR    = "codium";
  environment.variables.SYSTEMD_EDITOR = "codium";
  environment.variables.EDITOR         = "codium";
  environment.variables.VISUAL         = "codium";
  home-manager.users.q3e4ir = { pkgs, ... }: {
    programs.vscode.enable = true;
    programs.vscode.package = pkgs.vscodium;
    ### USER SETTINGS ###
    programs.vscode.userSettings = {
        "editor.minimap.enabled" = false;
        "editor.fontFamily" = "JetBrainsMono Nerd Font";
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "files.autoSave" = "afterDelay";
        "window.menuBarVisibility" = "toggle";
        "workbench.colorTheme" = "Tokyo Night";
        "workbench.iconTheme" = "eq-material-theme-icons";
        "window.customTitleBarVisibility" = "auto";
        "workbench.statusBar.visible" = false;
        "workbench.activityBar.location" = "bottom";
        "terminal.integrated.fontFamily" = "monospace";
    };
    ### EXTENSIONS ###
    programs.vscode.extensions = with pkgs.vscode-extensions; [
        equinusocio.vsc-material-theme-icons
        alefragnani.project-manager
        enkia.tokyo-night
        jnoortheen.nix-ide
    ];

    programs.git.enable = true;
    programs.git.userEmail = "durychyaroslav@gmail.com";
    programs.git.userName = "q3e4ir";
  };
}