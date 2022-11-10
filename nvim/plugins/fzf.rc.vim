" fzf settings
let $FZF_DEFAULT_OPTS="--layout=reverse"
"let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"
"let g:fzf_layout = {'down':'~40%'}

function! s:find_git_root()
  " プロジェクトルートで開く
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()
" Filesコマンドにもプレビューを出す
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
"command! -bang -nargs=? -complete=dir Files
    "\ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'head -20 {}']}, <bang>0)

" GFilesはgitignore対象を非表示
command! GitProjectFiles execute 'GFiles -oc --exclude-standard' s:find_git_root()
command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

" ripgrepで検索中、?を押すとプレビュー:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" preview付きBLines
command! -bang -nargs=* BLines
    \ call fzf#vim#grep(
    \   'rg --with-filename --column --line-number --no-heading --smart-case . '.fnameescape(expand('%:p')), 1,
    \   fzf#vim#with_preview({'options': '--layout reverse --query '.shellescape(<q-args>).' --with-nth=4.. --delimiter=":"'}, 'right:50%'))
    " \   fzf#vim#with_preview({'options': '--layout reverse  --with-nth=-1.. --delimiter="/"'}, 'right:50%'))

" カーソル以下の単語取得
function! SelectUnderWord()
  let searchWord = expand("<cword>")
  return searchWord
endfunction
" カーソル以下の単語でfzf grep
function! AsteriskGrep()
  call fzf#vim#grep(
  \   'rg --with-filename --column --line-number --no-heading --smart-case . '.fnameescape(expand('%:p')), 1,
  \   fzf#vim#with_preview({'options': '--layout reverse --query '.shellescape(SelectUnderWord() . ' ').' --with-nth=4.. --delimiter=":"'}, 'right:50%'))
endfunction

" 
"nnoremap <leader>n :Files<CR>
"nnoremap <leader>n :ProjectFiles<CR>
"nnoremap <leader>n :GitProjectFiles<CR>
"nnoremap <leader>r :Rg 
nnoremap <leader>b :Buffers<CR>
nmap / :BLines<CR>
nmap \ :Rg<CR>
map * <nop>
nmap * :call AsteriskGrep()<CR>
nnoremap <leader>e :CocFzfList diagnostics<CR>

" gitレポジトリがある場合はGFiles,ない場合はFilesを使う
if system('git rev-parse --show-toplevel 2> /dev/null')[:-2] == ""
  "echo "gitなし"
  nnoremap <leader>n :ProjectFiles<CR>
else
  "echo "gitあり"
  nnoremap <leader>n :GitProjectFiles<CR>
endif

" fzfターミナル上でのキーマップ
augroup _fzf_
  autocmd!
  autocmd FileType fzf set winblend=15
  autocmd FileType fzf nnoremap <buffer> q :q<CR> 
  autocmd FileType fzf tnoremap <buffer> <Esc> <C-\><C-n>:q<CR>
  autocmd FileType fzf tnoremap <buffer> jj <C-\><C-n>:q<CR>
  autocmd FileType fzf tnoremap <buffer> <Space><Space> <C-u>
augroup END
