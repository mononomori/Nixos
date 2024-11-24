{ config, pkgs, lib, inputs, ... }:

# Enable tuigreet display manager

let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${tuigreet} --time --time-format '%a, %d %b %Y • %T' --greeting  '[Become \n          Visible]' --asterisks --remember --cmd Hyprland --theme 'border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red'";
        user = "greeter";
      };
    };
  };
}