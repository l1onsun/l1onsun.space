{ pkgs, ... }:
{
  programs.starship.enable = true;
  programs.fish = {
    enable = true;
    package = pkgs.fish;
    interactiveShellInit = ''
      zoxide init fish | source

      function fish_hybrid_key_bindings --description \
          "Vi-style bindings that inherit emacs-style bindings in all modes"
          for mode in default insert visual
              fish_default_key_bindings -M $mode
          end
          # fish_vi_key_bindings --no-erase
          fish_helix_key_bindings --no-erase
          for mode in default insert visual
              bind -M $mode \ej history-token-search-forward
              bind -M $mode \ek history-token-search-backward
              # bind -M $mode \ee end-of-line
              # bind -M $mode \cE edit_command_buffer
          end
      end
      set -g fish_key_bindings fish_hybrid_key_bindings

      # workaround: should be removed in next update
      set -p fish_complete_path ${pkgs.fish}/share/fish/completions

      # Theme (from fish_frozen_theme.fish)
      set --global fish_color_autosuggestion brblack
      set --global fish_color_cancel -r
      set --global fish_color_command blue
      set --global fish_color_comment red
      set --global fish_color_cwd green
      set --global fish_color_cwd_root red
      set --global fish_color_end green
      set --global fish_color_error brred
      set --global fish_color_escape brcyan
      set --global fish_color_history_current --bold
      set --global fish_color_host normal
      set --global fish_color_host_remote yellow
      set --global fish_color_normal normal
      set --global fish_color_operator brcyan
      set --global fish_color_param cyan
      set --global fish_color_quote yellow
      set --global fish_color_redirection cyan --bold
      set --global fish_color_search_match white --background=brblack
      set --global fish_color_selection white --bold --background=brblack
      set --global fish_color_status red
      set --global fish_color_user brgreen
      set --global fish_color_valid_path --underline
      set --global fish_pager_color_completion normal
      set --global fish_pager_color_description yellow -i
      set --global fish_pager_color_prefix normal --bold --underline
      set --global fish_pager_color_progress brwhite --background=cyan
      set --global fish_pager_color_selected_background -r
    '';
    functions = {
      git-show-psub = ''
        set -l branch_path $argv[1]
        set -l ext (string match -r '\.[^.]+$' $branch_path)
        git show $branch_path | psub -s $ext
      '';
    };
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
    plugins = [
      {
        name = "fish-helix";
        src = pkgs.stdenv.mkDerivation {
          name = "fish-helix-drv";
          src = ../../vendor/fish-helix/functions;
          installPhase = ''
            mkdir -p $out/functions
            cp $src/*.fish $out/functions/
          '';
        };
      }
    ];
  };
  home.packages = [
    pkgs.gawk
    pkgs.gnused
    pkgs.ps
  ];
}
