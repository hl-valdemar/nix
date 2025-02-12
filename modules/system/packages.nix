{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
    mkalias
    devenv
    jre
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];
}
