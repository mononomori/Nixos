{ config, pkgs, lib, inputs, ...}:
{

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      localsend
      jocalsend
      ;
  };

  programs.localsend.enable = true;

  networking.firewall = {
    allowedTCPPorts = [53317]; # 53317 is a LocalSend port
    allowedUDPPorts = [53317]; # 53317 is a LocalSend port
  };

}