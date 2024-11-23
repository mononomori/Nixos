{ config, pkgs, lib, inputs, ...}:
{
  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];
  security = {
    sudo.wheelNeedsPassword = false;
    polkit = {
      enable = true;
      debug = true;
    };    
  };
}