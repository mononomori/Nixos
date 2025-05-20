{ config, pkgs, lib, inputs, ... }:

let
  iosevka-aile = pkgs.callPackage ./iosevka-aile-fonts/iosevka-aile.nix { };
  iosevka-etoile = pkgs.callPackage ./iosevka-etoile-fonts/iosevka-etoile.nix { };
  iosevka-b = pkgs.callPackage ./iosevka-b-fonts/iosevka-b.nix { };
  ocr = pkgs.callPackage ./ocr-fonts/ocr.nix { };
in
{
  fonts.packages = builtins.attrValues {
    inherit (pkgs)
      iosevka
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      monaspace
      dina-font
      proggyfonts
    ;
      mplus-outline-fonts-githubRelease = pkgs.mplus-outline-fonts.githubRelease;
      # custom fonts
      iosevka-aile = iosevka-aile;
      iosevka-b = iosevka-b;
      iosevka-etoile = iosevka-etoile;
      ocr = ocr;
    }
    # include all nerd fonts
    ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

}
