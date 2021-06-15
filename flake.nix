{
  description = "lambda build";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-21.05";
    utils.url = "github:numtide/flake-utils";
    numo.url = "git+ssh://git@github.com/numo-core/nix?ref=lambda-build&rev=3dcc044265032b3efeae2e954579d9ea9756aa34";
    numo.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, utils, numo }:
    let
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
    in
    utils.lib.eachSystem systems (system: {
      defaultPackage =
        nixpkgs.legacyPackages.${system}.callPackage numo.packages.${system}.build-lambda { };
    });
}
