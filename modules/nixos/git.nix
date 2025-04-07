{ config, lib, pkgs, inputs, gitusers, ... }:

{
  environment.systemPackages = [ pkgs.gitFull ];

  programs.git = {
    enable = true;

    # Dynamically generates Git configurations for user set provided via `specialArgs.gitusers`
    config = lib.foldl'
      (acc: user: acc // { # Add the user's config to the set, keyed by their name
        "${user.name}" = {
          user = {
            name = user.name; # Set the Git user name
            email = user.email; # Set the Git user email
          };
        };
      })
      {} # Start with an empty attribute set
      gitusers; # List of Git users found in flake.nix
  };
}

  
