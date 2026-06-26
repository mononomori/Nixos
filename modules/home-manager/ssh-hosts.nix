{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      asn1 = {
        hostname = "34.53.7.102";
        user = "alex_croft_cannuli";
        identityFile = "~/.ssh/id_ed25519";
        identitiesOnly = true;
      };
    };
  };
}
