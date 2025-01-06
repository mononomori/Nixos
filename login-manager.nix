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
        command = "${tuigreet} --time --time-format '%a, %d %b %Y • %T' --greeting  '[Become \n              Visible]' --asterisks --remember --cmd Hyprland --theme 'border=lightred;title=gray;greet=gray;text=gray;prompt=lightred;time=gray;action=gray;button=gray;container=black;input=gray'";
        user = "greeter";
      };
    };
  };
}