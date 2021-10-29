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

" 
"nnoremap <leader>n :Files<CR>
nnoremap <leader>n :ProjectFiles<CR>
nnoremap <leader>r :Rg 
nnoremap <leader>b :Buffers<CR>
nmap / :BLines<CR>
nnoremap <leader>e :CocFzfList diagnostics<CR>

" fzfターミナル上でのキーマップ
augroup _fzf_
  autocmd!
  autocmd FileType fzf nnoremap <buffer> q :q<CR>
  "autocmd * <buffer> autocmd FileType fzf tnoremap <Esc> <C-\><C-n>:q<CR> 
  autocmd FileType fzf tnoremap <buffer> <Esc> <C-\><C-n>:q<CR>
  autocmd FileType fzf tnoremap <buffer> jj <C-\><C-n>:q<CR>
  "autocmd FileType fzf tnoremap <buffer> <Esc> <C-\><C-n>
  "autocmd FileType fzf tnoremap <buffer> jj <C-\><C-n>
  autocmd FileType fzf tnoremap <buffer> <Space><Space> <C-u>
  "autocmd FileType fzf set timeoutlen=200
  "autocmd FileType fzf tnoremap <buffer> jj <C-\><C-n>:q<CR>
augroup END
