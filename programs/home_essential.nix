{ pkgs, ... }:
{
  imports = [
    ../programs/helix.nix
    ../programs/zellij
    ../programs/git.nix
    ../programs/fish
    ../programs/starship.nix
    ../programs/fzf.nix
  ];
  home.packages = [
    pkgs.bind
    pkgs.bat
    pkgs.tree
    pkgs.killall
    pkgs.ripgrep
    pkgs.jq
    pkgs.sd
    pkgs.bottom
    pkgs.zoxide
  ];
}
