{self, ...}: {

  flake.nixosModules.aiTools = { ... }:
  {
    imports = [
      self.nixosModules.ollama
    ];

    home-manager.sharedModules = [
      ({pkgs, ... }:{

        programs = {
          opencode = {
            enable = true;
            package = pkgs.opencode;
          };
        };
        
      })
    ];
    
  };

  flake.nixosModules.ollama = { pkgs, ... }:
  {
    services = {
      ollama = {
        enable = true;
        package = pkgs.ollama; #pkgs.ollama-cuda # Use the CUDA-enabled version of Ollama if you have an NVIDIA GPU and want to leverage GPU acceleration for AI workloads.
        
        host = "127.0.0.1";
        port = 11434;
      
        loadModels = [
          # The following model is a smaller and more efficient version of the Qwen series, 
          # designed for general-purpose use and optimized for performance on a wide range of hardware.
          "qwen3.5:9b"

          "qwen3.5:0.8b" # A very small model made for testing only

          "gemma4:e4b"
          "gemma4:12b"

          # The following models are larger and more powerful, but also require more resources to run. 
          # Make sure your system has enough RAM and CPU/GPU power to handle them before loading.
          # "qwen3.6:27b"
          # "qwen3.6:35b"
        ];

        syncModels = true; 
      };
    };
  };
  
}