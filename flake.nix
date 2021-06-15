{
  description = "lambda build";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-21.05";
    numo.url = "git+ssh://git@github.com/numo-core/nix?ref=lambda-build&rev=9100f712896a9212f12561e0bd919c55b00b111a";
    numo.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, numo }:
    let
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in
    {
      defaultPackage = numo.packages.aarch64-darwin.build-lambda { };
    };
}
