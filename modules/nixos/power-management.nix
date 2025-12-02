{ config, pkgs, lib, inputs, ... }:
{

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      powertop
      tuned
    ;
  };

  # Enable powerManagement and powertop
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  services = {
    tuned = {
      enable = true;
      settings = {
        dynamic_tuning = true;
      };

      ppdSettings = {
        # Automatically change profile based on battery charging state
        main.battery_detection = true;

        # Mapping of TuneD battery states to power-profiles-daemon battery states
        battery = {
          balanced = "balanced-battery";
          performance = "balanced";
          power-saver = "powersave";
        };
        
        # Mapping of TuneD to power-profiles-daemon profiles
        profiles = {
          balanced = "balanced";
          performance = "throughput-performance";
          power-saver = "powersave";
        };
      };
    };

    # Conflicts with TuneD
    auto-cpufreq.enable = false;
    power-profiles-daemon.enable = false;
    tlp.enable = false;
  };

}
