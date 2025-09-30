{config, pkgs, lib, inputs, ... }:
{
  programs.vesktop = {
    enable = true;

    settings = {
      arRPC = true;
      clickTrayToShowHide = true;
      discordBranch = "stable";
      hardwareAcceleration = true;
      hardwareVideoAcceleration = true;
      minimizeToTray = true;
      tray = true;
    };

    vencord.themes.laintop = pkgs.writeText "laintop.css" (builtins.readFile ./laintop.css);
    
    vencord.settings = {
      useQuickCss = false;
      enabledThemes = [ "laintop.css" ];
    };
  };
}