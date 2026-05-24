{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.programs.my_pi = {
    ai_providers = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      description = "List of AI provider configurations for Pi";
    };
  };
  config = {
    home.packages = [
      (pkgs.symlinkJoin {
        name = "pi-coding-agent-wrapped";
        paths = [ pkgs.pi-coding-agent ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/pi \
            --set PI_SKIP_VERSION_CHECK 1
        '';
      })
      pkgs.rustPlatform.buildRustPackage
      {
        pname = "webclaw-cli";
        version = "0.1.0";
        src = pkgs.fetchFromGitHub {
          owner = "0xMassi";
          repo = "webclaw";
          rev = "main";
          sha256 = "1jaxa4is3pf9k7wbwi2hx5blv2xql1jz5akvysd4vay0r1gbgbha";
        };
        cargoHash = "sha256-wJPdTd6vrvwALr2gHI6vy4Z6g+enVlarILzvPEzdrWQ=";
        buildAndTestSubdir = "crates/webclaw-cli";
        nativeBuildInputs = with pkgs; [
          pkg-config
          cmake
          perl
          go
          clang
          git
          rustPlatform.bindgenHook
        ];
      }
    ];

    home.file.".pi/agent/AGENTS.md".source = ./AGENTS.md;
    home.file.".pi/agent/extensions".source = ./extensions;

    home.file.".pi/agent/keybindings.json".text = builtins.toJSON {
      "app.editor.external" = [
        "ctrl+g"
        "alt+e"
      ];
    };

    home.file.".pi/agent/models.json".text = builtins.toJSON {
      providers = builtins.listToAttrs (
        map (p: {
          name = p.name;
          value = {
            baseUrl = p.api_base;
            api = "openai-completions";
            # if p.type == "openai-compatible" then "openai-completions"
            # else if p.type == "anthropic" then "anthropic-messages"
            # else p.type;
            apiKey = p.api_key;
            models = map (m: {
              id = m.name;
              contextWindow = m.limit.context or 128000;
              maxTokens = m.limit.output or 32768;
              input = m.modalities.input or [ "text" ];
            }) p.models;
          };
        }) config.programs.my_pi.ai_providers
      );
    };
  };
}
