{pkgs, ...}: {
  imports = [];

  home.packages = with pkgs; [
    signal-desktop
  ];
}
