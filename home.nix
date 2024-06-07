{ config, pkgs,... }:

{
  # imports = [ inputs.niri.homeModules.config ];
  home.username = "l1onsun";
  home.homeDirectory = "/home/l1onsun";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  # xresources.properties = {
  #   "Xcursor.size" = 16;
  #   "Xft.dpi" = 172;
  # };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    neofetch

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    # eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # # networking tools
    # mtr # A network diagnostic tool
    # iperf3
    # dnsutils  # `dig` + `nslookup`
    # ldns # replacement of `dig`, it provide the command `drill`
    # aria2 # A lightweight multi-protocol & multi-source command-line download utility
    # socat # replacement of openbsd-netcat
    # nmap # A utility for network discovery and security auditing
    # ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    # cowsay
    # file
    # which
    # tree
    # gnused
    # gnutar
    # gawk
    # zstd
    # gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    # nix-output-monitor

    # productivity
    # hugo # static site generator
    # glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    # iotop # io monitoring
    # iftop # network monitoring

    # system call monitoring
    # strace # system call monitoring
    # ltrace # library call monitoring
    # lsof # list open files

    # system tools
    # sysstat
    # lm_sensors # for `sensors` command
    # ethtool
    # pciutils # lspci
    # usbutils # lsusb
    niri

    alacritty
    firefox
    librewolf
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system deveoped by swaywm maintainer
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Ilya";
    userEmail = "ilya@cherezov.space";
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    # settings = {
    #   add_newline = false;
    #   aws.disabled = true;
    #   gcloud.disabled = true;
    #   line_break.disabled = true;
    # };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 14;
        normal.family = "Iosevka Term";
        # draw_bold_text_with_bright_colors = true;
      };
      # scrolling.multiplier = 5;
      # selection.save_to_clipboard = true;
      colors = {      
        primary = {
          foreground = "#e0def4";
          background = "#191724";
          dim_foreground = "#908caa";
          bright_foreground = "#e0def4";
        };
        cursor = {
          text = "#e0def4";
          cursor = "#524f67";
        };
        vi_mode_cursor = {
          text = "#e0def4";
          cursor = "#524f67";
        };
        search.matches = {
          foreground = "#908caa";
          background = "#26233a";
        };
        search.focused_match = {
          foreground = "#191724";
          background = "#ebbcba";
        };
        hints.start = {
          foreground = "#908caa";
          background = "#1f1d2e";
        };
        hints.end = {
          foreground = "#6e6a86";
          background = "#1f1d2e";
        };
        line_indicator = {
          foreground = "None";
          background = "None";
        };
        footer_bar = {
          foreground = "#e0def4";
          background = "#1f1d2e";
        };
        selection = {
          text = "#e0def4";
          background = "#403d52";
        };
        normal = {
          black = "#26233a";
          red = "#eb6f92";
          green = "#31748f";
          yellow = "#f6c177";
          blue = "#9ccfd8";
          magenta = "#c4a7e7";
          cyan = "#ebbcba";
          white = "#e0def4";
        };
        bright = {
          black = "#6e6a86";
          red = "#eb6f92";
          green = "#31748f";
          yellow = "#f6c177";
          blue = "#9ccfd8";
          magenta = "#c4a7e7";
          cyan = "#ebbcba";
          white = "#e0def4";
        };
        dim = {
          black = "#6e6a86";
          red = "#eb6f92";
          green = "#31748f";
          yellow = "#f6c177";
          blue = "#9ccfd8";
          magenta = "#c4a7e7";
          cyan = "#ebbcba";
          white = "#e0def4";
        };
      };
    };
  };

  # programs.bash = {
  #   enable = true;
  #   enableCompletion = true;
  #   # TODO add your custom bashrc here
  #   bashrcExtra = ''
  #     export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
  #   '';

  #   # set some aliases, feel free to add more or remove some
  #   shellAliases = {
  #     k = "kubectl";
  #     urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
  #     urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
  #   };
  # };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
