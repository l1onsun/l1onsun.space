{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    # package = pkgs.helix;

    settings = {
      theme = "rose_pine";
      editor = {
        true-color = true;
        scrolloff = 10;
        auto-save = true;
        auto-pairs = false;
        idle-timeout = 20;
        completion-timeout = 20;
        color-modes = true;
        cursorline = true;
        bufferline = "multiple";
        completion-trigger-len = 1;
        continue-comments = false;
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
        {
          name = "jinja";
          block-comment-tokens = {
            start = "<!--";
            end = "-->";
          };
          formatter = {
            command = "prettier";
            args = [
              "--plugin=prettier-plugin-jinja-template"
              "--parser=jinja-template"
            ];
          };
          # formatter = {
          #   command = "superhtml";
          #   args = [ "fmt" ];
          # };
          language-servers = [ "superhtml-lsp" ];
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
        superhtml-lsp = {
          command = "superhtml";
          args = [ "lsp" ];
        };
      };
    };
  };
  home.packages = [
    pkgs.isort
    pkgs.pyright
    pkgs.black
    pkgs.typos-lsp
    pkgs.nil
    pkgs.nixfmt-rfc-style
    pkgs.superhtml
    pkgs.nodePackages.prettier
  ];
}
