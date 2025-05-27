{ config, pkgs, lib, inputs, ...}:
{

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      powertop
      power-profiles-daemon
    ;
  };

  # Enable powerManagement, powertop, and power-profiles
  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "schedutil";
  };
  services.power-profiles-daemon.enable = true;

}