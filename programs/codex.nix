{
  programs.codex.enable = true;
  programs.codex.settings = {
    model = "openai/gpt-5.1-codex";
    model_provider = "polza-ai";
    model_providers = {
      polza-ai = {
        name = "Polza.ai";
        base_url = "https://api.polza.ai/v1";
        env_key = "POLZA_API_KEY";
      };
    };
  };
}
