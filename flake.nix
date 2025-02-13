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
    systemConfig = {
      nixpkgs = {
        hostPlatform = "aarch64-darwin";

        config.allowUnfree = true;
        config.permittedInsecurePackages = [
          "dotnet-runtime-7.0.20"
        ];
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
    packagesConfig = import ./modules/system/packages.nix;

    # macOS system defaults configuration
    macosConfig = import ./modules/macos/config.nix;

    # Homebrew configuration
    homebrewConfig = import ./modules/homebrew;
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
