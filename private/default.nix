if builtins.pathExists ./private.nix then
  import ./private.nix
else
  { pkgs, ... }: {
    # modules = {};
    home.packages = [
      pkgs.gcc
    ];
  }
