{config, lib, pkgs, inputs, ...}:

{
  environment.systemPackages = [pkgs.gitFull];
  programs.git.enable = true;
  programs.git.config.user.name = "mononomori";
  programs.git.config.user.email = "miguel.a.cannuli@gmail.com";
}
  
