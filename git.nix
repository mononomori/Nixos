{config, lib, pkgs, inputs, gitusers, ...}:

{
  programs.git = {
    enable = true;
    config = lib.foldl' (acc: user: acc // {
      "${user.name}" = {
        user = {
          name = user.name;
          email = user.email;
        };
      };
    }) {} gitusers;
  };


  environment.systemPackages = [pkgs.gitFull];

}
  
