{ config, pkgs, lib, inputs, ... }:
{

  boot = {
    # Both needed so zswap can use lz4 on boot
    initrd = {
      systemd.enable = true;
      kernelModules = [ "lz4" ];
    };
    kernelParams = [ 
      "zswap.enabled=1"
      "zswap.max_pool_percent=20"
      "zswap.compressor=lz4"
      "zswap.shrinker_enabled=1"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/9db274bb-c23e-4616-a0b0-18c7da0660ad"; }
  ];
}