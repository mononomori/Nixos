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
          hide_cursor = true;
          grace = 1;
        }
      ];
      background = [
        {
          path = "screenshot";
          blur_size = 3;
          blur_passes = 3;
          noise = 0.0117;
          contrast = 1.3000;
          brightness = 0.75;
          vibrancy = 0.2100;
          vibrancy_darkness = 0.05;
        }
      ];

      label = [
        {
          text = ''cmd[update:100] echo "<span font-family='Fira Code' foreground='##e4c9af'>$(date +'%H: %M %S')</span>"'';
          color = "rgba(228,201,175,1.0)";
          font_size = 95;
          font_family = "JetBrains Mono";
          shadow_passes = 2;
          shadow_size	= 2;
          shadow_color = "rgba(105, 57, 69, 1.0)";
          shadow_boost = 1.0;
          position = "2100, 750";
          halign = "left";
          valign = "center";
        }
        {
          text = ''cmd[update:1000] echo "<span font-family='Fira Code' foreground='##d2738a'>$(date +'%A, %B %d')</span>"'';
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 44;
          font_family = "JetBrains Mono";
          shadow_passes = 2;
          shadow_size	= 2;
          shadow_color = "rgba(105, 57, 69, 1.0)";
          shadow_boost = 1.0;
          position = "2100, 650";
          halign = "left";
          valign = "center";
        }
        {
          text = ''cmd[update:50] echo "$(/etc/nixos/user/desktop/scripts/hyprlock-flickering-text.sh)"'';
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 44;
          font_family = "Iosevka Term";
          shadow_passes = 2;
          shadow_size	= 2;
          shadow_color = "rgba(105, 57, 69, 1.0)";
          shadow_boost = 1.0;
          position = "0, 50";
          halign = "center";
          valign = "center";
        }
      ];


      input-field = [
        {
          monitor = "";
          size = "400, 100";
          outline_thickness = "2";
          dots_size = "0.2";
          dots_spacing = "0.35";
          dots_center = true;
          dots_text_format = "の";
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(210, 115, 138, 0.2)";
          font_color = "rgb(228, 201, 175)";
          fade_on_empty = false;
          rounding = -1;
          check_color = "rgba(114, 100, 87, 1.0)";
          placeholder_text = ''<span font-family="Fira Code" foreground="##d2738a">Let's all love</span><span font-family="Fira Code" foreground="##e4c9af"> $USER!</span>'';
          
          hide_input = false;
          position = "0, -200";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
