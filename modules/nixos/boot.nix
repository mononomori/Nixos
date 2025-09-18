{ config, pkgs, lib, inputs, ... }:
{
  boot = {
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
    kernelParams = [ "amd_pstate=guided" ];
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
      availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod"  "usbhid" ];
      kernelModules = [ "amdgpu" ];
      supportedFilesystems = [ "btrfs" ];
    };
  };
  
}