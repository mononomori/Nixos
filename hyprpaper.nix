{config, lib, pkgs, inputs, ...}:

let
  wallpaper = pkgs.fetchurl {
    url = "file:///etc/nixos/wallpaper.jpeg";
    hash = "1170f56x3cjgrd79wbikr7ll6v0ahwyxlnmpf4l8j1v8c9l0vxsx";
  };
in
{
    services.hyprpaper = {
        enable = true;
        settings = {
            ipc = "on";
            preload = [        
            (builtins.toString wallpaper)
            ];

            wallpaper  = [
                "DP-1,${builtins.toString wallpaper}"
            ];
        };
    };
}