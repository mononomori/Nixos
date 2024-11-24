{ config, pkgs, lib, inputs, ... }:

{
  home.packages = with pkgs; [
    hyprlock
  ];

  programs.hyprlock = {
    enable = true;
    settings = {
      general = [
        {
          disable_loading_bar = true;
          grace = 2;
        }
      ];
      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          contrast = 1;
          brightness = 0.5;
          vibrancy = 0.2;
          vibrancy_darkness = 0.2;
        }
      ];
      input-field = [
        {
          monitor = "";
          size = "800, 200";
          outline_thickness = "3";
          inner_color = "rgba(0, 0, 0, 0.0)"; # no fill

          outer_color = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          check_color = "rgba(00ff99ee) rgba(ff6633ee) 120deg";
          fail_color = "rgba(ff6633ee) rgba(ff0066ee) 40deg";

          font_color = "rgb(143, 143, 143)";
          fade_on_empty = false;
          rounding = "15";
          placeholder_text = "Password...";

          position = "0, -20";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
