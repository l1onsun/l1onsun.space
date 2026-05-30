{ pkgs, ... }:

{
  home.username = "agentEcho";
  home.homeDirectory = "/home/agentEcho";

  home.sessionPath = [ "$HOME/.local/bin" ];

  imports = [
    ../programs/fish
    ../programs/helix.nix
    ../programs/starship.nix
    ../programs/fzf.nix
    ../programs/ripgrep.nix
    ../crypt/ai_models.nix
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
