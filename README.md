# flake for Build Krita with krita-ai-tools

```nix
{
  inputs = {
    krita-ai.url = "github:name/repo";
  };

  outputs = inputs@{ , ...}: {
    packages = {
      krita = inputs.krita-ai.packages."${system}".krita;
    };
  };
}

```
