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
        dotnet-sdk = pkgs.dotnet-sdk_8;
        dotnet-runtime = pkgs.dotnetCorePackages.runtime_8_0;
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            dotnet-sdk
            dotnet-runtime
            roslyn-ls
          ];
        };
      }
    );
}
