{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    package = pkgs.helix;

    settings = {
      theme = "rose_pine";
      editor = {
        scrolloff = 10;
        auto-save = true;
        auto-pairs = false;
        idle-timeout = 20;
        completion-timeout = 20;
        color-modes = true;
        cursorline = true;
        bufferline = "multiple";
        completion-trigger-len = 1;
      };
      editor.whitespace = {
        render = "all";
        characters.newline = "▸";
        characters.space = " ";
      };
      editor.cursor-shape.insert = "bar";
      keys.normal.space.i = ":toggle lsp.display-inlay-hints";
    };

    languages = {
      language = [
        {
          name = "python";
          language-servers = [
            "pyright"
            "typos"
          ];
          formatter = {
            command = "sh";
            args = [
              "-c"
              "black --quiet - | isort --profile black -"
            ];
          };
        }
        {
          name = "nix";
          formatter = {
            command = "nixfmt";
          };
        }
      ];
      language-server = {
        pyright = {
          command = "pyright-langserver";
          args = [ "--stdio" ];
          config.reportMissingTypeStubs = false;
          config.python.analysis.typeCheckingMode = "basic";
          config.python.analysis.autoImportCompletions = true;
        };
        typos.command = "typos-lsp";
      };
    };
  };
  home.packages = [
    pkgs.isort
    pkgs.pyright
    pkgs.black
    pkgs.typos-lsp
  ];
}
