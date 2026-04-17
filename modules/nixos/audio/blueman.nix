{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
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
    settings = {
      General = {
        Experimental = true;
      };
      Policy = {
        AutoEnable = false;
      };
    };
  };
  services.blueman.enable = true;

}
