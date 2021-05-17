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
    nodePackages.prettier
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
      nmap <silent> <Leader>C :let @*=expand("%") \| echohl String \| echon 'Copied: ' . expand("%") \| echohl None<CR>

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
          nnoremap <silent><Leader>gs :Git<CR>
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

      lexima-vim

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
              }
            }
          EOF

          nnoremap <leader>ff <cmd>Telescope find_files<cr>
          nnoremap <leader>fg <cmd>Telescope live_grep<cr>
          nnoremap <leader>fb <cmd>Telescope buffers<cr>
          nnoremap <leader>fh <cmd>Telescope help_tags<cr>
        '';
      }

      {
        plugin = lualine-nvim;
        config = ''
          lua << EOF
            require('lualine').setup {
              options = { theme = "tokyonight" };
              sections = {
                lualine_c = {
                  {
                    "diagnostics",
                    sources = { "nvim_lsp" },
                    symbols = {error = ' ', warn = ' ', info = ' '}
                  }
                }
              }
            }
          EOF
        '';
      }
      # {
      #   plugin = vim-airline-head;
      #   config = ''
      #     let g:airline_experimental = 0
      #     let g:airline_powerline_fonts = 1
      #   '';
      # }
      # vim-airline-themes
      nvim-web-devicons
      #       {
      #         plugin = galaxyline-nvim;
      #         config = ''
      #           lua << EOF
      #             local gl = require('galaxyline')
      #             local gls = gl.section
      #             gl.short_line_list = {'LuaTree','vista','dbui'}
      # 
      #             local colors = {
      #               bg = '#282c34',
      #               yellow = '#fabd2f',
      #               cyan = '#008080',
      #               darkblue = '#081633',
      #               green = '#afd700',
      #               orange = '#FF8800',
      #               purple = '#5d4d7a',
      #               magenta = '#d16d9e',
      #               grey = '#c0c0c0',
      #               blue = '#0087d7',
      #               red = '#ec5f67'
      #             }
      # 
      #             local buffer_not_empty = function()
      #               if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
      #                 return true
      #               end
      #               return false
      #             end
      # 
      #             gls.left[1] = {
      #               FirstElement = {
      #                 provider = function() return '▋' end,
      #                 highlight = {colors.blue,colors.yellow}
      #               },
      #             }
      #             gls.left[2] = {
      #               ViMode = {
      #                 provider = function()
      #                   local alias = {n = 'NORMAL',i = 'INSERT',c= 'COMMAND',v= 'VISUAL',V= 'VISUAL LINE', [''] = 'VISUAL BLOCK'}
      #                   return alias[vim.fn.mode()]
      #                 end,
      #                 separator = '',
      #                 separator_highlight = {colors.purple,function()
      #                   if not buffer_not_empty() then
      #                     return colors.purple
      #                   end
      #                   return colors.darkblue
      #                 end},
      #                 highlight = {colors.darkblue,colors.purple,'bold'},
      #               },
      #             }
      #             gls.left[3] ={
      #               FileIcon = {
      #                 provider = 'FileIcon',
      #                 condition = buffer_not_empty,
      #                 highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.darkblue},
      #               },
      #             }
      #             gls.left[4] = {
      #               FileName = {
      #                 provider = {'FileName','FileSize'},
      #                 condition = buffer_not_empty,
      #                 separator = '',
      #                 separator_highlight = {colors.purple,colors.darkblue},
      #                 highlight = {colors.magenta,colors.darkblue}
      #               }
      #             }
      # 
      #             gls.left[5] = {
      #               GitIcon = {
      #                 provider = function() return '  ' end,
      #                 condition = buffer_not_empty,
      #                 highlight = {colors.orange,colors.purple},
      #               }
      #             }
      #             gls.left[6] = {
      #               GitBranch = {
      #                 provider = 'GitBranch',
      #                 condition = buffer_not_empty,
      #                 highlight = {colors.grey,colors.purple},
      #               }
      #             }
      # 
      #             local checkwidth = function()
      #               local squeeze_width  = vim.fn.winwidth(0) / 2
      #               if squeeze_width > 40 then
      #                 return true
      #               end
      #               return false
      #             end
      # 
      #             gls.left[7] = {
      #               DiffAdd = {
      #                 provider = 'DiffAdd',
      #                 condition = checkwidth,
      #                 icon = ' ',
      #                 highlight = {colors.green,colors.purple},
      #               }
      #             }
      #             gls.left[8] = {
      #               DiffModified = {
      #                 provider = 'DiffModified',
      #                 condition = checkwidth,
      #                 icon = ' ',
      #                 highlight = {colors.orange,colors.purple},
      #               }
      #             }
      #             gls.left[9] = {
      #               DiffRemove = {
      #                 provider = 'DiffRemove',
      #                 condition = checkwidth,
      #                 icon = ' ',
      #                 highlight = {colors.red,colors.purple},
      #               }
      #             }
      #             gls.left[10] = {
      #               LeftEnd = {
      #                 provider = function() return '' end,
      #                 separator = '',
      #                 separator_highlight = {colors.purple,colors.bg},
      #                 highlight = {colors.purple,colors.purple}
      #               }
      #             }
      #             gls.left[11] = {
      #               DiagnosticError = {
      #                 provider = 'DiagnosticError',
      #                 icon = '  ',
      #                 highlight = {colors.red,colors.bg}
      #               }
      #             }
      #             gls.left[12] = {
      #               Space = {
      #                 provider = function () return ' ' end
      #               }
      #             }
      #             gls.left[13] = {
      #               DiagnosticWarn = {
      #                 provider = 'DiagnosticWarn',
      #                 icon = '  ',
      #                 highlight = {colors.blue,colors.bg},
      #               }
      #             }
      #             gls.right[1]= {
      #               FileFormat = {
      #                 provider = 'FileFormat',
      #                 separator = '',
      #                 separator_highlight = {colors.bg,colors.purple},
      #                 highlight = {colors.grey,colors.purple},
      #               }
      #             }
      #             gls.right[2] = {
      #               LineInfo = {
      #                 provider = 'LineColumn',
      #                 separator = ' | ',
      #                 separator_highlight = {colors.darkblue,colors.purple},
      #                 highlight = {colors.grey,colors.purple},
      #               },
      #             }
      #             gls.right[3] = {
      #               PerCent = {
      #                 provider = 'LinePercent',
      #                 separator = '',
      #                 separator_highlight = {colors.darkblue,colors.purple},
      #                 highlight = {colors.grey,colors.darkblue},
      #               }
      #             }
      #             gls.right[4] = {
      #               ScrollBar = {
      #                 provider = 'ScrollBar',
      #                 highlight = {colors.yellow,colors.purple},
      #               }
      #             }
      # 
      #             gls.short_line_left[1] = {
      #               BufferType = {
      #                 provider = 'FileTypeName',
      #                 separator = '',
      #                 separator_highlight = {colors.purple,colors.bg},
      #                 highlight = {colors.grey,colors.purple}
      #               }
      #             }
      # 
      # 
      #             gls.short_line_right[1] = {
      #               BufferIcon = {
      #                 provider= 'BufferIcon',
      #                 separator = '',
      #                 separator_highlight = {colors.purple,colors.bg},
      #                 highlight = {colors.grey,colors.purple}
      #               }
      #             }
      # 
      #           EOF
      #         '';
      #       }

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
                nvim_lua = true;
                vsnip = true;
              };
            }

            local t = function(str)
              return vim.api.nvim_replace_termcodes(str, true, true, true)
            end

            local check_back_space = function()
                local col = vim.fn.col('.') - 1
                if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                    return true
                else
                    return false
                end
            end

            -- Use (s-)tab to:
            --- move to prev/next item in completion menuone
            --- jump to prev/next snippet's placeholder
            _G.tab_complete = function()
              if vim.fn.pumvisible() == 1 then
                return t "<C-n>"
              elseif vim.fn.call("vsnip#available", {1}) == 1 then
                return t "<Plug>(vsnip-expand-or-jump)"
              elseif check_back_space() then
                return t "<Tab>"
              else
                return vim.fn['compe#complete']()
              end
            end
            _G.s_tab_complete = function()
              if vim.fn.pumvisible() == 1 then
                return t "<C-p>"
              elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
                return t "<Plug>(vsnip-jump-prev)"
              else
                return t "<S-Tab>"
              end
            end

            vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
            vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
            vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
            vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
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

            -- Custom on_attach for tsserver
            local tsserver_onattach = function(client, bufnr)
              on_attach(client, bufnr)
              -- Disable formatting via tsserver (in favor of prettier through dls)
              client.resolved_capabilities.document_formatting = false
            end
            nvim_lsp.tsserver.setup {
              on_attach = tsserver_onattach,
              settings = { documentFormatting = false }
            }

            nvim_lsp.jsonls.setup { on_attach = on_attach }
            nvim_lsp.cssls.setup { on_attach = on_attach }
            nvim_lsp.html.setup { on_attach = on_attach }
            nvim_lsp.rnix.setup { on_attach = on_attach }

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
