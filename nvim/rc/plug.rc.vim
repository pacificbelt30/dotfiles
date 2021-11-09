"プラグイン部分の記述 start"
call plug#begin()
"Plug 'scrooloose/nerdtree'
" 置換
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace'
" textobj
Plug 'kana/vim-textobj-user'
" 括弧
Plug 'cohama/lexima.vim'
" なんかいろいろ
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
" 補完
"Plug 'Shougo/deoplete.nvim'
" ファイルタイプを
Plug 'Shougo/context_filetype.vim'
" スニペット
"Plug 'Shougo/neosnippet.vim'
"Plug 'Shougo/neosnippet-snippets'
" include
"Plug 'Shougo/neoinclude.vim'
"Plug 'autozimu/LanguageClient-neovim'
" コメントアウト
"Plug 'pacificbelt30/easyCO.vim'
Plug '~/work/easyCO.vim'
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
" tex
"Plug 'lervag/vimtex'
" snippets
Plug 'honza/vim-snippets'
"fzf ファジーファインダー
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" fzf,coc連携 :CocFzfList
Plug 'antoinemadec/coc-fzf'
" undo tree
Plug 'mbbill/undotree'
" comfortable scroll 別になくていい
Plug 'psliwka/vim-smoothie'
" Plug 'terryma/vim-smooth-scroll'
" インデント可視化
Plug 'Yggdroot/indentLine'
" テーマ
Plug 'morhetz/gruvbox',{'do': 'cp colors/* ~/.config/nvim/colors/'}
Plug 'joshdick/onedark.vim',{'do': 'cp colors/* ~/.config/nvim/colors/'}
Plug 'jacoborus/tender.vim',{'do': 'cp colors/* ~/.config/nvim/colors/'}
Plug 'nanotech/jellybeans.vim',{'do': 'cp colors/* ~/.config/nvim/colors/'}
call plug#end()
"プラグイン部分の記述 end"
