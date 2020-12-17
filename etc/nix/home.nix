{ config, pkgs, lib, ... }:

let
  LS_COLORS = pkgs.fetchgit {
    url = "https://github.com/trapd00r/LS_COLORS";
    rev = "034aee597117492778c9223b7e2188ed6a5bef54";
    sha256 = "0wwmyfknni847rz6b4brgv3fivyqxl6a2qlb3mizrkyjc466gbvy";
  };

  ohmyzsh = pkgs.fetchFromGitHub {
    owner = "ohmyzsh";
    repo = "ohmyzsh";
    rev = "db94f60d342ba2be7dbe3bfd86f4edb335c2a6a7";
    sha256 = "14zvbnrnkcmqnjbw71j4jgfm7gkrgpchkfrpdw006q25gqxj0bgm";
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
    chruby
    fd
    geckodriver
    gitAndTools.gh
    git
    ls-colors
    nodejs
    overmind
    pinentry_mac
    ripgrep
    shadowenv
    tmux
    watchman
    yarn
    youtube-dl
  ];

  home.file.".gnupg/gpg-agent.conf".text = ''
    use-standard-socket
    default-cache-ttl 600
    max-cache-ttl 7200
    pinentry-program ${pkgs.pinentry_mac}/${pkgs.pinentry_mac.binaryPath}
  '';

  xdg.enable = true;
  xdg.configFile."starship.toml".text = builtins.readFile ./home/config/starship.toml;

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

  programs.bat = {
    enable = true;
    config.theme = "TwoDark";
  };

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

      ${builtins.readFile ./home/pre-compinit.zsh}
    '';
    initExtra = ''
      source ${pkgs.chruby}/share/chruby/chruby.sh
      source ${pkgs.chruby}/share/chruby/auto.sh
      ${builtins.readFile ./home/post-compinit.zsh}
    '';

    plugins = [
      {
        name = "libgit";
        src = ohmyzsh;
        file = "lib/git.zsh";
      }
      {
        name = "git";
        src = ohmyzsh;
        file = "plugins/git/git.plugin.zsh";
      }
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
      HOMEBREW_NO_INSTALL_CLEANUP = 1;
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
      init = {
        defaultBranch = "main";
      };
      color.ui = true;
      pull.rebase = true;
      push.default = "upstream";
      fetch.prune = true;
      merge.conflictstyle = "diff3";
      diff.algorithm = "patience";
      credential.helper = "osxkeychain";
      url."https://github.com/coupa/".insteadOf = [
        "git@github.com:coupa/"
        "ssh://git@github.com:coupa/"
      ];
    };

    aliases = {
      pf = "push --force-with-lease";
      cp = "cherry-pick";
      unc = "reset --soft HEAD^";
      uns = "reset";
    };

    ignores = [
      ".DS_Store"
      "*.sw[nop]"
      ".bundle"
      ".byebug_history"
      "db/*.sqlite3"
      "log/*.log"
      "rerun.txt"
      "tags"
      "!tags/"
      "tmp/**/*"
      "!tmp/cache/.keep"
      "*.pyc"
      "vim/view"

      ".project-notes"
      ".vimrc.local"
      "node_modules"

      ".shadowenv.d/"
      ".solargraph.yml"
    ];
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = ''
      set termguicolors
      colorscheme neodark
      let g:neodark#terminal_transparent = 1

      let mapleader="<space>"

      " fzf
      let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore-vcs --hidden'
      nnoremap <C-p> :Files<cr>

      " window commands
      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l

      " easier beginning/end of line
      noremap H ^
      noremap L $

      ${builtins.readFile ./home/coc-keybinds.vim}
    '';

    plugins = with pkgs.vimPlugins; [
      vim-nix
      vim-ruby
      rust-vim

      vim-sensible
      vim-surround
      vim-easymotion
      fzf-vim

      coc-nvim
      neodark-vim
    ];
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    userSettings = import ./home/vscode.nix;
    keybindings = [
      {
        key = "shift+cmd+\\";
        command = "workbench.files.action.showActiveFileInExplorer";
      }
      {
        key = "alt+cmd+\\";
        command = "-workbench.files.action.showActiveFileInExplorer";
      }
    ];

    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "vim";
        publisher = "vscodevim";
        version = "1.18.4";
        sha256 = "1j5wp9mq9n4mykh2a1frx0y4z9mq748mjadrlbyx7w5pgk8ss2cv";
      }
      {
        name = "nix";
        publisher = "bbenoist";
        version = "1.0.1";
        sha256 = "0zd0n9f5z1f0ckzfjr38xw2zzmcxg1gjrava7yahg5cvdcw6l35b";
      }
      {
        name = "vscode-eslint";
        publisher = "dbaeumer";
        version = "2.1.13";
        sha256 = "1adzgisljlq6xmmwrziawkgy941bf8i8nq4c9w3gnsbr20gd9pyi";
      }
      {
        name = "gitlens";
        publisher = "eamodio";
        version = "10.2.1";
        sha256 = "1bh6ws20yi757b4im5aa6zcjmsgdqxvr1rg86kfa638cd5ad1f97";
      }
      {
        name = "file-icons";
        publisher = "file-icons";
        version = "1.0.24";
        sha256 = "0mcaz4lv7zb0gw0i9zbd0cmxc41dnw344ggwj1wy9y40d627wdcx";
      }
      {
        name = "atom-keybindings";
        publisher = "ms-vscode";
        version = "3.0.6";
        sha256 = "0r5brd9iirfs3zaqq1swlx2n3mqxzyggv4rzjdyjh8zsyi1lfjas";
      }
      {
        name = "github-vscode-theme";
        publisher = "github";
        version = "1.1.5";
        sha256 = "1llyrm4iwdp79ylnw4kn5g6qlp8blrpaddszhl61yv82rs60kw0h";
      }
      {
        name = "prettier-vscode";
        publisher = "esbenp";
        version = "5.7.2";
        sha256 = "1wf4dwh11pz2hcy26kvhqnp2bhnk6n0pjh2qs0jsn8sl16656f1f";
      }
      {
        name = "haml";
        publisher = "karunamurti";
        version = "1.3.1";
        sha256 = "1d5143m9ysn0s8q2c06gw7fswk5mah1p3g2gcrg93117y7ky24s3";
      }
      {
        name = "sorbet-lsp";
        publisher = "danhuynhdev";
        version = "0.1.5";
        sha256 = "110q52vgan5alf0gzxwg1a4z8qxwr5ry23gf5ma37j5mxdhvw194";
      }
      {
        name = "vscode-tailwindcss";
        publisher = "bradlc";
        version = "0.5.6";
        sha256 = "0hvga74mddvncq2ngzx9zz1f7al45vjx63968sw655r50za9jaml";
      }
      {
        name = "vscode-open-in-github";
        publisher = "fabiospampinato";
        version = "1.2.3";
        sha256 = "0xij1qgx89namw2w2kqw7c9rvspckiz16fmpdyvcmmx36cxqwkgd";
      }
    ];
  };
}
