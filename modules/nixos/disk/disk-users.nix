{ config, pkgs, lib, inputs, diskusers, ...}:
{

  users = {
    users = lib.genAttrs diskusers (name: {
      extraGroups = lib.mkAfter [ "disk" ];
    });
  };
  
}