{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      r2modman
      ;
  };
}
