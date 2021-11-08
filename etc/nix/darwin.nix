{ config, pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ];

  environment.darwinConfig = "/usr/local/aether/etc/nix/darwin.nix";

  environment.variables = {
    TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
    FREEDESKTOP_MIME_TYPES_PATH = "${pkgs.shared-mime-info}/share/mime/packages/freedesktop.org.xml";
  };

  users.nix.configureBuildUsers = true;
  users.knownGroups = [ "nixbld" ];

  users.users.chris = {
    description = "Chris Fung";
    home = "/Users/chris";
    shell = pkgs.zsh;
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;

    users.chris = import ./home.nix;
  };

  environment.shells = [ pkgs.zsh ];

  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };

  environment.systemPackages = with pkgs; [
    cachix
    coreutils
    home-manager
    shared-mime-info
  ];

  system.defaults.dock.autohide = true;
  system.defaults.dock.orientation = "bottom";
  system.defaults.dock.showhidden = true;
  system.defaults.dock.mru-spaces = false;

  system.defaults.finder.QuitMenuItem = true;
  system.defaults.finder.CreateDesktop = false;
  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.FXEnableExtensionChangeWarning = false;

  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

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

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    # nvim 0.5+
    (
      import (
        builtins.fetchTarball {
          url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
        }
      )
    )

    # yabai 3.3.6
    (
      self: super: {
        yabai = super.yabai.overrideAttrs (
          o: rec {
            version = "3.3.8";
            src = builtins.fetchTarball {
              url = "https://github.com/koekeishiya/yabai/releases/download/v${version}/yabai-v${version}.tar.gz";
              sha256 = "1qh1vf52j0b3lyrm005c8c98s39rk1lq61rrq0ml2yr4h77rq3xv";
            };

            installPhase = ''
              mkdir -p $out/bin
              mkdir -p $out/share/man/man1/
              cp ./bin/yabai $out/bin/yabai
              cp ./doc/yabai.1 $out/share/man/man1/yabai.1
            '';
          }
        );
      }
    )
  ];

  # For backwards compatibility
  system.stateVersion = 4;
}
