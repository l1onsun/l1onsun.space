{
  config,
  lpkgs,
  lib,
  ...
}:
{
  options.programs.mimo_opencode = {
    baseURL = lib.mkOption {
      type = lib.types.str;
      description = "Base URL for the MiMo OpenAI-compatible provider";
    };
    apiKey = lib.mkOption {
      type = lib.types.str;
      description = "API token for MiMo";
    };
  };
  config = {
    home.packages = [ lpkgs.opencode ];

    xdg.configFile."opencode/opencode.json".text = builtins.toJSON {
      "$schema" = "https://opencode.ai/config.json";
      provider = {
        mimo = {
          npm = "@ai-sdk/openai-compatible";
          name = "MiMo";
          options = {
            baseURL = config.programs.mimo_opencode.baseURL;
            apiKey = config.programs.mimo_opencode.apiKey;
          };
          models = {
            "mimo-v2.5-pro" = {
              name = "mimo-v2.5-pro";
              limit = {
                context = 1048576;
                output = 131072;
              };
              modalities = {
                input = [ "text" ];
                output = [ "text" ];
              };
            };
            "mimo-v2.5" = {
              name = "mimo-v2.5";
              limit = {
                context = 262144;
                output = 32768;
              };
              modalities = {
                input = [ "text" ];
                output = [ "text" ];
              };
            };
          };
        };
      };
    };
  };
}
