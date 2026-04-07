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

  # ntsync emulates Windows sync primitives for better windows gaming performance.

  boot.kernelModules = [ "ntsync" ]; 

  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "ntsync-udev-rules";
      text = ''KERNEL=="ntsync", MODE="0660", TAG+="uaccess"'';
      destination = "/etc/udev/rules.d/70-ntsync.rules";
    })
  ];
  
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
  hardware = {
    steam-hardware = {
      enable = true;
    };
  };
  # Enable usage of nintendo joycons and pro controllers
  services.joycond.enable = true;
}



