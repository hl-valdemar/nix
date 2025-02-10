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
    ./text-editors
    ./cli-utilities
  ];
}
