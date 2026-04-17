{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  # Network printer discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing = {
    enable = true;

    drivers = with pkgs; [
      cups-filters
      cups-browsed
      hplip
      hplipWithPlugin
    ];
  };

  systemd.services = {
    # In case service has network timining issues and fails, try again.
    ensure-printers = {
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      serviceConfig = {
        Restart = "on-failure";
        RestartSec = "10s";
      };
    };
    nscd.unitConfig = {
      StartLimitIntervalSec = lib.mkForce 0;
    };
  };

  hardware.printers = {
    ensureDefaultPrinter = "hp8010";

    ensurePrinters = [
      {
        name = "hp8010";
        description = "HP OfficeJet 8010 series";
        location = "Home";
        deviceUri = "ipp://192.168.1.69/ipp/print";
        model = "everywhere";
      }
    ];
  };
}
