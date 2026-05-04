{ pkgs, ... }:

{
  home.username = "agent-echo";
  home.homeDirectory = "/home/agent-echo";

  home.sessionPath = [ "$HOME/.local/bin" ];

  imports = [
    ../programs/fish
    ../programs/helix.nix
    ../programs/starship.nix
    ../programs/fzf.nix
    ../programs/ripgrep.nix
    ../programs/claude.nix
  ];

  home.packages = [
    pkgs.bat
    pkgs.tree
    pkgs.jq
    pkgs.fd
    pkgs.zoxide
  ];

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
