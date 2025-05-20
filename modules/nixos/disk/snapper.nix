{ config, pkgs, lib, inputs, ... }:
{

# Snapper service configuration for automatic snapshots
  services.snapper = {
    configs."root" = {
      SUBVOLUME = "/";  
      FSTYPE = "btrfs";
      ALLOW_USERS = ["_2b"];
    };
    configs."home" = {
      SUBVOLUME = "/home";
      FSTYPE = "btrfs";
      ALLOW_USERS = ["_2b"];
    };
  };
  
}