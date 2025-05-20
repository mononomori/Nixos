{ config, pkgs, lib, inputs, ...}:
# Steam requires some system level privileges for full functionality
{

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      gamescope
      gamemode
      steam
    ;
  };
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    gamemode = {
      enable = true;
    };
  };
  
}



