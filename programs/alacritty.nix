{ font_size }:
# let
#   sc = import ./scan_codes.nix;
# in
{
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      # env.TERM = "xterm-256color";
      font = {
        size = font_size;
        # normal.family = "Iosevka Term";
        normal.family = "Iosevka";
        # normal.family = "Aporetic Sans Mono";
        # draw_bold_text_with_bright_colors = true;
      };
      # scrolling.multiplier = 5;
      # selection.save_to_clipboard = true;
      # keyboard.bindings = [
      #   # Scancodes for non-latin layout support (physical keys)
      #   { key = sc.V; mods = "Control|Shift"; action = "Paste"; }
      #   { key = sc.C; mods = "Control|Shift"; action = "Copy"; }
      #   { key = sc.F; mods = "Control|Shift"; action = "SearchForward"; }
      #   { key = sc.B; mods = "Control|Shift"; action = "SearchBackward"; }

      #   # Russian layout: Ctrl+Русская → control char for对应的 Latin
      #   # Row 1 (QWERTY)
      #   { key = "Й"; mods = "Control"; chars = "\x11"; } # Ctrl+Q
      #   { key = "Ц"; mods = "Control"; chars = "\x17"; } # Ctrl+W
      #   { key = "У"; mods = "Control"; chars = "\x05"; } # Ctrl+E
      #   { key = "К"; mods = "Control"; chars = "\x12"; } # Ctrl+R
      #   { key = "Е"; mods = "Control"; chars = "\x14"; } # Ctrl+T
      #   { key = "Н"; mods = "Control"; chars = "\x19"; } # Ctrl+Y
      #   { key = "Г"; mods = "Control"; chars = "\x15"; } # Ctrl+U
      #   { key = "Ш"; mods = "Control"; chars = "\x09"; } # Ctrl+I (Tab)
      #   { key = "Щ"; mods = "Control"; chars = "\x0F"; } # Ctrl+O
      #   { key = "З"; mods = "Control"; chars = "\x10"; } # Ctrl+P
      #   # Row 2 (ASDF)
      #   { key = "Ф"; mods = "Control"; chars = "\x01"; } # Ctrl+A
      #   { key = "Ы"; mods = "Control"; chars = "\x13"; } # Ctrl+S
      #   { key = "В"; mods = "Control"; chars = "\x04"; } # Ctrl+D
      #   { key = "А"; mods = "Control"; chars = "\x06"; } # Ctrl+F
      #   { key = "П"; mods = "Control"; chars = "\x07"; } # Ctrl+G
      #   { key = "Р"; mods = "Control"; chars = "\x08"; } # Ctrl+H (Backspace)
      #   { key = "О"; mods = "Control"; chars = "\x0A"; } # Ctrl+J (LF)
      #   { key = "Л"; mods = "Control"; chars = "\x0B"; } # Ctrl+K
      #   { key = "Д"; mods = "Control"; chars = "\x0C"; } # Ctrl+L (Clear)
      #   # Row 3 (ZXCV)
      #   { key = "Я"; mods = "Control"; chars = "\x1A"; } # Ctrl+Z
      #   { key = "Ч"; mods = "Control"; chars = "\x18"; } # Ctrl+X
      #   { key = "С"; mods = "Control"; chars = "\x03"; } # Ctrl+C (SIGINT)
      #   { key = "М"; mods = "Control"; chars = "\x16"; } # Ctrl+V
      #   { key = "И"; mods = "Control"; chars = "\x02"; } # Ctrl+B
      #   { key = "Т"; mods = "Control"; chars = "\x0E"; } # Ctrl+N
      #   { key = "Ь"; mods = "Control"; chars = "\x0D"; } # Ctrl+M (CR)
      # ];
      hints.enabled = [
        {
          regex = "(?P<hint>[^\s:]+:\d+:\d+)";
          mouse.enabled = true;
          action = "Paste";
          binding = {
            key = "Y";
            mods = "Control|Shift";
          };
        }
        {
          # default
          command = "xdg-open";
          hyperlinks = true;
          post_processing = true;
          persist = false;
          mouse.enabled = true;
          action = "Copy";
          binding = {
            key = "O";
            mods = "Control|Shift";
          };
          regex = ''(ipfs:|ipns:|magnet:|mailto:|gemini://|gopher://|https://|http://|news:|file:|git://|ssh:|ftp://)[^\u0000-\u001F\u007F-\u009F<>"\\s{-}\\^⟨⟩`\\\\]+'';
        }
      ];
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
}
