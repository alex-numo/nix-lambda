{ pkgs ? import <nixpkgs> { system = "x86_64-linux"; } }:

let
  overrides = import ./overrides.nix { inherit pkgs; };
  poetry-lambda = pkgs.poetry2nix.mkPoetryApplication {
    projectDir = ./.;
    python = pkgs.python38;
    overrides = pkgs.poetry2nix.overrides.withDefaults overrides;
  };
  my-python-packages = python-packages: with python-packages; [ poetry-lambda ];
in
pkgs.python38.withPackages my-python-packages
