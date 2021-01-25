{ pkgs ? import <nixpkgs> { } }:

let
  overrides = import ./overrides.nix { inherit pkgs; };
  poetry-lambda = import ./default.nix { inherit pkgs; };
  inherit (pkgs.dockerTools) buildImage buildLayeredImage pullImage;
  # baseImage = pullImage {
  #   imageName = "amazon/aws-lambda-python";
  #   imageDigest =
  #     "sha256:a2f17966a8829695a7d0a3cb74737116e74ead47b53417e5eb574faebb31e580";
  #   finalImageTag = "3.8.2021.01.13.15";
  #   sha256 = "0sykm12fdazpjsgn90lvak27rdjb7zxvmfvnfk1km3b5ckvayh5i";
  # };
in buildImage {
  name = "poetryLambda";
  tag = "latest";
  # fromImage = baseImage;
  config = {
    Env =
      [ "PATH=${poetry-lambda}/bin/:${pkgs.bash}/bin:${pkgs.coreutils}/bin" ];
  };
  contents = [ poetry-lambda pkgs.bash pkgs.coreutils ];
}
