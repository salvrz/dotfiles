" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      "autocmd VimEnter * PlugInstall
      "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
      
call plug#begin('~/.config/nvim/autoload/plugged')

  " Better Syntax Support
  Plug 'sheerun/vim-polyglot'
  " File Explorer
  Plug 'scrooloose/NERDTree'
  " Auto pairs for '(' '[' '{'
  Plug 'jiangmiao/auto-pairs'
  " Stable version of coc
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " Asynch Linter
  Plug 'dense-analysis/ale'
  " Themes
  Plug 'nikolvs/vim-sunbather'
  Plug 'logico/typewriter-vim'
  " Ranger
  Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
  " Rust
  Plug 'rust-lang/rust.vim'
  " Git
  Plug 'tpope/vim-fugitive'
  " vim man
  Plug 'vim-utils/vim-man'
call plug#end()
