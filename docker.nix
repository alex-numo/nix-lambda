{ pkgs ? import <nixpkgs> {
    system = "x86_64-linux";
  }
, crossPkgs ? import <nixpkgs> {
    system = "aarch64-linux";
  }
}:

let
  overrides = import ./overrides.nix { inherit pkgs; };
  poetry-lambda = import ./default.nix { inherit pkgs; };
  inherit (crossPkgs.dockerTools) buildLayeredImage;
in
buildLayeredImage {
  name = "poetryLambda";
  tag = "latest";
  config = {
    Cmd = [ "${poetry-lambda}/bin/python" "-m" "awslambdaric" "poetry_lambda.poetry_lambda.main" ];
    Env =
      [ "PATH=${poetry-lambda}/bin/" ];
    WorkingDir = "/";
  };
  contents = [ poetry-lambda ];
}
