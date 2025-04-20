{ config, pkgs, lib, inputs, ... }:
{
  programs.fish = {

    enable = true;

    shellAliases = {
      rm = "rm -i";
    };

    functions.y = ''
      set tmp (mktemp -t "yazi-cwd.XXXXXX")

      # Run yazi and immediately store the exit status
      yazi $argv --cwd-file="$tmp"
      set exit_code $status

      # Clean up and possibly cd if the temp file exists and is valid
      if test -e "$tmp"
        if set cwd (command cat -- "$tmp"); and test -n "$cwd"; and test "$cwd" != "$PWD"
          builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
      end

      return $exit_code
    '';
  };
}