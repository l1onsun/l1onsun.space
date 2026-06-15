{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    package = pkgs.tmux;
    
    # Скролл мышкой
    mouse = true;
    
    # Корректные цвета для vim/helix
    terminal = "tmux-256color";
    
    # Быстрый ответ на escape (для vim/helix)
    escapeTime = 0;
    
    # Больше истории
    historyLimit = 10000;
    
    plugins = with pkgs; [
      tmuxPlugins.rose-pine
    ];
    
    extraConfig = ''
      # Правильная передача Shift+Enter и других модификаторов
      bind -n S-Enter send-keys Escape '[13;2u'
      bind -n C-Enter send-keys Escape '[13;5u'
      
      # Включить extended keys (fix для модификаторов в терминале)
      set -g extended-keys on
      # set -g extended-keys-format csi-u
      
      # True color support
      set -ga terminal-overrides ",alacritty:Tc"
      set -ga terminal-overrides ",alacritty*:Tc"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides ",xterm*:Tc"
    '';
  };
}
