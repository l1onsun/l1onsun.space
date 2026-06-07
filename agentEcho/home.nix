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

  programs.fish.interactiveShellInit = ''
    if not test (pwd) = "$HOME"; and not string match -q -- "$HOME/*" (pwd)
      echo "ii mirror mode 👾"
      set -gx ORIGINAL_PROJECT_DIR (git rev-parse --show-toplevel); or exit 1
      echo "Project dir: $ORIGINAL_PROJECT_DIR"

      set REPO_MIRROR "$HOME/rootMirror$ORIGINAL_PROJECT_DIR"
      if not test -d "$REPO_MIRROR"
          mkdir -p "$REPO_MIRROR"
          git clone "$ORIGINAL_PROJECT_DIR" "$REPO_MIRROR"; or exit 1
      end
      echo "Mirror: $REPO_MIRROR"
      cd $REPO_MIRROR
    end
  '';
  programs.starship.settings.character.format = "👾 $symbol ";

  home.packages = [
    pkgs.bat
    pkgs.tree
    pkgs.jq
    pkgs.fd
    pkgs.zoxide
    (pkgs.writeShellScriptBin "hii" (builtins.readFile ./hii.sh))
    (pkgs.writeShellScriptBin "ii-sync" (builtins.readFile ./ii-sync.sh))
  ];
  programs.git = {
    enable = true;
    extraConfig = {
      safe.directory = [ "*" ];
    };
  };

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
