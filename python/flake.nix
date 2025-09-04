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
        pythonVersion = "313";
        python = pkgs."python${pythonVersion}";
      in
      {
        devShells.default = pkgs.mkShell {
          venvDir = ".venv";

          postShellHook = ''
            venvVersionWarn() {
              local venvVersion
              venvVersion="$("$venvDir/bin/python" -c 'import platform; print(platform.python_version())')"

              [[ "$venvVersion" == "${python.version}" ]] && return

              cat <<EOF
            Warning: Python version mismatch: [$venvVersion (venv)] != [${python.version}]
                     Delete '$venvDir' and reload to rebuild for version ${python.version}
            EOF
            }

            venvVersionWarn
          '';

          packages = with python.pkgs; [
            venvShellHook
            uv
          ];
        };
      }
    );
}
