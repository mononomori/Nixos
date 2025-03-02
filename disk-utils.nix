{ config, pkgs, lib, inputs, diskusers, ...}:
{

  users = {
    users = lib.genAttrs diskusers (name: {
      extraGroups = [ "disk" ];
    });
  };

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