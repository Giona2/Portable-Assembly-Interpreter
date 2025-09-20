{
  description = "Interpreter for the portable assembly format";

  inputs = {
  	nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
    	packages.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "pai";
        version = "0.1.2";

        src = ./.;

        buildInputs = with pkgs; [
        	pkg-config
         	zig
        ];

        buildPhase = ''
       		export ZIG_GLOBAL_CACHE_DIR=$PWD/.zig-cache
       		zig build
        '';

        installPhase = ''
        	mkdir -p $out/bin
         	cp zig-out/bin/pai $out/bin
        '';
     	};
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          pkg-config
          zig
        ];
        shellHook = ''
          zig build
          exit
        '';
      };
    };
}
