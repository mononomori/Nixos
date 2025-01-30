{ config, pkgs, lib, inputs, ...}:

{
  environment.systemPackages = with pkgs; [
    powertop
    power-profiles-daemon

  ];

  # Enable powerManagement, powertop, and power-profiles
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
  services.power-profiles-daemon.enable = true;
}