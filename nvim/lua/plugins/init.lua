-- プラグイン宣言 (lazy.nvim)
-- vim-plug から lazy.nvim へ移行したもの。設定本体は lua/plugins/*.lua 側に
-- あり、ここではプラグインの宣言とブートストラップのみを行う。

-- lazy.nvim のブートストラップ (未導入なら stable を clone する)
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...', 'MoreMsg' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- 置換 (operator)
  'kana/vim-operator-user',
  'kana/vim-operator-replace',
  -- textobj
  'kana/vim-textobj-user',
  -- 括弧
  'windwp/nvim-autopairs',
  -- ファイルタイプ判定
  'Shougo/context_filetype.vim',
  -- コメントアウト
  'pacificbelt30/easyCO.vim',
  -- アスタリスク拡張
  'pacificbelt30/exasterisk.vim',

  -- ステータスライン (lualine。vim-airline から移行)
  'nvim-lualine/lualine.nvim',
  'kyazdani42/nvim-web-devicons',
  -- アイコン
  'ryanoasis/vim-devicons',

  -- git 操作
  'tpope/vim-fugitive',
  -- git の追加範囲とかにマークがつく
  'airblade/vim-gitgutter',

  -- 補完 / LSP (nvim-cmp)
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp-signature-help',
  'hrsh7th/cmp-nvim-lua',
  'kdheepak/cmp-latex-symbols',

  -- スニペット (LuaSnip。ultisnips / vim-snippets から移行)
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  'rafamadriz/friendly-snippets',

  -- tagbar の lsp 対応版
  'liuchengxu/vista.vim',

  -- TreeSitter
  -- 賢いハイライト (旧 API の .configs を使うため master ブランチに固定)
  { 'nvim-treesitter/nvim-treesitter', branch = 'master', build = ':TSUpdate' },
  -- treesitter 親となるクラスや関数を上部に表示する
  'nvim-treesitter/nvim-treesitter-context',
  -- rainbow括弧 (メンテ終了した nvim-ts-rainbow の後継)
  'HiPhish/rainbow-delimiters.nvim',
  -- treesitter クラスや関数の詳細を下部に表示
  'haringsrob/nvim_context_vt',
  -- treesitter 引数を色付け
  'm-demare/hlargs.nvim',

  -- 移動系
  'easymotion/vim-easymotion',
  -- 日本語ヘルプ
  'vim-jp/vimdoc-ja',
  -- .使った繰り返しが強くなるらしい
  'tpope/vim-repeat',
  -- 禅モード
  'junegunn/goyo.vim',
  -- ウィンドウリサイズ
  'simeji/winresizer',
  -- vim plugin help generator
  'LeafCage/vimhelpgenerator',

  -- ファジーファインダー
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
  -- fzf-lua (fzf.vim / denite から移行)
  'ibhagwan/fzf-lua',

  -- undo tree
  'mbbill/undotree',
  -- スクロールバー
  'petertriho/nvim-scrollbar',
  -- comfortable scroll
  'psliwka/vim-smoothie',
  -- インデント可視化
  'Yggdroot/indentLine',
  -- カーソル下の単語にアンダーライン，色つけ
  'itchyny/vim-cursorword',
  -- readable fold
  'lambdalisue/readablefold.vim',
  -- 通知ポップアップ
  'rcarriga/nvim-notify',
  -- floating term
  { 'akinsho/toggleterm.nvim', version = '2.*' },

  -- テーマ (lazy が runtimepath に colors/ を追加するため cp は不要)
  'morhetz/gruvbox',
  'EdenEast/nightfox.nvim',
  'joshdick/onedark.vim',
  'NLKNguyen/papercolor-theme',
  'sainnhe/gruvbox-material',
  'jacoborus/tender.vim',
  'nanotech/jellybeans.vim',
}, {
  -- 設定は lua/plugins/*.lua 側で行うため遅延読み込みはしない
  defaults = { lazy = false },
  install = { missing = true },
  change_detection = { notify = false },
})
