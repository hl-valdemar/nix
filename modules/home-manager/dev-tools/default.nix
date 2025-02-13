{pkgs, ...}: {
  home.packages = with pkgs; [
    nixd

    typst

    zig
    zls

    go
    gofumpt

    jdk
  ];
}
