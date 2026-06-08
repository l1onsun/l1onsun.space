{ pkgs, ... }:

{
  home.username = "agentEcho";
  home.homeDirectory = "/home/agentEcho";

  home.sessionPath = [ "$HOME/.local/bin" ];

  imports = [
    ../programs/direnv.nix
    ../programs/git.nix
    ../programs/fish
    ../programs/helix.nix
    ../programs/starship.nix
    ../programs/fzf.nix
    ../programs/ripgrep.nix
    ../crypt/ai_models.nix
  ];

  home.file.".pi/agent/AGENTS.md".enable = false;
  home.file.".pi/agent/extensions".enable = false;
  home.file.".pi/agent/skills".enable = false;

  programs.fish.loginShellInit = ''
    if not test (pwd) = "$HOME"; and not string match -q -- "$HOME/*" (pwd)
      set -gx ORIGINAL_PROJECT_DIR (git rev-parse --show-toplevel); or exec true
      set REPO_MIRROR "$HOME/rootMirror$ORIGINAL_PROJECT_DIR"
      if not test -d "$REPO_MIRROR"
          mkdir -p "$REPO_MIRROR"
          git clone "$ORIGINAL_PROJECT_DIR" "$REPO_MIRROR"; or exec true
      end
      cd $REPO_MIRROR

      if test -n "$II_ARGS"
        eval exec $II_ARGS
      else
        echo "ii mirror mode 👾"
        echo "Project dir: $ORIGINAL_PROJECT_DIR"
        echo "Mirror: $REPO_MIRROR"
      end
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
  programs.git.extraConfig.safe.directory = [ "*" ];

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
