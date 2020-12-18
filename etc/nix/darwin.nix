{ config, pkgs, ... }:

{
  environment.darwinConfig = "/usr/local/aether/etc/nix/darwin.nix";

  environment.shells = [ pkgs.zsh ];

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    coreutils
    home-manager
  ];

  system.defaults.dock.autohide = true;
  system.defaults.dock.orientation = "bottom";
  system.defaults.dock.showhidden = true;
  system.defaults.dock.mru-spaces = false;

  system.defaults.finder.QuitMenuItem = true;
  system.defaults.finder.CreateDesktop = false;
  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.FXEnableExtensionChangeWarning = false;

  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    config = {
      layout = "bsp";

      top_padding = 20;
      bottom_padding = 20;
      left_padding = 20;
      right_padding = 20;
      window_gap = 20;

      window_border = "off";
    };
    extraConfig = ''
      yabai -m rule --add app='^Tandem' manage=off
    '';
  };

  services.skhd = {
    enable = true;
    skhdConfig = ''
      # Open kitty
      shift + alt + ctrl - return : ${pkgs.kitty}/Applications/kitty.app/Contents/MacOS/kitty --single-instance -d ~

      ${builtins.readFile ./home/skhdrc}
    '';
  };

  # Nix settings
  programs.nix-index.enable = true;
  services.nix-daemon.enable = false;
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  nix.useDaemon = false;
  nix.maxJobs = 4;
  nix.buildCores = 4;

  # For backwards compatibility
  system.stateVersion = 4;
}
