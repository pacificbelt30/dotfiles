-- 基本設定 (旧 rc/options.rc.vim)
local opt = vim.opt
local g = vim.g

-- 文字コード
vim.scriptencoding = 'utf-8'
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'
-- 改行コードの判別
opt.fileformat = 'unix'

opt.backup = false
opt.swapfile = false
-- 他の場所で上書きされたとき自動で読む
opt.autoread = true
-- 保存してなくてもバッファに隠せる
opt.hidden = true
-- コマンドが見える
opt.showcmd = true

-- コマンドの補完
opt.wildmenu = true
opt.wildmode = 'full'
opt.history = 5000

-- 見た目系
opt.number = true
-- 現在の行を強調表示
opt.cursorline = true
-- 現在の行を強調表示（縦）
-- opt.cursorcolumn = true
opt.virtualedit = 'onemore'
-- ビープ音を可視化
-- opt.visualbell = true
-- 対応する括弧を光らせる
opt.showmatch = true
-- ステータスラインを常に表示
opt.laststatus = 3
-- tagsファイルを見る (デフォルト ./tags;,tags のまま)

-- Tab系
opt.list = true
opt.listchars = { tab = '▸-' }
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2

-- 大文字小文字区別なし
opt.ignorecase = true
-- 大文字のときのみ区別あり
opt.smartcase = true
-- 1文字うつと検索開始
opt.incsearch = true
opt.wrapscan = true
-- 検索文字のハイライト
opt.hlsearch = true
opt.inccommand = 'nosplit'
-- 残りn行でスクロール開始
opt.scrolloff = 5

-- 全角スペース表示設定
vim.api.nvim_set_hl(0, 'ZenkakuSpace', { cterm = { underline = true }, ctermfg = 'LightBlue', bg = '#666666' })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*',
  command = [[match ZenkakuSpace /　/]],
})

-- opt.smartindent = true
-- opt.autoindent = true
-- opt.cindent = true
-- opt.clipboard = 'unnamed'
opt.clipboard:append('unnamedplus')

-- 背景透過 transparent (現状すべて無効)
vim.api.nvim_create_augroup('TransparentBG', { clear = true })

-- colorscheme
vim.cmd('syntax enable')
opt.background = 'dark'
-- colorscheme tender / jellybeans / onedark / badwolf / molokai
pcall(vim.cmd.colorscheme, 'gruvbox')
opt.termguicolors = true
-- コマンドラインの高さが0になる
opt.cmdheight = 0
opt.pumblend = 20
opt.winblend = 10

-- foldmethod
opt.foldmethod = 'indent'
opt.foldnestmax = 1

-- help 日本語化
opt.helplang = 'ja'

-- ファイルタイプを識別する
vim.cmd('filetype plugin indent on')
g.tex_flavor = 'latex' -- 全.texファイルをlatexファイルとして認識させる

-- undo 永続化
if vim.fn.has('persistent_undo') == 1 then
  opt.undodir = vim.fn.expand('~/.vim/undo')
  opt.undofile = true
end

-- 設定ファイルを開くコマンド
vim.api.nvim_create_user_command('OC', function()
  vim.cmd('edit ~/dotfiles/nvim/init.lua')
  vim.cmd('cd %:h')
end, {})
