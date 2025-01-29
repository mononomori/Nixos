{ config, pkgs, lib, inputs, ...}:
{
  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
    pavucontrol
    pipewire
    wireplumber
  ];

    # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Enable bluetooth with blueman.
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;
}