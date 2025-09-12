{ config, pkgs, lib, inputs, ... }:
{

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        memtest86.enable = true;
        configurationLimit = 7;
      };
    };
    initrd = {
      kernelModules = [ "amdgpu" ];
      supportedFilesystems = [ "btrfs" ];
    };
  };
  
}