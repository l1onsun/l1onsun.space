{
  config,
  lpkgs,
  lib,
  ...
}:
let
  providers = config.programs.my_llm.ai_providers;

  modelEntries = builtins.concatMap (p:
    map (m: {
      model_id = m.name;
      model_name = m.name;
      api_base = p.api_base;
      api_key_name = p.name;
    }) p.models
  ) providers;

  keysJson = {
    "// Note" = "This file stores secret API credentials. Do not share!";
  } // builtins.listToAttrs (map (p: {
    name = p.name;
    value = p.api_key;
  }) providers);
in
{
  options.programs.my_llm = {
    ai_providers = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      description = "List of AI provider configurations";
    };
  };
  config = {
    home.packages = [ lpkgs.llm ];

    xdg.configFile."io.datasette.llm/extra-openai-models.yaml".text = lib.generators.toYAML {} modelEntries;
    xdg.configFile."io.datasette.llm/keys.json".text = builtins.toJSON keysJson;
  };
}
