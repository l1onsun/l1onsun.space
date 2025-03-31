{ pkgs, ... }:
{
  imports = [
    ../programs/helix.nix
    ../programs/zellij
    ../programs/git.nix
    ../programs/fish
    ../programs/starship.nix
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
  programs.fzf = {
    enable = true;
    package = pkgs.fzf;
    enableFishIntegration = true;
  };
}
