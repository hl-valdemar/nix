{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
    mkalias
    devenv
    jre
    dotnet-runtime
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];
}
