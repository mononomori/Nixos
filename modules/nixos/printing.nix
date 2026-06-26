{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing = {
    enable = true;
    browsing = true;

    browsedConf = ''
      BrowseDNSSDSubTypes _cups,_print
      BrowseLocalProtocols all
      BrowseRemoteProtocols all
      CreateIPPPrinterQueues All
    '';

    drivers = with pkgs; [
      cups-filters
      cups-browsed
      hplip
      hplipWithPlugin
    ];
  };
}
