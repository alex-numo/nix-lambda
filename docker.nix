{ pkgs ? import <nixpkgs> { } }:

let
  overrides = import ./overrides.nix { inherit pkgs; };
  poetry-lambda = import ./default.nix { inherit pkgs; };
  inherit (pkgs.dockerTools) buildImage buildLayeredImage pullImage;
in buildLayeredImage {
  name = "poetryLambda";
  tag = "latest";
  config = {
    Env =
      [ "PATH=${poetry-lambda}/bin/:${pkgs.bash}/bin:${pkgs.coreutils}/bin" ];
  };
  contents = [ poetry-lambda pkgs.bash pkgs.coreutils ];
}
