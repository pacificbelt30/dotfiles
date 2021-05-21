set hidden

let g:LanguageClient_serverCommands = {}

"ccls or clangd
if executable('ccls')
    let g:LanguageClient_serverCommands = {
        \ 'cpp': ['ccls'],
        \ 'c': ['ccls'],
        \ }
endif
"rls
if executable('rls')
    let g:LanguageClient_serverCommands['rust'] = ['rls']
endif
augroup LCHighlight
    autocmd!
    autocmd CursorHold,CursorHoldI *.c,*.cpp call LanguageClient#textDocument_documentHighlight()
augroup END

" カーソル停止から更新までの時間をミリ秒で記入。デフォルトは4秒=4000
set updatetime=50
augroup LanguageClient_config
    autocmd!
    autocmd User LanguageClientStarted setlocal signcolumn=yes
    autocmd User LanguageClientStopped setlocal signcolumn=auto
augroup END
"let g:LanguageClient_useVirtualText = 0
let g:LanguageClient_autoStart = 1
nnoremap D :call LanguageClient_textDocument_definition()<CR>
nnoremap R :call LanguageClient_textDocument_rename()<CR>
nnoremap K :call LanguageClient#textDocument_hover()<CR>
nnoremap F :call LanguageClient#textDocument_formatting()<CR>
