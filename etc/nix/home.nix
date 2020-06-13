{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true;

  programs.bat.enable = true;
  programs.fzf.enable = true;

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
