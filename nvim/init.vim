"setting
"文字コードをUFT-8に設定
set fenc=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd

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
set showmatch
set laststatus=2

nnoremap j gj
nnoremap k gk
syntax enable


" Tab系
set list listchars=tab:\▸\-
set expandtab
set tabstop=4
"set tabstop=2
set shiftwidth=4
"set shiftwidth=2

set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"set smartindent
"set autoindent
set cindent
"set clipboard=unnamed
set clipboard+=unnamedplus

"colorscheme"
set background=dark
colorscheme tender
colorscheme jellybeans
"colorscheme onedark
colorscheme badwolf
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
Plug 'kana/vim-operator-user'
Plug 'cohama/lexima.vim'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
"Plug 'Shougo/neoinclude.vim'
"Plug 'autozimu/LanguageClient-neovim'
Plug 'pacificbelt30/COOC.vim'
Plug 'preservim/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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

