{
  description = "lambda build";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-21.05";
    utils.url = "github:numtide/flake-utils";
    numo.url = "path:/Users/alex/Repos/github.com/numo-core/nix";
    # "git+ssh://git@github.com/numo-core/nix?ref=lambda-build&rev=04029786c243b243cc8033d655f7e679fe66a00a";
  };

  outputs = { self, nixpkgs, utils, numo }:
    let systems = [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ];
    in utils.lib.eachSystem systems (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        defaultPackage =
          numo.packages.${system}.build-lambda { projectDir = ./.; };
      });
}
