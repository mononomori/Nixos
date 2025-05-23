{ config, pkgs, lib, inputs, ...}:
{

  # Enable hyprland window manager
  programs.hyprland = {
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  # Required for xdg-open, xdg-mime, etc.
  environment.systemPackages = with pkgs; [
    xdg-utils
  ];

  # Enable hyprland cache for faster builds
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # Enable DBus and XDG portals
  services.dbus.enable = true;

  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common.default = [ "gtk" "hyprland" ];
        hyprland.default = [ "gtk" "hyprland" ];
      };
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
      ];
    };
  };
}