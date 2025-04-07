{ config, pkgs, lib, inputs, ...}:
# Steam requires some system level privileges for full functionality
{
  environment.systemPackages = with pkgs; [
    gamescope
    gamemode
    steam
    steam-tui
  ];
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



