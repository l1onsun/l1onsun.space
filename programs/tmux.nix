{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    package = pkgs.tmux;
    plugins = with pkgs; [
      tmuxPlugins.rose-pine
    ];
  };
}
