{ config, pkgs, lib, inputs, ... }:
{

# Btrfs filesystem declarations (find your actual uuid with "lsblk -f")
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/e0398e90-0589-4c4a-af71-65041460ac6f";
    fsType = "btrfs";
    options = ["subvol=@" "compress=zstd" "noatime"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/e0398e90-0589-4c4a-af71-65041460ac6f";
    fsType = "btrfs";
    options = ["subvol=@home" "compress=zstd" "noatime"];
  };
  
}