{ pkgs }:

self: super: {
  psutil = super.psutil.overridePythonAttrs (
    old: {
      buildInputs = old.buildInputs
      ++ (pkgs.lib.optionals pkgs.stdenv.isDarwin [ pkgs.darwin.IOKit ]);
    }
  );
  awslambdaric = super.awslambdaric.overridePythonAttrs (
    old: {
      dontUseCmakeConfigure = true;
      nativeBuildInputs = old.nativeBuildInputs ++ [
        pkgs.gcc
        pkgs.gnumake
        pkgs.cmake
        pkgs.unzip
        pkgs.curlFull.dev
        pkgs.autoconf
        pkgs.automake
        pkgs.libtool
        pkgs.perl
      ];
    }
  );
}
