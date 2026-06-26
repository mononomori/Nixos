{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      lutris
      ;
  };

  systemd.settings.Manager.DefaultLimitNOFILE = 524288;
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "hard";
      item = "nofile";
      value = "524288";
    }
  ];

}
