" Source config modules
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/themes/vim-sunbather.vim
source $HOME/.config/nvim/plug-config/coc.vim
source $HOME/.config/nvim/plug-config/rnvimr.vim
source $HOME/.config/nvim/plug-config/rust.vim
source $HOME/.config/nvim/plug-config/fugitive.vim

" Interface tweaks
hi Normal ctermbg=NONE guibg='#131a1c' gui=NONE
hi LineNr ctermbg=NONE guibg='#131a1c'
set signcolumn=no

" Cursor config
set guicursor+=n:hor20-Cursor/lCursor
set guicursor+=i:ver25-iCursor

