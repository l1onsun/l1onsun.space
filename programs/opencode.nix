{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.programs.my_opencode = {
    ai_providers = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      description = "List of AI provider configurations";
    };
  };
  config = {
    home.packages = [ pkgs.opencode ];

    xdg.configFile."opencode/opencode.json".text = builtins.toJSON {
      "$schema" = "https://opencode.ai/config.json";
      provider = builtins.listToAttrs (map (p: {
        name = p.name;
        value = {
          npm = p.npm;
          name = p.name;
          options = {
            baseURL = p.api_base;
            apiKey = p.api_key;
          };
          models = builtins.listToAttrs (map (m: {
            name = m.name;
            value = {
              name = m.name;
              limit = m.limit or { context = 128000; output = 32768; };
              modalities = m.modalities or { input = [ "text" ]; output = [ "text" ]; };
            };
          }) p.models);
        };
      }) (builtins.filter (p: p ? npm) config.programs.my_opencode.ai_providers));
    };
  };
}
