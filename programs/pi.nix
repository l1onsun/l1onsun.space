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
    home.packages = [ pkgs.pi-coding-agent ];
    
    xdg.configFile."pi/agent/models.json".text = builtins.toJSON {
      providers = builtins.listToAttrs (map (p: {
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
      }) config.programs.my_pi.ai_providers);
    };
  };
}
