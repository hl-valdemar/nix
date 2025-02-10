{pkgs, ...}: {
  home = {
    stateVersion = "24.11";
  };

  # Your home-manager package configurations would go here
  home.packages = with pkgs; [
    ripgrep
    fd
  ];

  imports = [
    ./terminal-apps
    ./shells
    ./cli-utilities
    ./text-editors
    ./messaging-apps
  ];
}
