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

  ls-colors = pkgs.runCommand "ls-colors" {} ''
    mkdir -p $out/bin $out/share
    ln -s ${pkgs.coreutils}/bin/ls $out/bin/ls
    ln -s ${pkgs.coreutils}/bin/dircolors $out/bin/dircolors
    cp ${LS_COLORS}/LS_COLORS $out/share/LS_COLORS
  '';

  vim-conflicted = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "vim-conflicted";
    version = "2021-01-05";
    src = pkgs.fetchFromGitHub {
      owner = "christoomey";
      repo = "vim-conflicted";
      rev = "068c320796f807ac4961618e3e62316773803996";
      sha256 = "c7bb6437bd606e7b751c8e8d410345ddeeed19251b925b4d3789db57a5ee9cd3";
    };
  };

  vim-system-copy = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "vim-system-copy";
    version = "2021-01-15";
    src = pkgs.fetchFromGitHub {
      owner = "christoomey";
      repo = "vim-system-copy";
      rev = "1264373f305b324294d672c3d64bab3e4dec90bc";
      sha256 = "c76f0274a3d98486a45814b5b1642bf782c95c75848a7198555d032eebd4f60a";
    };
  };

  vim-cutlass = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "vim-cutlass";
    version = "2021-02-15";
    src = pkgs.fetchFromGitHub {
      owner = "svermeulen";
      repo = "vim-cutlass";
      rev = "7afd649415541634c8ce317fafbc31cd19d57589";
      sha256 = "8f95bdabdd390290dfddfbc2212e14c321d89c466ee4872d9fee89915ff18e28";
    };
  };

  vim-subversive = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "vim-subversive";
    version = "2021-02-15";
    src = pkgs.fetchFromGitHub {
      owner = "svermeulen";
      repo = "vim-subversive";
      rev = "5695f97fc803767bf657a5e512daec19dd1fd786";
      sha256 = "f8e22428cc19b16ea1e4b0a4235981b29154902b6a217e515dd88b37e6db7a52";
    };
  };

  vim-yoink = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "vim-yoink";
    version = "2021-02-15";
    src = pkgs.fetchFromGitHub {
      owner = "svermeulen";
      repo = "vim-yoink";
      rev = "b973fce71d45fe7c290119448651da7a1b9943a1";
      sha256 = "0d10254774c9211dcfc910880d2e4a540a77041d1fb57b102b1190d14bd959b2";
    };
  };

  nvim-compe = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-compe";
    version = "2021-04-22";
    src = pkgs.fetchFromGitHub {
      owner = "hrsh7th";
      repo = "nvim-compe";
      rev = "99452ae6875889c12653963b68e53c4564848954";
      sha256 = "1d5hpn3mr2h3s5h2svajbxm0n49mmc5w0sip9cpzyfdpbnv1gic3";
    };
  };
in
{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    chruby
    fd
    geckodriver
    git
    ls-colors
    mkcert
    ngrok
    nodejs
    nss
    nss.dev
    nss.tools
    overmind
    pinentry_mac
    ripgrep
    rnix-lsp
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

  programs.kitty = {
    enable = true;

    font = {
      package = pkgs.nerdfonts.override { fonts = ["Hack"]; };
      name = "Hack";
    };

    keybindings = {
      "super+t" = "launch --cwd=current --type=tab";
    };

    settings = {
      window_padding_width = 5;
      active_border_color = "#98c379";
      font_size = 13;
      macos_thicken_font = "0.5";
      macos_titlebar_color = "background";

      cursor_blink_interval = 0;
      mouse_hide_wait = -1;

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
      TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$shlvl"
        "$directory"
        "$git_branch"
        "$git_commit"
        "$git_state"
        # "$git_status"
        "$nodejs"
        "$ruby"
        "$cmd_duration"
        "$line_break"
        "$jobs"
        "$status"
        "$character"
      ];
    };
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
      conflicted = "!vim +Conflicted";
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

  programs.gh.enable = true;

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    vimAlias = true;
    withRuby = false;
    extraConfig = ''
      set termguicolors

      set relativenumber
      set number
      set signcolumn=yes

      set splitbelow
      set splitright

      set noshowmode

      set expandtab
      set shiftwidth=2
      set softtabstop=2

      set incsearch
      set hlsearch
      set ignorecase
      set smartcase

      set cc=80
      set list listchars=tab:»·,trail:·,space:·

      set wildmode=list:longest,list:full
      set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,*/tmp/*,*.so,*.swp,*.zip

      let mapleader=" "

      " fzf
      let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore-vcs --hidden'
      nnoremap <C-t> :Files<cr>
      nnoremap <Leader>ff :Files<CR>
      nnoremap <Leader>fg :Rg<CR>

      " window commands
      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l

      " easier beginning/end of line
      noremap H ^
      noremap L $

      " clear highlight
      nmap <silent> <Esc> <Esc>:nohlsearch<CR>

      " Fugitive
      nnoremap <Leader>gs :Git<CR>

      " copy filepath variants
      nmap <silent> <Leader>C :let @*=expand("%") \| echohl String \| echon 'Copied: ' . expand("%") \| echohl None<CR>

      " cutlass
      nnoremap x d
      xnoremap x d

      " s for substitute
      nmap s <plug>(SubversiveSubstitute)
      nmap ss <plug>(SubversiveSubstituteLine)
      nmap S <plug>(SubversiveSubstituteToEndOfLine)

      nnoremap xx dd
      nnoremap X D

      function! s:ThankYouNext() abort
        update
        argdelete %
        bdelete
        if !empty(argv())
          argument
        endif
      endfunction

      command! ThankYouNext call <sid>ThankYouNext()

      " imap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

      " imap <expr><cr> pumvisible() ? "\<c-y>" : "\<cr><plug>DiscretionaryEnd"

      ${builtins.readFile ./home/vim/help.vim}
    '';

    plugins = with pkgs.vimPlugins; [
      # color theme
      {
        plugin = onedark-vim;
        config = ''
          packadd! onedark-vim
          colorscheme onedark
        '';
      }

      # syntax support
      vim-nix
      vim-ruby
      rust-vim
      typescript-vim
      vim-jsx-typescript
      vim-toml

      vim-sensible
      vim-surround
      vim-vinegar
      vim-fugitive
      vim-rsi
      vim-commentary

      # {
      #   plugin = vim-endwise;
      #   config = ''
      #     let g:endwise_no_mappings = 1
      #   '';
      # }
      lexima-vim

      vim-cutlass
      vim-subversive
      {
        plugin = vim-yoink;
        config = ''
          let g:yoinkIncludeDeleteOperations = 1
        '';
      }

      {
        plugin = vim-sneak;
        config = ''
          let g:sneak#label = 1

          highlight Sneak guifg=#282C34 guibg=#E5C07B
        '';
      }

      {
        plugin = fzf-vim;
        config = ''
          let g:fzf_layout = { 'down': '~40%' }
        '';
      }

      {
        plugin = vim-airline;
        config = ''
          let g:airline_powerline_fonts = 1
        '';
      }
      vim-airline-themes

      vim-conflicted
      vim-system-copy

      vim-snippets

      vim-automkdir

      vim-rails

      {
        plugin = nvim-compe;
        config = ''
          set completeopt=menuone,noselect
          set shortmess+=c

          let g:lexima_no_default_rules = v:true
          call lexima#set_default_rules()
          inoremap <silent><expr> <C-Space> compe#complete()
          inoremap <silent><expr> <CR>      compe#confirm(lexima#expand('<LT>CR>', 'i'))
          inoremap <silent><expr> <C-e>     compe#close('<C-e>')
          inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
          inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

          lua << EOF
            require'compe'.setup {
              enabled = true;
              autocomplete = true;
              debug = false;
              min_length = 1;
              preselect = 'enable';
              throttle_time = 80;
              source_timeout = 200;
              incomplete_delay = 400;
              max_abbr_width = 100;
              max_kind_width = 100;
              max_menu_width = 100;
              documentation = true;

              source = {
                path = true;
                buffer = true;
                calc = true;
                nvim_lsp = true;
              };
            }
          EOF
        '';
      }

      {
        plugin = nvim-lspconfig;
        config = ''
          lua << EOF
            local nvim_lsp = require('lspconfig')
            local on_attach = function(client, bufnr)
              local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
              local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

              buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

              -- Mappings.
              local opts = { noremap=true, silent=true }
              buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
              buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
              buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
              buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
              buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
              buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
              buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
              buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
              buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
              buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
              buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
              buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
              buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
              buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
              buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
              buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

              -- Set some keybinds conditional on server capabilities
              if client.resolved_capabilities.document_formatting then
                buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
              end
              if client.resolved_capabilities.document_range_formatting then
                buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
              end

              -- Set autocommands conditional on server_capabilities
              if client.resolved_capabilities.document_highlight then
                vim.api.nvim_exec([[
                  hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
                  hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
                  hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
                  augroup lsp_document_highlight
                    autocmd! * <buffer>
                    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                  augroup END
                ]], false)
              end
            end

            nvim_lsp.tsserver.setup { on_attach = on_attach }
            nvim_lsp.jsonls.setup { on_attach = on_attach }
            nvim_lsp.cssls.setup { on_attach = on_attach }
            nvim_lsp.html.setup { on_attach = on_attach }
            nvim_lsp.rnix.setup { on_attach = on_attach }

            nvim_lsp.diagnosticls.setup {
              on_attach = on_attach,
              filetypes = { "ruby" },
              init_options = {
                filetypes = {
                  ruby = "rubocop"
                },
                linters = {
                  rubocop = {
                    command = "bundle",
                    sourceName = "rubocop",
                    debounce = 100,
                    args = {
                      "exec", "rubocop", "--format", "json", "--force-exclusion", "--stdin", "%filepath"
                    },
                    parseJson = {
                      errorsRoot = "files[0].offenses",
                      line = "location.start_line",
                      endLine = "location.last_line",
                      column = "location.start_column",
                      endColumn = "location.end_column",
                      message = "[''${cop_name}] ''${message}",
                      security = "severity"
                    },
                    securities = {
                      fatal = "error",
                      error = "error",
                      warning = "warning",
                      convention = "info",
                      refactor = "info",
                      info = "info"
                    }
                  }
                }
              }
            }
          EOF
        '';
      }

      # coc-nvim
      # coc-diagnostic
      # coc-json
      # coc-tsserver
      # coc-prettier
      # # coc-eslint
      # coc-html
      # coc-yaml
      # # coc-solargraph
      # coc-snippets
      # coc-rust-analyzer
      # coc-pairs
    ];
  };

  xdg.configFile."nvim/coc-settings.json".text = builtins.readFile ./home/coc-settings.json;

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

    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace (import ./home/extensions.nix);
  };
}
