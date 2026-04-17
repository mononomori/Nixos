{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      rm = "rm -i";
    };
    functions.y = ''
      set tmp (mktemp -t "yazi-cwd.XXXXXX")
      yazi $argv --cwd-file="$tmp"
      set exit_code $status
      if test -e "$tmp"
        if set cwd (command cat -- "$tmp"); and test -n "$cwd"; and test "$cwd" != "$PWD"
          builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
      end
      return $exit_code
    '';
    interactiveShellInit = ''
      # Unset the variable that triggers Kitty shell integration
      set -e KITTY_INSTALLATION_DIR
      set -g fish_term24bit 1
    '';
  };
}
