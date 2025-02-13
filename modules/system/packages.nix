{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
    mkalias
    devenv
    jre
    dotnet-runtime
    dotnet-runtime_7
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];
}
