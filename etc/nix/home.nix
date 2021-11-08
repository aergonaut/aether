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

  friendly-snippets = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "friendly-snippets";
    version = "2021-04-25";
    src = pkgs.fetchFromGitHub {
      owner = "rafamadriz";
      repo = "friendly-snippets";
      rev = "ee28380b2300b374251b89d73e7e5b23c573e2bc";
      sha256 = "1ap2nf84gbrqlykw1l8zx01m9hm92vw57wkkzv2cqkjcbm3whqyg";
    };
  };

  nvim-comment = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-comment";
    version = "2021-04-26";
    src = pkgs.fetchFromGitHub {
      owner = "terrortylor";
      repo = "nvim-comment";
      rev = "e7de7abf17204424065b926a9031f44b47efbf4a";
      sha256 = "19m31sjmpn590y5rzs2mgkgqij5hr6v5hnvw30qfh3fjgm3j7fdi";
    };
  };

  vim-github-dark = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "vim-github-dark";
    version = "2021-05-13";
    src = pkgs.fetchFromGitHub {
      owner = "wojciechkepka";
      repo = "vim-github-dark";
      rev = "a46a3faf338032aef9cf491a726076fecf3144b1";
      sha256 = "1w7gas3349v6w1309kqzg7wlx1li4a9mr6kazky5ah91hwgajxaa";
    };
  };

  tokyonight-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "tokyonight.nvim";
    version = "2021-05-17";
    src = pkgs.fetchFromGitHub {
      owner = "folke";
      repo = "tokyonight.nvim";
      rev = "48b2bee03cebc9d8e97ede9a41fddf0f7e3a4527";
      sha256 = "1zany3rys1jjhhc81v1zb3a765dsim4f4w56gb4irsqq9vq3ln66";
    };
  };
in
{
  programs.home-manager.enable = true;

  home.sessionVariables = {
    TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
  };

  home.packages = with pkgs;
    [
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
      nodePackages.prettier
      nodePackages.diagnostic-languageserver
      nodePackages.typescript-language-server
      ripgrep
      rnix-lsp
      shadowenv
      tmux
      tree-sitter
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
      package = pkgs.nerdfonts.override { fonts = [ "Hack" ]; };
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
      foreground = "#c0caf5";
      background = "#1a1b26";
      selection_background = "#33467C";
      selection_foreground = "#c0caf5";
      url_color = "#73daca";
      cursor = "#c0caf5";

      active_tab_background = "#7aa2f7";
      active_tab_foreground = "#1f2335";
      inactive_tab_background = "#292e42";
      inactive_tab_foreground = "#545c7e";

      # black
      color0 = "#15161E";
      color8 = "#414868";

      # red
      color1 = "#f7768e";
      color9 = "#f7768e";

      # green
      color2 = "#9ece6a";
      color10 = "#9ece6a";

      # yellow
      color3 = "#e0af68";
      color11 = "#e0af68";

      # blue
      color4 = "#7aa2f7";
      color12 = "#7aa2f7";

      # magenta
      color5 = "#bb9af7";
      color13 = "#bb9af7";

      # cyan
      color6 = "#7dcfff";
      color14 = "#7dcfff";

      # white
      color7 = "#a9b1d6";
      color15 = "#c0caf5";

      color16 = "#ff9e64";
      color17 = "#db4b4b";
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
        "$git_status"
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
        "git+ssh://git@github.com:coupa/"
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
    vimAlias = true;
    withRuby = false;
    withPython3 = false;
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

      " copy filepath variants
      nmap <silent> <space>C :let @*=expand("%") \| echohl String \| echon 'Copied: ' . expand("%") \| echohl None<CR>

      function! s:ThankYouNext() abort
        update
        argdelete %
        bdelete
        if !empty(argv())
          argument
        endif
      endfunction

      command! ThankYouNext call <sid>ThankYouNext()

      ${builtins.readFile ./home/vim/help.vim}
    '';

    plugins = with pkgs.vimPlugins; [
      # {
      #   plugin = vim-github-dark;
      #   config = ''
      #     colorscheme ghdark
      #     autocmd ColorScheme * highlight ColorColumn guibg=#161b22
      #   '';
      # }
      {
        plugin = tokyonight-nvim;
        config = ''
          let g:tokyonight_style = "night"
          let g:tokyonight_sidebars = [ "qf" ]
          colorscheme tokyonight
        '';
      }

      # syntax support
      {
        plugin = nvim-treesitter;
        config = ''
          lua << EOF
            require'nvim-treesitter.configs'.setup {
              ensure_installed = "maintained",
              highlight = {
                enable = true,
              },
            }
          EOF
        '';
      }
      vim-nix
      vim-ruby
      rust-vim
      typescript-vim
      vim-jsx-typescript
      vim-toml

      vim-sensible
      vim-surround
      vim-vinegar

      {
        plugin = vim-fugitive;
        config = ''
          nnoremap <silent><space>gs :Git<CR>
        '';
      }

      {
        plugin = gitsigns-nvim;
        config = ''
          lua << EOF
            require('gitsigns').setup()
          EOF

          autocmd ColorScheme * hi! link GitSignsAdd GhGreen
          autocmd ColorScheme * hi! link GitSignsChange GhOrange
          autocmd ColorScheme * hi! link GitSignsDelete GhRed
        '';
      }

      vim-rsi

      {
        plugin = vim-cutlass;
        config = ''
          nnoremap x d
          xnoremap x d
          nnoremap xx dd
          nnoremap X D
        '';
      }

      {
        plugin = vim-subversive;
        config = ''
          " s for substitute
          nmap s <plug>(SubversiveSubstitute)
          nmap ss <plug>(SubversiveSubstituteLine)
          nmap S <plug>(SubversiveSubstituteToEndOfLine)
        '';
      }

      {
        plugin = vim-yoink;
        config = ''
          let g:yoinkIncludeDeleteOperations = 1
        '';
      }

      vim-easymotion

      {
        plugin = telescope-nvim;
        config = ''
          lua << EOF
            local actions = require('telescope.actions')
            require('telescope').setup{
              defaults = {
                mappings = {
                  i = {
                    ["<esc>"] = actions.close
                  },
                },
              },
              pickers = {
                find_files = {
                  find_command = { "fd", "--type", "f", "-uu", "-E", "node_modules", "-E", ".git" }
                }
              }
            }
          EOF

          nnoremap <space>ff <cmd>Telescope find_files<cr>
          nnoremap <space>fg <cmd>Telescope live_grep<cr>
          nnoremap <space>fb <cmd>Telescope buffers<cr>
          nnoremap <space>fh <cmd>Telescope help_tags<cr>
        '';
      }

      {
        plugin = lualine-nvim;
        config = ''
          lua << EOF
            require('lualine').setup {
              options = { theme = "tokyonight" };
              extensions = { "fugitive" };
              sections = {
                lualine_c = {
                  {
                    "diagnostics",
                    sources = { "nvim_lsp" },
                    symbols = { error = ' ', warn = ' ', info = ' ' }
                  },
                  {
                    "filename",
                    file_status = true,
                    path = 1
                  }
                }
              }
            }
          EOF
        '';
      }

      nvim-web-devicons

      vim-conflicted
      vim-system-copy

      vim-vsnip
      vim-vsnip-integ
      friendly-snippets

      vim-automkdir

      {
        plugin = vim-rails;
        config = ''
          lua << EOF
            vim.api.nvim_set_keymap("n", "<leader>rr", ":.Rails", {noremap=true, silent=true})
          EOF
        '';
      }

      {
        plugin = nvim-comment;
        config = ''
          lua << EOF
            require('nvim_comment').setup()
            vim.api.nvim_set_keymap("n", "<leader>/", ":CommentToggle<CR>", {noremap=true, silent = true})
            vim.api.nvim_set_keymap("v", "<leader>/", ":CommentToggle<CR>", {noremap=true, silent = true})
          EOF
        '';
      }

      # nvim-cmp plugins
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-vsnip

      {
        plugin = nvim-cmp;
        config = ''
          set completeopt=menu,menuone,noselect

          lua <<EOF
            -- Setup nvim-cmp.
            local cmp = require'cmp'

            cmp.setup({
              snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                  vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                  -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                  -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                  -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
                end,
              },
              mapping = {
                ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                ['<C-e>'] = cmp.mapping({
                  i = cmp.mapping.abort(),
                  c = cmp.mapping.close(),
                }),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
              },
              sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'vsnip' }, -- For vsnip users.
                -- { name = 'luasnip' }, -- For luasnip users.
                -- { name = 'ultisnips' }, -- For ultisnips users.
                -- { name = 'snippy' }, -- For snippy users.
              }, {
                { name = 'buffer' },
              })
            })

            -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
            -- cmp.setup.cmdline('/', {
            --   sources = {
            --     { name = 'buffer' }
            --   }
            -- })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            -- cmp.setup.cmdline(':', {
            --   sources = cmp.config.sources({
            --     { name = 'path' }
            --   }, {
            --     { name = 'cmdline' }
            --   })
            -- })
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
              -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
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
                buf_set_keymap("n", "<space>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
              end
              if client.resolved_capabilities.document_range_formatting then
                buf_set_keymap("v", "<space>lf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
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

            -- Custom on_attach for tsserver
            local tsserver_onattach = function(client, bufnr)
              on_attach(client, bufnr)
              -- Disable formatting via tsserver (in favor of prettier through dls)
              client.resolved_capabilities.document_formatting = false
            end
            nvim_lsp.tsserver.setup {
              on_attach = tsserver_onattach,
              settings = { documentFormatting = false },
              capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
            }
            
            local basic_servers = { "jsonls", "cssls", "html", "rnix" }
            for _, server in ipairs(basic_servers) do
              nvim_lsp[server].setup {
                on_attach = on_attach,
                capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
              }
            end

            -- nvim_lsp.jsonls.setup { on_attach = on_attach }
            -- nvim_lsp.cssls.setup { on_attach = on_attach }
            -- nvim_lsp.html.setup { on_attach = on_attach }
            -- nvim_lsp.rnix.setup { on_attach = on_attach }

            nvim_lsp.diagnosticls.setup {
              on_attach = on_attach,
              filetypes = {
                "ruby",
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact"
              },
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
                },
                formatFiletypes = {
                  javascript = "prettier",
                  javascriptreact = "prettier",
                  typescript = "prettier",
                  typescriptreact = "prettier",
                  markdown = "prettier"
                },
                formatters = {
                  prettier = {
                    command = "prettier",
                    args = {
                      "--stdin-filepath", "%filepath"
                    },
                    rootPatterns = {
                      ".prettierrc",
                      ".prettierrc.json",
                      ".prettierrc.toml",
                      ".prettierrc.json",
                      ".prettierrc.yml",
                      ".prettierrc.yaml",
                      ".prettierrc.json5",
                      ".prettierrc.js",
                      ".prettierrc.cjs",
                      "prettier.config.js",
                      "prettier.config.cjs"
                    }
                  }
                }
              }
            }

            vim.fn.sign_define("LspDiagnosticsSignError", {text=""})
            vim.fn.sign_define("LspDiagnosticsSignWarning", {text=""})
            vim.fn.sign_define("LspDiagnosticsSignInformation", {text=""})
          EOF

          " autocmds for formatting on save
          autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 1000)
          autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 1000)
          autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_sync(nil, 1000)
          autocmd BufWritePre *.tsx lua vim.lsp.buf.formatting_sync(nil, 1000)
          autocmd BufWritePre *.md lua vim.lsp.buf.formatting_sync(nil, 1000)
          autocmd BufWritePre *.nix lua vim.lsp.buf.formatting_sync(nil, 1000)
        '';
      }
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

    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace (import ./home/extensions.nix);
  };
}
