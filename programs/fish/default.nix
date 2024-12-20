{
  programs.starship.enable = true;
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      starship init fish | source
      direnv hook fish | source
      zoxide init fish | source

      function fish_hybrid_key_bindings --description \
          "Vi-style bindings that inherit emacs-style bindings in all modes"
          for mode in default insert visual
              fish_default_key_bindings -M $mode
          end
          fish_vi_key_bindings --no-erase
          for mode in default insert visual
              bind -M $mode \ej history-token-search-forward
              bind -M $mode \ek history-token-search-backward
          end
      end
      set -g fish_key_bindings fish_hybrid_key_bindings
    '';
    shellAbbrs = {
      gp = "git push";
      g = "git";
      sw = "sway";
      j = "just";
      s = "systemctl";
      gr = "git rebase";
      ga = "git add";
      p = "sudo pacman";
      gs = "git status";
      pm = "python -m manage";
      pss = "sudo pacman -Syu";
      py = "python";
    };
  };
}
