{ callPackage, krita-ai-tools-src, dlimgedit, ... }:

callPackage ./generic.nix {
  version = "5.2.6";
  kde-channel = "stable";
  hash = "sha256-SNcShVT99LTpLFSuMbUq95IfR6jabOyqBnRKu/yC1fs=";
  inherit krita-ai-tools-src dlimgedit;
}
