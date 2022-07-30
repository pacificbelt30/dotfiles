"nnoremap <F2> :TagbarToggle<CR>
"nnoremap <F2> :TagbarToggle<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']
let g:vista_executive_for = {
  \ 'tex': 'coc',
  \ 'python': 'coc',
  \ }
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
nnoremap <F12> :Vista!!<CR>
augroup vista
  autocmd!
  "autocmd VimEnter * Vista
augroup END
