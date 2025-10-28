{ config, pkgs, lib, inputs, ... }:
let
  # Bundle SDK + runtime + aspnetcore into one ref
  dotnet-full =
    with pkgs.dotnetCorePackages;
    combinePackages [
      sdk_9_0
      runtime_9_0
      aspnetcore_9_0
    ];

  # VS Code FHS with packages visible to extensions
  vscodeFhs =
    pkgs.vscode.fhsWithPackages (ps: with ps; [
      dotnet-full
      mono
      msbuild
      zlib
      openssl.dev
      pkg-config
      stdenv.cc
      cmake
    ]);
in
{
  programs.vscode = {
    enable = true;

    # Wrap the FHS build to export DOTNET_ROOT for the SDK inside the container
    package = vscodeFhs.overrideAttrs (prev: {
      nativeBuildInputs = (prev.nativeBuildInputs or []) ++ [ pkgs.makeWrapper ];
      postFixup = (prev.postFixup or "") + ''
        wrapProgram $out/bin/code \
          --set DOTNET_ROOT "${dotnet-full}/share/dotnet" \
          --prefix PATH : "$HOME/.dotnet/tools"
      '';
    });
  };
}
