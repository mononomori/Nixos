{ lib, pkgs, ... }:

let
  orchis = pkgs.orchis-theme;
in {
  # Injected before Hyprland config located at hyprland.nix.
  wayland.windowManager.hyprland.extraConfig = lib.mkBefore ''

    # XDG specifications
    env = XDG_CURRENT_DESKTOP,Hyprland
    env = XDG_SESSION_TYPE,wayland
    env = XDG_SESSION_DESKTOP,Hyprland

    # Toolkit backend variables
    env = GDK_BACKEND,wayland,x11,*
    env = SDL_VIDEODRIVER,wayland
    env = CLUTTER_BACKEND,wayland

    # Qt variables
    env = QT_AUTO_SCREEN_SCALE_FACTOR,1
    env = QT_QPA_PLATFORM,wayland;xcb
    env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
    env = QT_QPA_PLATFORMTHEME,qt5ct:qt6ct
    env = QT_STYLE_OVERRIDE,adwaita-dark

    # Theming related variables (Orchis)
    env = GTK_DATA_PREFIX,${orchis}
    env = GTK_THEME,Orchis-Pink-Dark

    # Cursor
    env = XCURSOR_SIZE,16
    env = XCURSOR_THEME,Bibata-Modern-Classic

    # Browsers / Electron
    env = MOZ_ENABLE_WAYLAND,1
    env = MOZ_USE_XINPUT2,1
    env = NIXOS_OZONE_WL,1

    # Misc
    env = TERMINAL,kitty
  '';
}
