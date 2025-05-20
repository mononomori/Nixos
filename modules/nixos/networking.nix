{ config, pkgs, lib, inputs, ...}:
{
  
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      networkmanager
      networkmanager_dmenu
    ;
  };

  # Enable wireless driver in bootloader.
  boot = {
    kernelModules = [ "iwlwifi" ];
  };

  # Enable networking and set hostname
  networking = {
    hostName = "YoRNix";
    networkmanager = {
      enable = true;
      wifi.powersave = false;
      wifi.backend = "iwd";
    };
    wireless.iwd.enable = true;
    wireless.iwd.settings = {
      Network = {
        EnableIPv6 = true;
        RoutePriorityOffset = 300;
      };
      Settings = {
        AutoConnect = true;
      };
    };
    nameservers = [
      "1.1.1.1"
      "9.9.9.9"
      "4.4.4.4"
      "8.8.8.8"
      "8.8.4.4"
    ];
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable firewall and open TCP/UDP ports.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 ];
    allowedUDPPortRanges = [
      { from = 4000; to = 4007; }
      { from = 8000; to = 8010; }
    ];
  };

}
