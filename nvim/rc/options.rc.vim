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
" tagsファイルを見る
set tags

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

"背景透過 transparent
augroup TransparentBG
  autocmd!
  "autocmd Colorscheme * highlight Normal ctermbg=none guibg=none
  "autocmd Colorscheme * highlight NonText ctermbg=none guibg=none
  "autocmd Colorscheme * highlight LineNr ctermbg=none guibg=none
  "autocmd Colorscheme * highlight Folded ctermbg=none guibg=none
  "autocmd Colorscheme * highlight EndOfBuffer ctermbg=none guibg=none
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

" undo 永続化
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

" 設定ファイルを開くコマンド及び関数
function! OpenConf()
  ":e ~/.config/nvim/init.vim
  :e ~/dotfiles/nvim/init.vim
  :cd %:h
endfunctio
command! OC call OpenConf()
