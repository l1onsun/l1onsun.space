{ pkgs, ... }:
{
    imports = [
      ../programs/direnv.nix
      ../programs/tmux.nix
    ];
    home.packages = [
      pkgs.neofetch
      pkgs.just
      pkgs.onefetch
      pkgs.yazi
      pkgs.ncdu
      pkgs.yazi
      pkgs.w3m
      pkgs.python312Packages.ipython
      # pkgs.broot
    ];
}

