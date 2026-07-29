{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs) dotool;
  };

  # dotool needs write access to /dev/uinput; upstream ships this rule but the
  # nixpkgs package doesn't install it, so it's added here.
  services.udev.extraRules = ''
    KERNEL=="uinput", GROUP="input", MODE="0620", OPTIONS+="static_node=uinput"
  '';

}