{ config, pkgs, lib, inputs, videousers, ...}:
{
# Add users to video (fixed an issue with brightnessctl)
  users = {
    users = lib.genAttrs videousers (name: {
      extraGroups = lib.mkAfter [ "video" ];
    });
  };

}