"setting
source $HOME/.config/nvim/rc/options.rc.vim

"Plug
source $HOME/.config/nvim/rc/plug.rc.vim

" ファイルタイプを識別する
filetype on
filetype plugin on
filetype indent on
let g:tex_flavor = 'latex' " 全.texファイルをlatexファイルとして認識させる
" NERDTree設定
"autocmd VimEnter * execute 'NERDTree'
"autocmd FileType c,cpp,h ClangFormatAutoEnable
"let g:rustfmt_autosave = 1
"autocmd VimEnter * execute '<C-w><C-w>'
"map <C-n> :NERDTreeToggle<CR>

"inoremap {<Enter> {}<Left><CR><ESC><S-o>
"inoremap [<Enter> []<Left><CR><ESC><S-o>
"inoremap (<Enter> ()<Left><CR><ESC><S-o>
function MakeCquery()
  let temp = expand('%:p')
  echo system('echo ''[{"directory": "/home/kutimoti/contest","command": "/usr/bin/c++  ' . temp . ' -std=c++11","file": "' . temp . '"}]'' > compile_commands.json')
endfunction


" keybinding
source $HOME/.config/nvim/rc/keymappings.rc.vim

" undo 永続化
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

"設定読み込み
"source ~/.vim/co.vim
"source $HOME/.config/nvim/plugins/LanguageClient-neovim.rc.vim
"source $HOME/.config/nvim/plugins/deoplete.rc.vim
source $HOME/.config/nvim/plugins/neosnippet.rc.vim
source $HOME/.config/nvim/plugins/airline.rc.vim
source $HOME/.config/nvim/plugins/tagbar.rc.vim
source $HOME/.config/nvim/plugins/coc.rc.vim
source $HOME/.config/nvim/plugins/denite.rc.vim
source $HOME/.config/nvim/plugins/easymotion.rc.vim
source $HOME/.config/nvim/plugins/tree-sitter.rc.vim
source $HOME/.config/nvim/plugins/fzf.rc.vim
source $HOME/.config/nvim/plugins/indentLine.rc.vim
"lua require('telescoperc')

" 設定ファイルを開くコマンド及び関数
function! OpenConf()
  :e ~/.config/nvim/init.vim
  :cd %:h
endfunctio
command! OC call OpenConf()

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

call textobj#user#plugin('tex', {
\   'environment': {
\     'pattern': ['\\begin{.*}.*\n', '\\end{.*}'],
\     'select-a': 'ae',
\     'select-i': 'ie',
\   },
\ })

