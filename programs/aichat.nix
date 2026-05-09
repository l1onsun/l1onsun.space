{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.programs.my_aichat = {
    ai_providers = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      description = "List of AI provider configurations";
    };
  };
  config = {
    home.packages = [ pkgs.aichat ];

    # programs.aichat.enable = true;  # TODO: it IS in home manager

    xdg.configFile."aichat/config.yaml".text = lib.generators.toYAML {} {
      clients = map (p: {
        type = p.type;
        name = p.name;
        api_base = p.api_base;
        api_key = p.api_key;
        models = map (m: { name = m.name; }) p.models;
      }) config.programs.my_aichat.ai_providers;
      model = "polza-ai:deepseek/deepseek-v3.2";
    };
  };
}
