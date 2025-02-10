{pkgs, ...}: {
  imports = [
    ./atuin.nix
    #./devenv.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./lazygit.nix
    ./ssh.nix
    ./zellij.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
    bat
    lazygit
  ];
}
