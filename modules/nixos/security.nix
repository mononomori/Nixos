{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{

  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];
  security = {
    pam.services.hyprlock = { }; # Required to supress a hyprlock error... Remove later when fix is merged.
    sudo.wheelNeedsPassword = false;
    polkit = {
      enable = true;
    };
  };

  # Needed setuid to create network namespaces (used to isolate vesktop from
  # tailscale0, see modules/home-manager/vesktop/vesktop.nix).
  programs.firejail.enable = true;

}
