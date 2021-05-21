" deoplete options
let g:deoplete#enable_at_startup = 1
"let g:deoplete#auto_complete_delay = 0
"let g:deoplete#auto_complete_start_length = 1
"let g:deoplete#enable_camel_case = 0
"let g:deoplete#enable_ignore_case = 0
"let g:deoplete#enable_refresh_always = 0
"let g:deoplete#enable_smart_case = 1
"let g:deoplete#file#enable_buffer_path = 1
"let g:deoplete#max_list = 10000
imap  <expr><TAB>
    \ pumvisible() ? "\<C-n>" :
    \ neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
 
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
call deoplete#custom#option('camel_case',v:false)
call deoplete#custom#option('ignore_case',v:false)
call deoplete#custom#option('refresh_always',v:false)
call deoplete#custom#option('smart_case',v:true)
call deoplete#custom#option('buffer_path',v:true)
call deoplete#custom#option('max_list',10000)
call deoplete#custom#option('auto_complete_delay',v:false)
call deoplete#custom#option('auto_complete_start_length',1)
