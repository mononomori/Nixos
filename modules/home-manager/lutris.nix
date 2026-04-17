{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      lutris
      ;
  };

}
