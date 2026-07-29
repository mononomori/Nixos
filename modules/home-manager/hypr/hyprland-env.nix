{
  config,
  pkgs,
  lib,
  ...
}:

let
  orchis = pkgs.orchis-theme;
in
{
  xdg.configFile."uwsm/env".text = ''
    # toolkit / theming / cursor / nvidia
    export CLUTTER_BACKEND=wayland
    export SDL_VIDEODRIVER=wayland
    export GDK_BACKEND=wayland,x11,*
    export GDK_DPI_SCALE=1
    export GDK_SCALE=1
    export XDG_SESSION_TYPE=wayland


    export QT_QPA_PLATFORM="wayland;xcb"
    export QT_AUTO_SCREEN_SCALE_FACTOR=1
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export QT_QPA_PLATFORMTHEME=qt5ct
    export QT_QPA_PLATFORMTHEME=qt6ct
    export QT_STYLE_OVERRIDE=adwaita-dark

    export GTK_DATA_PREFIX=${orchis}
    export GTK_THEME=Orchis-Pink-Dark

    export MOZ_ENABLE_WAYLAND=1
    export MOZ_USE_XINPUT2=1

    export TERMINAL=kitty

    export XCURSOR_SIZE=16
    export XCURSOR_THEME=Bibata-Modern-Classic

    export NIXOS_OZONE_WL=1
    export ELECTRON_OZONE_PLATFORM_HINT=wayland
  '';

  xdg.configFile."uwsm/env-hyprland".text = ''
    # hyprland-specific only
    export XDG_CURRENT_DESKTOP=Hyprland
    export XDG_SESSION_DESKTOP=Hyprland

  '';
}
