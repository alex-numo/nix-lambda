{ pkgs ? import <nixpkgs> { system = "x86_64-linux"; } }:

let
  overrides = import ./overrides.nix { inherit pkgs; };
  poetry-lambda = import ./default.nix { inherit pkgs; };
  inherit (pkgs.dockerTools) buildImage buildLayeredImage pullImage;
in
buildLayeredImage {
  name = "poetryLambda";
  tag = "latest";
  config = {
    Cmd = [ "${poetry-lambda}/bin/python" "-m" "awslambdaric" "poetry_lambda.poetry_lambda.main" ];
    Env =
      [ "PATH=${poetry-lambda}/bin/:${pkgs.bash}/bin:${pkgs.coreutils}/bin" ];
    WorkingDir = "/";
  };
  contents = [ poetry-lambda pkgs.bash pkgs.coreutils ];
}
