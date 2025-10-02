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

        jdk = pkgs.openjdk21;
        maven = pkgs.maven.override {
          inherit jdk;
        };
        gradle = pkgs.gradle_8;
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            jdk
            (pkgs.jdt-language-server.override {
              inherit jdk;
            })
            (pkgs.kotlin-language-server.override {
              openjdk = jdk;
              inherit maven gradle;
            })
          ];
        };
      }
    );
}
