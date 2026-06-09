{ pkgs, ... }:
{
  imports = [
    ../programs/helix.nix
    ../programs/zellij
    ../programs/git.nix
    ../programs/git-credential-manager.nix
    ../programs/fish
    ../programs/starship.nix
    ../programs/fzf.nix
    ../programs/ripgrep.nix
  ];
  home.packages = [
    pkgs.bind
    pkgs.bat
    pkgs.tree
    pkgs.killall
    pkgs.jq
    pkgs.sd
    pkgs.bottom
    pkgs.zoxide
  ];
}
