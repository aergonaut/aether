{ config, pkgs, ... }:

{
  environment.darwinConfig = "/usr/local/aether/etc/nix/darwin.nix";

  environment.shells = [ pkgs.zsh ];

  programs.zsh.enable = true;

  system.defaults.dock.autohide = true;
  system.defaults.dock.orientation = "bottom";
  system.defaults.dock.showhidden = true;
  system.defaults.dock.mru-spaces = false;

  system.defaults.finder.QuitMenuItem = true;
  system.defaults.finder.CreateDesktop = false;
  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.FXEnableExtensionChangeWarning = false;

  # Nix settings
  programs.nix-index.enable = true;
  services.nix-daemon.enable = false;
  nix.useDaemon = false;
  nix.maxJobs = 4;
  nix.buildCores = 4;

  # For backwards compatibility
  system.stateVersion = 4;
}
