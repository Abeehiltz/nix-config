{ pkgs, ... }: {
  services.llama-cpp = {

    enable = true;
    package = pkgs.llama-cpp-vulkan;
    settings = {
      models-preset = (pkgs.formats.ini { }).generate "models-preset.ini" {
        "Qwen3-Coder-30B" = {
          hf-repo = "unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:Q4_K_M";
          alias = "qwen3-coder";
          ctx-size = 32768;
          n-gpu-layers = 99;
          n-cpu-moe = 12; # tune this, see below
          jinja = true; # needed for native tool calling
          temp = 0.7; # Qwen's suggested sampling
          top-p = 0.8;
          top-k = 20;
          repeat-penalty = 1.05;
        };
      };
    };
  };
}
