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
      pkgs.python313Packages.ipython
      pkgs.tlrc
      pkgs.fd
      # pkgs.broot
    ];
}

