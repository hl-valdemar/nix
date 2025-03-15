{pkgs, ...}: {
  home.packages = with pkgs; [
    nixd

    typst

    zig
    zls

    cmake

    cargo
    rust-analyzer

    go
    gofumpt

    jdk

    raylib
    raygui

    # docker
    # docker-compose
  ];
}
