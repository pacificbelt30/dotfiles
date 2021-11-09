"文字コードをUFT-8に設定
set fenc=utf-8
set encoding=utf-8
scriptencoding utf-8
" 改行コードの判別
set fileformat=unix
set nobackup
set noswapfile
" 他の場所で上書きされたとき自動で読む
set autoread
" 保存してなくてもバッファに隠せる
set hidden
" コマンドが見える
set showcmd

" コマンドの補完
set wildmenu 
set wildmode=full
set history=5000 

" 見た目系
set number
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
"set cursorcolumn
set virtualedit=onemore
" ビープ音を可視化
"set visualbell
" 対応する括弧を光らせる
set showmatch
" ステータスラインを常に表示
set laststatus=2 

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" ウィンドウ移動
"nnoremap <C-w> :wincmd w<CR>
nnoremap w :wincmd w<CR>

" Tab系
set list listchars=tab:\▸\-
set expandtab
"set tabstop=4
set tabstop=2
"set shiftwidth=4
set shiftwidth=2

" 大文字小文字区別なし
set ignorecase
" 大文字のときのみ区別あり
set smartcase
" 1文字うつと検索開始
set incsearch
set wrapscan
" 検索文字のハイライト
set hlsearch
"set nohlsearch
set inccommand=nosplit
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" 残りn行でスクロール開始
set scrolloff=5

" 全角スペース表示設定
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

"set smartindent
"set autoindent
"set cindent
"set clipboard=unnamed
set clipboard+=unnamedplus

"背景透過
augroup TransparentBG
  autocmd!
  autocmd Colorscheme * highlight Normal ctermbg=none
  autocmd Colorscheme * highlight NonText ctermbg=none
  autocmd Colorscheme * highlight LineNr ctermbg=none
  autocmd Colorscheme * highlight Folded ctermbg=none
  autocmd Colorscheme * highlight EndOfBuffer ctermbg=none 
augroup END

"colorscheme"
syntax enable
set background=dark
"colorscheme tender
"colorscheme jellybeans
"colorscheme onedark
"colorscheme badwolf
"colorscheme molokai
colorscheme gruvbox
set t_Co=256
set termguicolors


if &compatible
 set nocompatible
endif

"foldmethod"
set foldmethod=indent
set foldnestmax=1
"autocmd FileType c setlocal foldmethod=marker foldcolumn=3
"autocmd FileType cpp setlocal foldmethod=marker foldcolumn=3

"help 日本語化
set helplang=ja
