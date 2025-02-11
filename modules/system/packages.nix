{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
    mkalias
    devenv
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];
}
