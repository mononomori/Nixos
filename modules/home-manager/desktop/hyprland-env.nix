{ config, lib, pkgs, ... }:
# When hyprland is managed via uwsm, environment variables need to be setup this.
{
  xdg.configFile."uwsm/env".text = ''
    export XDG_SESSION_TYPE=wayland
    export CLUTTER_BACKEND=wayland
    export SDL_VIDEODRIVER=wayland 
    export GDK_BACKEND=wayland,x11,*
    export GDK_DPI_SCALE=1
    export GDK_SCALE=1
    export QT_QPA_PLATFORM=wayland;xcb
    export QT_AUTO_SCREEN_SCALE_FACTOR=1
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export QT_QPA_PLATFORMTHEME=qt5ct:qt6ct
    export QT_STYLE_OVERRIDE=adwaita-dark
    export GTK_THEME=Juno-mirage
    export MOZ_ENABLE_WAYLAND=1
    export MOZ_USE_XINPUT2=1
    export TERMINAL=kitty
    export XCURSOR_SIZE=16
    export XCURSOR_THEME=Bibata-Modern-Classic
    export NIXOS_OZONE_WL=1
  '';

  xdg.configFile."uwsm/env-hyprland".text = ''
    export XDG_CURRENT_DESKTOP=Hyprland
    export XDG_SESSION_DESKTOP=Hyprland
  '';
}
