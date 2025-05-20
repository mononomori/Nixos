{ config, pkgs, lib, inputs, ...}:
{

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)    
      blueman
      bluez
      bluez-tools
    ;
  };

  # Enable bluetooth with blueman.
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;
  
}