{ pkgs ? import <nixpkgs> { system = "x86_64-linux"; } }:

let
  overrides = import ./overrides.nix { inherit pkgs; };
  poetry-lambda = pkgs.poetry2nix.mkPoetryApplication {
    projectDir = ./.;
    python = pkgs.python38;
    overrides = pkgs.poetry2nix.overrides.withDefaults overrides;
  };

  my-python-packages = [ poetry-lambda ];
  lambdaZip = pkgs.python38.buildEnv.override {
    extraLibs = my-python-packages;
    postBuild = ''
      (cd $out/${pkgs.python38.sitePackages}; ${pkgs.zip}/bin/zip $out/lambda.zip *)
      rm -rf $out/bin $out/lib $out/include $out/share
    '';
  };
in lambdaZip
