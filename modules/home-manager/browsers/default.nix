{pkgs, ...}: {
  imports = [];

  home.packages = with pkgs; [
    firefox
  ];
}
