{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  age.secrets.ssh-hosts.file = ../../secrets/ssh-hosts.age;

  programs.ssh = {
    enable = true;
    includes = [ config.age.secrets.ssh-hosts.path ];
  };
}
