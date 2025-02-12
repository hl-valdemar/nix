{pkgs, ...}: {
  home.packages = with pkgs; [
    nixd

    typst

    zig
    zls

    go
    gofumpt

    # rust
    # rust-analyzer
  ];
}
