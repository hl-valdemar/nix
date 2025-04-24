{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
    mkalias
    devenv
    libqalculate
    jre
    dotnet-runtime
    texliveFull
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];
}
