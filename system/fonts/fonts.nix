{ config, pkgs, lib, inputs, ... }:

let
  iosevka-aile = pkgs.callPackage ./iosevka-aile-fonts/iosevka-aile.nix { };
  iosevka-etoile = pkgs.callPackage ./iosevka-etoile-fonts/iosevka-etoile.nix { };
  iosevka-b = pkgs.callPackage ./iosevka-b-fonts/iosevka-b.nix { };
  ocr = pkgs.callPackage ./ocr-fonts/ocr.nix { };
in
{
  fonts.packages = with pkgs; [
    iosevka
    iosevka-aile
    iosevka-b
    iosevka-etoile
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    monaspace
    ocr
    dina-font
    proggyfonts

  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

}
