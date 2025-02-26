{pkgs, ...}: {
  home.packages = with pkgs; [
    nixd

    typst

    zig
    zls

    cargo
    rust-analyzer

    go
    gofumpt

    jdk
  ];
}
