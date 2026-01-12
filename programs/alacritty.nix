{ font_size }:
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
