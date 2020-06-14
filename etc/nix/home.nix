{ config, pkgs, lib, ... }:

let
  LS_COLORS = pkgs.fetchgit {
    url = "https://github.com/trapd00r/LS_COLORS";
    rev = "034aee597117492778c9223b7e2188ed6a5bef54";
    sha256 = "0wwmyfknni847rz6b4brgv3fivyqxl6a2qlb3mizrkyjc466gbvy";
  };

  ls-colors = pkgs.runCommand "ls-colors" { } ''
    mkdir -p $out/bin $out/share
    ln -s ${pkgs.coreutils}/bin/ls $out/bin/ls
    ln -s ${pkgs.coreutils}/bin/dircolors $out/bin/dircolors
    cp ${LS_COLORS}/LS_COLORS $out/share/LS_COLORS
  '';
in {
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    ls-colors
    pinentry_mac
    ripgrep
  ];

  home.file.".gnupg/gpg-agent.conf".text = ''
    use-standard-socket
    default-cache-ttl 600
    max-cache-ttl 7200
    pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/MacOS/pinentry-mac
  '';

  xdg.enable = true;

  programs.kitty = {
    enable = true;
    font = {
      package = pkgs.hack-font;
      name = "Hack";
    };
    settings = {
      window_padding_width = 5;
      active_border_color = "#98c379";
      font_size = 13;
      macos_thicken_font = "0.5";
      macos_titlebar_color = "background";

      # colors
      foreground = "#abb2bf";
      background = "#1e2127";

      # black
      color0 = "#1e2127";
      color8 = "#767676";

      # red
      color1 = "#e06c75";
      color9 = "#e06c75";

      # green
      color2 = "#98c379";
      color10 = "#98c379";

      # yellow
      color3 = "#d19a66";
      color11 = "#d19a66";

      # blue
      color4 = "#61afef";
      color12 = "#61afef";

      # magenta
      color5 = "#c678dd";
      color13 = "#c678dd";

      # cyan
      color6 = "#56b6c2";
      color14 = "#56b6c2";

      # white
      color7 = "#abb2bf";
      color15 = "#abb2bf";
    };
  };

  programs.bat.enable = true;
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.gpg.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    defaultKeymap = "emacs";
    shellAliases = import ./home/shellAliases.nix;
    initExtraBeforeCompInit = ''
      eval $(${pkgs.coreutils}/bin/dircolors -b ${ls-colors}/share/LS_COLORS)
    '';

    plugins = [
      {
        name = "titles";
        src = pkgs.fetchFromGitHub {
          owner = "jreese";
          repo = "zsh-titles";
          rev = "2353ff59d304aeff328c6dfa9ba033f8672c030f";
          sha256 = "014pc85qw5isxwaawzas8yhqmkhvpvwnx9jlipldbhvkpw45milx";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.7.1";
          sha256 = "03r6hpb5fy4yaakqm3lbf4xcvd408r44jgpv4lnzl9asp4sb9qc0";
        };
      }
    ];

    sessionVariables = rec {
      RPROMPT = "";
      PATH = "$HOME/bin:$PATH";
      EDITOR = "vim";
      VISUAL = EDITOR;
      GIT_EDITOR = EDITOR;
      HOME_MANAGER_CONFIG = /usr/local/aether/etc/nix/home.nix;
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "Chris Fung";
    userEmail = "aergonaut@gmail.com";

    signing = {
      signByDefault = true;
      key = "E89B5EC467AC51D8";
    };

    extraConfig = {
      core = {
        autocrlf = "input";
      };
      color.ui = true;
      pull.rebase = true;
      push.default = "upstream";
      fetch.prune = true;
      merge.conflictstyle = "diff3";
      diff.algorithm = "patience";
      credential.helper = "osxkeychain";
    };

    aliases = {
      pf = "push --force-with-lease";
      cp = "cherry-pick";
      unc = "reset --soft HEAD^";
      uns = "reset";
    };
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      vim-nix
      vim-ruby
      rust-vim

      vim-surround
      vim-easymotion
    ];
  };
}
