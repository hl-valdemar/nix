{pkgs, ...}: {
  imports = [
    ./atuin.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./ssh.nix
    ./zellij.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
    bat
    lazygit
    ripgrep
    fd
  ];
}
