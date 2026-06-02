{ pkgs, lib, ... }:

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

  home.file.".pi/agent/AGENTS.md".enable = false;
  home.file.".pi/agent/extensions".source = lib.mkForce ./pi/agent/extensions;
  home.file.".pi/agent/skills".enable = false;

  home.packages = [
    pkgs.bat
    pkgs.tree
    pkgs.jq
    pkgs.fd
    pkgs.zoxide
    pkgs.git
    (pkgs.writeShellScriptBin "hii" (builtins.readFile ./hii.sh))
  ];

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
