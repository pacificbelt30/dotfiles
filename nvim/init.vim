" Main Neovim configuration file
" This file sources other configuration files and sets up the overall environment

" Setting options
source $HOME/.config/nvim/rc/options.rc.vim

" Plugin management
let has_network = 1
if has_network == 1
  source $HOME/.config/nvim/rc/plug.rc.vim
endif

" Key mappings
source $HOME/.config/nvim/rc/keymappings.rc.vim

" Custom text objects
source $HOME/.config/nvim/rc/myTextObjects.rc.vim

" Plugin configurations
source $HOME/.config/nvim/plugins/airline.rc.vim
source $HOME/.config/nvim/plugins/tagbar.rc.vim
source $HOME/.config/nvim/plugins/denite.rc.vim
source $HOME/.config/nvim/plugins/easymotion.rc.vim
source $HOME/.config/nvim/plugins/tree-sitter.rc.vim
source $HOME/.config/nvim/plugins/fzf.rc.vim
source $HOME/.config/nvim/plugins/lexima.rc.vim
source $HOME/.config/nvim/plugins/indentLine.rc.vim
source $HOME/.config/nvim/plugins/toggleterm.rc.vim

" Lua plugins
lua require('nvim-cmp')
lua require('telescoperc')
lua require('luaoptions')

" Test script
source $HOME/work/float_term/float_term.vim
let test=0
augroup test
  autocmd filetype vim let test += 1
augroup END
