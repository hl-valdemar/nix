{
  description = "Valdemar's Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, mac-app-util }:
    let
      # System configuration modules
      systemConfig = { pkgs, ... }: {
        nixpkgs = {
          config.allowUnfree = true;
          hostPlatform = "aarch64-darwin";
        };

        nix.settings.experimental-features = "nix-command flakes";
        
        system = {
          configurationRevision = self.rev or self.dirtyRev or null;
          stateVersion = 6;
          
          activationScripts.preActivation.text = ''
            echo "Installing Rosetta..." >&2
            softwareupdate --install-rosetta --agree-to-license
          '';
        };
      };

      # Package management configuration
      packagesConfig = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
          neovim
          mkalias
          kitty
          wezterm
          zellij
        ];

        fonts.packages = with pkgs; [
          nerd-fonts.hack
        ];
      };

      # macOS system defaults configuration
      macosConfig = { pkgs, ... }: {
        system.defaults = {
          dock = {
            autohide = true;
            persistent-apps = [
              "/System/Applications/Mail.app"
              "/System/Applications/Calendar.app"
            ];
          };
          loginwindow.GuestEnabled = false;
          NSGlobalDomain.KeyRepeat = 2;
        };
      };

      # Homebrew configuration
      homebrewConfig = { pkgs, ... }: {
        homebrew = {
          enable = true;
          brews = [ "mas" ];
          casks = [ ];
          masApps = {
            "Craft" = 1487937127;
          };
          onActivation = {
            cleanup = "zap";
            autoUpdate = true;
            upgrade = true;
          };
        };

        nix-homebrew = {
          enable = true;
          enableRosetta = true;
          user = "valdemar";
        };
      };

    in {
      darwinConfigurations."macOS" = nix-darwin.lib.darwinSystem {
        modules = [
          systemConfig
          packagesConfig
          macosConfig
          homebrewConfig
          mac-app-util.darwinModules.default
          nix-homebrew.darwinModules.nix-homebrew
        ];
      };
    };
}
