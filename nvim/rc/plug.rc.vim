" This file contains the plugin configurations for Neovim

call plug#begin()
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace'
Plug 'kana/vim-textobj-user'
Plug 'windwp/nvim-autopairs'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/context_filetype.vim'
Plug '~/work/easyCO.vim'
Plug '~/work/exasterisk.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'kdheepak/cmp-latex-symbols'
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'liuchengxu/vista.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'p00f/nvim-ts-rainbow'
Plug 'haringsrob/nvim_context_vt'
Plug 'm-demare/hlargs.nvim'
Plug 'easymotion/vim-easymotion'
Plug 'vim-jp/vimdoc-ja'
Plug 'tpope/vim-repeat'
Plug 'junegunn/goyo.vim'
Plug 'simeji/winresizer'
Plug 'LeafCage/vimhelpgenerator'
Plug 'honza/vim-snippets'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'petertriho/nvim-scrollbar'
Plug 'psliwka/vim-smoothie'
Plug 'Yggdroot/indentLine'
Plug 'itchyny/vim-cursorword'
Plug 'lambdalisue/readablefold.vim'
Plug 'rcarriga/nvim-notify'
Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2.*'}
Plug 'morhetz/gruvbox',{'do': 'cp colors/* ~/.config/nvim/colors/'}
Plug 'EdenEast/nightfox.nvim',{'do': 'cp colors/* ~/.config/nvim/colors/'}
Plug 'joshdick/onedark.vim',{'do': 'cp colors/* ~/.config/nvim/colors/'}
Plug 'NLKNguyen/papercolor-theme',{'do': 'cp colors/* ~/.config/nvim/colors/'}
Plug 'sainnhe/gruvbox-material',{'do': 'cp colors/* ~/.config/nvim/colors/'}
Plug 'jacoborus/tender.vim',{'do': 'cp colors/* ~/.config/nvim/colors/'}
Plug 'nanotech/jellybeans.vim',{'do': 'cp colors/* ~/.config/nvim/colors/'}
call plug#end()
