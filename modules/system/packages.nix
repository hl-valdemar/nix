{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
    mkalias
    devenv
    libqalculate
    jre
    dotnet-runtime
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];
}
