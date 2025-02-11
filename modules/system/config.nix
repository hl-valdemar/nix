{self, ...}: {
  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "aarch64-darwin";
  };

  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.trusted-users = ["root" "valdemar"];

  system = {
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 6;

    activationScripts.preActivation.text = ''
      echo "Installing Rosetta..." >&2
      softwareupdate --install-rosetta --agree-to-license
    '';
  };

  users.users.valdemar = {
    name = "valdemar";
    home = "/Users/valdemar";
  };
}
