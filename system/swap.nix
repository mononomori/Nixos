{ config, pkgs, lib, inputs, ... }:

{
  zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "zstd";
    memoryPercent = 50;
    swapDevices = 2;
  };

}