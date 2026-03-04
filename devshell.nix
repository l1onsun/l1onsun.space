nixpkgs:
let
  lib = nixpkgs.lib;
  forSystem = lib.genAttrs [
    "x86_64-linux"
  ];
  pkgsFor = forSystem (system: import nixpkgs { inherit system; });
in
forSystem (
  system:
  let
    pkgs = pkgsFor."${system}";
  in
  {
    default = pkgs.mkShell {
      buildInputs = [
        pkgs.git-subrepo
      ];
      env = {
        # UV_NO_SYNC = "1";
      };
    };
  }
)
