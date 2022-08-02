"setting
source $HOME/.config/nvim/rc/options.rc.vim

"Plug
let has_network = 1
if has_network == 1
  source $HOME/.config/nvim/rc/plug.rc.vim
endif

"keybinding
source $HOME/.config/nvim/rc/keymappings.rc.vim

"myTextObject
source $HOME/.config/nvim/rc/myTextObjects.rc.vim

"プラグインごとの設定読み込み
"source ~/.vim/co.vim
"source $HOME/.config/nvim/plugins/LanguageClient-neovim.rc.vim
"source $HOME/.config/nvim/plugins/deoplete.rc.vim
"source $HOME/.config/nvim/plugins/neosnippet.rc.vim
source $HOME/.config/nvim/plugins/airline.rc.vim
"source $HOME/.config/nvim/plugins/tagbar.rc.vim
source $HOME/.config/nvim/plugins/tagbar.rc.vim
source $HOME/.config/nvim/plugins/coc.rc.vim
source $HOME/.config/nvim/plugins/denite.rc.vim
source $HOME/.config/nvim/plugins/easymotion.rc.vim
source $HOME/.config/nvim/plugins/tree-sitter.rc.vim
source $HOME/.config/nvim/plugins/fzf.rc.vim
source $HOME/.config/nvim/plugins/indentLine.rc.vim
set runtimepath+=$HOME/.config/nvim/plugins/
set runtimepath+=$HOME/.config/nvim/rc/
" lua plugins
lua require('nvim-cmp')
lua require('telescoperc')
"source $HOME/.config/nvim/plugins/nvim-cmp.rc.vim

" Lua version
"source $HOME/.config/nvim/plugins/luaoptions.rc.vim
lua require('luaoptions')

" test script
source $HOME/work/float_term/float_term.vim
let test=0
augroup test
  autocmd filetype vim let test += 1
augroup END
" Find files using Telescope command-line sugar.
"nnoremap <leader>ff <cmd>Telescope find_files<cr>
"nnoremap <leader>fg <cmd>Telescope live_grep<cr>
"nnoremap <leader>fb <cmd>Telescope buffers<cr>
"nnoremap <leader>fh <cmd>Telescope help_tags<cr>
"
" Using Lua functions
"nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
"nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
"nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
"nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
"
"substitute
"let val = "\\\\\\\\"
"let test = substitute(val,"\\","/","g")
"echo test

"let g:COList = [{"coMozi":"\\\\","extention":["tex","c","cpp"]},{"coMozi":"\#","extention":["py"]}]

