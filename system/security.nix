{ config, pkgs, lib, inputs, ...}:
{
  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];
  security = {
    pam.services.hyprlock = {}; # Required to supress a hyprlock error... Remove later when fix is merged.
    sudo.wheelNeedsPassword = false;
    polkit = {
      enable = true;
      debug = true;
    };    
  };
}