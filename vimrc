" setting
set clipboard=unnamedplus
"文字コードをUFT-8に設定
set fenc=utf-8
set encoding=utf-8
scriptencoding utf-8
" 改行コードの自動判別
set fileformat=unix
" □や○文字が崩れる問題を解決
set ambiwidth=double
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
"
"set spell
"ターミナル接続高速化
set ttyfast

" 見た目系
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
"set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
"set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmenu
""set wildmode=list:longest
set wildmode=full
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" シンタックスハイライトの有効化
syntax enable

" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2
set softtabstop=2
"python用
setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
" 残り五行からスクロール開始
set scrolloff=5

" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"leaderキーはスペースキー(便利)
"キーバインドコーナー
let mapleader = "\<Space>"
inoremap <silent> jj <ESC>
"inoremap <silent> jk <ESC>
nnoremap <silent> p p`]
nnoremap <leader>w :w <CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>V :vs<CR>
nnoremap <leader><CR> :only<CR>
nnoremap <leader>H :sp<CR>
nnoremap <leader>t :tabnew <CR>
"nnoremap <leader><CR> :tabclose <CR>
nnoremap <leader>b :b 
nnoremap <leader>e :e 
nnoremap <Tab><Tab> q:
" 補完表示時のEnterで改行をしない
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"

set completeopt=menuone,noinsert
inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
for k in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_",'\zs')
  exec "imap <expr> " . k . " pumvisible() ? '" . k . "' : '" . k . "\<C-X>\<C-P>\<C-N>'"
endfor

" 括弧の補完"
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
" yiwなどを使いやすく"
onoremap 8 i(
onoremap 2 i"
onoremap 7 i'
onoremap @ i`
onoremap [ i[
onoremap { i{
""inoremap < <><LEFT>
nmap ; :
inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"
filetype on
filetype indent on
filetype plugin on
nnoremap <leader>n :Ex.<CR>
""nnoremap <silent>bb :b#<CR>
""nnoremap <silent>bd :bd<CR>
"バイナリ表示用の設定"
""augroup BinaryXXD
""  autocmd!
""  autocmd BufReadPre  *.bin let &binary =1
""  autocmd BufReadPost * if &binary | silent %!xxd -g 1
""  autocmd BufReadPost * set ft=xxd | endif
""  autocmd BufWritePre * if &binary | %!xxd -r | endif
""  autocmd BufWritePost * if &binary | silent %!xxd -g 1
""  autocmd BufWritePost * set nomod | endif
""augroup END
augroup SpaceDelete
  autocmd!
  ""autocmd BufWritePre * :%s/\s\+$//ge
augroup END

"検索語が画面の真ん中に来るようにする
"nmap n nzz 
"nmap N Nzz 
"nmap * *zz 
"nmap # #zz 
"nmap g* g*zz 
"nmap g# g#zz
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

" 別ファイル読み込み
source ~/.vim/co.vim

" plugin
" has_network == 1のとき読み込み
let has_network = 0
if has_network == 1
  "Plug ""
endif
