{
  # Configure SSH to automatically add keys
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";

    # Optional: Add common SSH configurations here
    extraConfig = ''
      AddKeysToAgent yes
      IdentityFile ~/.ssh/id_ed25519
    '';
  };

  # Add session variable for SSH agent
  home.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
}
