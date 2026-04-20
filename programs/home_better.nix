{ pkgs, lib, ... }:
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
      pkgs.edir
      pkgs.w3m
      pkgs.python313Packages.ipython
      pkgs.tlrc  # tldr
      pkgs.broot
      (lib.lowPrio pkgs.inetutils)  # telnet +
      pkgs.iputils  # ping
    ];
}

