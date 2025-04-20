{ config, pkgs, lib, inputs, ... }:
{
  programs.fish = {
    
    enable = true;

    shellAliases = {
      rm = "rm -i";
    };

    functions.y = ''
      set tmp (mktemp -t "yazi-cwd.XXXXXX")
      yazi $argv --cwd-file="$tmp"
      if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
      end
      rm -f -- "$tmp"
    '';
  };
}