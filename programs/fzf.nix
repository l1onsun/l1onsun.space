{ pkgs, ... }:
{
  programs.fzf = {
    enable = true;
    package = pkgs.fzf;
    enableFishIntegration = true;
  };
  home.sessionVariables = rec {
    FZF_DEFAULT_COMMAND = "fd --type f --strip-cwd-prefix";
    FZF_CTRL_T_COMMAND = "${FZF_DEFAULT_COMMAND}";
    FZF_DEFAULT_OPTS = "--bind tab:down,shift-tab:up";
  };
  # export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
  # export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  home.packages = [ pkgs.fd ];
}
