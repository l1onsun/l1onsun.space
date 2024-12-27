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
      pkgs.bat
      pkgs.tree
      pkgs.killall
      pkgs.ripgrep
      pkgs.jq
      pkgs.fzf
      pkgs.sd
      pkgs.bottom
      pkgs.zoxide
    ];
}
