"setting
"文字コードをUFT-8に設定
set fenc=utf-8
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
"syntax enable

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
"set hlsearch
set nohlsearch
set inccommand=nosplit
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" 残りn行でスクロール開始
set scrolloff=5

highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

"set smartindent
"set autoindent
"set cindent
"set clipboard=unnamed
set clipboard+=unnamedplus

"colorscheme"
set background=dark
"colorscheme tender
"colorscheme jellybeans
"colorscheme onedark
"colorscheme badwolf
"colorscheme molokai
colorscheme gruvbox
set t_Co=256
set termguicolors

nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>
tnoremap <Esc> <C-\><C-n>
tnoremap <a> <i>

if &compatible
 set nocompatible
endif

"プラグイン部分の記述 start"
call plug#begin()
"Plug 'scrooloose/nerdtree'
" 置換
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace'
" 括弧
Plug 'cohama/lexima.vim'
" なんかいろいろ
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
" 補完
"Plug 'Shougo/deoplete.nvim'
" ファイルタイプを
Plug 'Shougo/context_filetype.vim'
" スニペット
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
" include
"Plug 'Shougo/neoinclude.vim'
"Plug 'autozimu/LanguageClient-neovim'
" コメントアウト
Plug 'pacificbelt30/COOC.vim'
" タグ生成 F2
Plug 'preservim/tagbar'
" powerline的なやつになる
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" アイコン
Plug 'ryanoasis/vim-devicons'
" git 操作
Plug 'tpope/vim-fugitive'
" git の追加範囲とかにマークがつく
Plug 'airblade/vim-gitgutter'
" 補完
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" 賢いハイライト
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" 移動系
Plug 'easymotion/vim-easymotion'
" 日本語ヘルプ
Plug 'vim-jp/vimdoc-ja'
" .使った繰り返しが強くなるらしい (試してない)
Plug 'tpope/vim-repeat'
" 禅モード
Plug 'junegunn/goyo.vim'
" ウィンドウリサイズ
Plug 'simeji/winresizer'
" テーマ
Plug 'morhetz/gruvbox',{'do': 'cp colors/* ~/.config/nvim/colors/'}
call plug#end()
"プラグイン部分の記述 end"
filetype plugin on
filetype plugin indent on
"autocmd VimEnter * execute 'NERDTree'
"autocmd FileType c,cpp,h ClangFormatAutoEnable
"let g:rustfmt_autosave = 1
"autocmd VimEnter * execute '<C-w><C-w>'
"map <C-n> :NERDTreeToggle<CR>

"背景透過
"highlight Normal ctermbg=none
"highlight NonText ctermbg=none
"highlight LineNr ctermbg=none
"highlight Folded ctermbg=none
"highlight EndOfBuffer ctermbg=none 

"inoremap {<Enter> {}<Left><CR><ESC><S-o>
"inoremap [<Enter> []<Left><CR><ESC><S-o>
"inoremap (<Enter> ()<Left><CR><ESC><S-o>
function MakeCquery()
  let temp = expand('%:p')
  echo system('echo ''[{"directory": "/home/kutimoti/contest","command": "/usr/bin/c++  ' . temp . ' -std=c++11","file": "' . temp . '"}]'' > compile_commands.json')
endfunction

autocmd FileType c setlocal foldmethod=marker foldcolumn=3
autocmd FileType cpp setlocal foldmethod=marker foldcolumn=3
set tags
let mapleader = "\<Space>"
inoremap <silent> jj <ESC>
tnoremap <silent> jj <C-\><C-n>
nnoremap <silent> p p`]
nnoremap <leader>w :w <CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>V :vs<CR>
nnoremap <leader><CR> :only<CR>
nnoremap <leader>H :sp<CR>
nnoremap <leader>t :tabnew <CR>
"nnoremap <leader><CR> :tabclose <CR>
"nnoremap <leader>b :b  
nnoremap <leader>e :e  
nnoremap <Tab><Tab> q:
"source ~/.vim/co.vim
"nnoremap <leader>n :Ex.<CR>
"nnoremap <silent>bb :b#<CR>
"nnoremap <silent>bd :bd<CR>

"設定読み込み
"source $HOME/.config/nvim/plugins/LanguageClient-neovim.rc.vim
"source $HOME/.config/nvim/plugins/deoplete.rc.vim
source $HOME/.config/nvim/plugins/neosnippet.rc.vim
source $HOME/.config/nvim/plugins/airline.rc.vim
source $HOME/.config/nvim/plugins/tagbar.rc.vim
source $HOME/.config/nvim/plugins/coc.rc.vim
source $HOME/.config/nvim/plugins/denite.rc.vim
source $HOME/.config/nvim/plugins/easymotion.rc.vim
source $HOME/.config/nvim/plugins/tree-sitter.rc.vim

"foldmethod"
set foldmethod=indent
set foldnestmax=1
set helplang=ja

source $HOME/work/float_term/float_term.vim
