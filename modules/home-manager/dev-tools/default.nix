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

    deno

    raylib
    raygui

    cloc
  ];
}
