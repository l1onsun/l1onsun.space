{ pkgs, ... }:
{
  programs.helix = {
    enable = true;

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
          language-servers = [ "superhtml-lsp" ];
        }
        {
          name = "markdown";
          language-servers = [ "lsp-ai" ];
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
        lsp-ai = {
          command = "lsp-ai";
          config.memory.file_store = { };
          config.models =
            builtins.mapAttrs
              (name: model: {
                type = "open_ai";
                chat_endpoint = "https://api.vsegpt.ru/v1/chat/completions";
                auth_token_env_var_name = "VSEGPT_API_KEY";
                inherit model;
              })
              {
                haiku = "anthropic/claude-haiku-4.5";
                deepseek-faster = "deepseek/deepseek-v3.2-alt-faster";
              };
          config.chat = [
            {
              trigger = "!h";
              action_display_name = "chat haiku";
              model = "haiku";
              parameters = {
                max_context = 200000;
                max_tokens = 4096;
                system = "You are a code assistant chatbot";
              };
            }
            {
              trigger = "!ds";
              action_display_name = "chat deepseek-faster";
              model = "deepseek-faster";
              parameters = {
                max_context = 162000;
                max_tokens = 2048;
                system = "";
              };
            }
          ];
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
    pkgs.vscode-langservers-extracted
    pkgs.nodePackages.prettier
    pkgs.lsp-ai
  ];
}
