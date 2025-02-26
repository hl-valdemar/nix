{pkgs, ...}: {
  home.packages = with pkgs; [
    nixd

    typst

    zig
    zls

    rust
    rust-analyzer

    go
    gofumpt

    jdk
  ];
}
