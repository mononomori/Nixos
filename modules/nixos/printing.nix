{ config, pkgs, lib, inputs, ...}:
{
  # Printers can be configured via http://localhost:631/
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable CUPS printing service
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
      hplip
    ];
  };
}
