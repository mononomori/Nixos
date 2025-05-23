{ config, pkgs, lib, inputs, ...}:
{

  environment.systemPackages = with pkgs; [
    #### Disk Management Tools:
    ntfs3g
    udisks
    udiskie
    usbutils
    #### CLI Utilities:
    parted
  ];

  services = {
    gvfs.enable = true;
    udisks2.enable = true;
    fstrim = {
      enable = true;
      interval = "weekly";
    };
  };


}