{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.programs.polza_aichat = {
    apiKey = lib.mkOption {
      type = lib.types.str;
      description = "API token for polza-ai";
    };
  };
  config = {
    home.packages = [ pkgs.aichat ];

    # programs.aichat.enable = true;  # TODO: it IS in home manager

    xdg.configFile."aichat/config.yaml".text = ''
      clients:
        - type: openai-compatible
          name: polza-ai
          api_base: https://api.polza.ai/v1
          api_key: ${config.programs.polza_aichat.apiKey}
          models:
            - name: openai/gpt-5.2
              max_tokens: 8192

            - name: deepseek/deepseek-v3.2
              max_tokens: 8192

            - name: z-ai/glm-5
              max_tokens: 8192

      model: polza-ai:deepseek/deepseek-v3.2
    '';
  };
}
