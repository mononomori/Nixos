{ config, pkgs, lib, inputs, ... }:

{
  
  home.packages = with pkgs; [
    kitty
  ];
  programs.kitty = {
    enable = true;
    extraConfig = ''
      confirm_os_window_close 0
      shell_integration enabled
      font_family Iosevka Aile Iaso
      font_size 14.0
      bold_font auto
      italic_font auto
      bold_italic_font auto

      bold_text  #CDD6F4
      italic_text #CDD6F4
      bold_italic_text #CDD6F4
     
      background_opacity 0.7

      # The basic colors
      foreground              #CED6F6
      background              #1C1C28
      selection_foreground    #1C1C28
      selection_background    #E9E1D7

      # Cursor colors
      cursor                  #FFB8B8
      cursor_text_color       #1C1C28

      # URL underline color when hovering with mouse
      url_color               #F5B6DC

      # Kitty window border colors
      active_border_color     #A8B9F9
      inactive_border_color   #5C606C
      bell_border_color       #FFD1A8

      # OS Window titlebar colors
      wayland_titlebar_color  #1C1C28
      macos_titlebar_color    #1C1C28

      # Tab bar colors
      active_tab_foreground   #0F0F1B
      active_tab_background   #D7A6F3
      inactive_tab_foreground #CED6F6
      inactive_tab_background #171723
      tab_bar_background      #0F0F1B

      # Colors for marks (marked text in the terminal)
      mark1_foreground #1C1C28
      mark1_background #A8B9F9
      mark2_foreground #1C1C28
      mark2_background #D7A6F3
      mark3_foreground #1C1C28
      mark3_background #71D7EA

      # The 16 terminal colors

      # black
      color0 #3B3D50
      color8 #4C5063

      # red
      color1 #F287A3
      color9 #F287A3

      # green
      color2  #9ED3A3
      color10 #9ED3A3

      # yellow
      color3  #F2D6AF
      color11 #F2D6AF

      # blue
      color4  #81A3F9
      color12 #81A3F9

      # magenta
      color5  #F1B9E3
      color13 #F1B9E3

      # cyan
      color6  #8BD4C5
      color14 #8BD4C5

      # white
      color7  #A8AEC4
      color15 #99A4B8
      
    '';
  };

}