{
  description = "My flake";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        nativeBuildInputs = [ ];
        buildInputs = with pkgs; [
          cmake
          ninja
        ];
      in
      {
        devShells.default =
          pkgs.mkShell.override { stdenv = pkgs.stdenvAdapters.useMoldLinker pkgs.gcc15Stdenv; }
            {
              packages =
                with pkgs;
                [
                  llvmPackages_21.clang-tools
                  lldb
                  codespell
                  doxygen
                  gtest
                  cppcheck
                ]
                ++ buildInputs
                ++ nativeBuildInputs
                ++ pkgs.lib.optionals pkgs.stdenv.isLinux (
                  with pkgs;
                  [
                    valgrind-light
                  ]
                );
            };
      }
    );
}
