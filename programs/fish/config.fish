starship init fish | source
direnv hook fish | source
zoxide init fish | source

fish_add_path /home/l1onsun/my/bin/zig-linux-x86_64-0.14.0-dev.2178+bd7dda0c5

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# if [$term = "linux"]
#     echo -e "abra\tcadabra"
# end

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

abbr -a -- gp 'git push' # imported from a universal variable, see `help abbr`
abbr -a -- g git # imported from a universal variable, see `help abbr`
abbr -a -- sw sway # imported from a universal variable, see `help abbr`
abbr -a -- j just # imported from a universal variable, see `help abbr`
abbr -a -- s systemctl # imported from a universal variable, see `help abbr`
abbr -a -- gr 'git rebase' # imported from a universal variable, see `help abbr`
abbr -a -- ga 'git add' # imported from a universal variable, see `help abbr`
abbr -a -- p 'sudo pacman' # imported from a universal variable, see `help abbr`
abbr -a -- gs 'git status' # imported from a universal variable, see `help abbr`
abbr -a -- pm 'python -m manage' # imported from a universal variable, see `help abbr`
abbr -a -- pss 'sudo pacman -Syu' # imported from a universal variable, see `help abbr`
abbr -a -- py python # imported from a universal variable, see `help abbr`
