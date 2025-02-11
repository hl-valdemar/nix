{
  description = "Valdemar's Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    nix-homebrew,
    mac-app-util,
  }: let
    # System configuration modules
    systemConfig = {pkgs, ...}: {
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
    };

    # Package management configuration
    packagesConfig = import ./modules/system;

    # macOS system defaults configuration
    macosConfig = {
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
    homebrewConfig = {pkgs, ...}: {
      homebrew = {
        enable = true;
        brews = ["mas"];
        casks = [];
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
        home-manager.darwinModules.default
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            extraSpecialArgs = {inherit inputs;};

            # To enable it for all users:
            sharedModules = [
              mac-app-util.homeManagerModules.default
            ];

            useGlobalPkgs = true;
            useUserPackages = true;

            backupFileExtension = "backup";

            users.valdemar = import ./home.nix;
          };
        }
      ];
    };
  };
}
