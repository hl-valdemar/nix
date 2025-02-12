{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
    mkalias
    devenv
    jdk
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];
}
