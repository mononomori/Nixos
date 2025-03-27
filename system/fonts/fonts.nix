{ config, pkgs, lib, inputs, ... }:

let
  ocrFonts = pkgs.stdenv.mkDerivation {
    pname = "ocr-font";
    version = "1.0";
    src = ./OCR-Fonts;
    dontunpack = true;

    installPhase = ''
      mkdir -p $out/share/fonts/truetype
      cp $src/*.ttf $out/share/fonts/truetype/
    '';
  };
in
{
  fonts.packages = with pkgs; [
    iosevka
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    monaspace
    ocrFonts
    dina-font
    proggyfonts

  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

}
