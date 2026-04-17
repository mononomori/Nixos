{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{

  services.tailscale.enable = true;
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

}
