{ lib, ... }:

{
  # ... существующий конфиг ...

  services.llama-cpp = {
    enable = true;
    host = "127.0.0.1";
    port = 8080;
    wantedBy = lib.mkForce [ ];

    # ─── Вариант A: локальный файл ───
    model = "/var/lib/llama-cpp/models/Qwen3-14B-Q4_K_M.gguf";

    # ─── Вариант B: автоскачивание с HuggingFace (раскомментировать) ───
    # modelsPreset = {
    #   "qwen3-14b" = {
    #     hf-repo = "unsloth/Qwen3-14B-GGUF";
    #     hf-file = "Qwen3-14B-Q4_K_M.gguf";
    #     alias = "qwen3-14b";
    #     temp = "0.7";
    #     top-p = "0.9";
    #     min-p = "0.01";
    #     jinja = "on";
    #   };
    # };

    extraFlags = [
      "-c"
      "4096" # контекст (уменьшить если не хватает RAM)
      "-ngl"
      "0" # слои на GPU (0 = всё на CPU, Iris Xe не поддерживается llama.cpp)
      "-t"
      "6" # потоков (оставить 2 свободных для системы)
      "--numa"
      "numa" # NUMA-aware allocation
    ];
  };

  # Открыть порт если нужен доступ из сети (по умолчанию только localhost)
  # services.llama-cpp.openFirewall = true;
}
