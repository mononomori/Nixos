{ config, pkgs, lib, inputs, ...}:
{

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

    # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filtered
      cups-browsed
      hplip
    ];
  };
}
