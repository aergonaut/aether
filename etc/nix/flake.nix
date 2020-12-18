{
  description = "macOS system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { nixpkgs, darwin, home-manager, ... }: {
    darwingConfigurations.aether = {
      modules = [
        ./darwin.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPackages = true;
          home-manager.useUserPackages = true;
          home-manager.users.chris = import ./home.nix;
        }
      ];
    };
  };
}
