{ config, pkgs, lib, inputs, ... }:

let
  ocrbFont = pkgs.stdenv.mkDerivation {
    pname = "ocr-b-font";
    version = "1.0";
    src = ./OCR-B.ttf;
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/share/fonts/truetype
      cp $src $out/share/fonts/truetype/OCR-B.ttf
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
    dina-font
    proggyfonts

  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts)
    ++ [ ocrbFont ];
}
