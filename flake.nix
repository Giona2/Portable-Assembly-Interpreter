{
  description = "Interpreter for the portable assembly format";

  outputs = { self, nixpkgs}:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          pkg-config
        ];
        shellHook = ''
          export PKG_CONFIG_PATH=${pkgs.sdl3}/lib/pkgconfig
          zig build
          exit
        '';
      };
    };
}
