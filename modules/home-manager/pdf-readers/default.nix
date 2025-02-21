{pkgs, ...}: {
  imports = [];

  home.packages = with pkgs; [
    zathura
  ];
}
