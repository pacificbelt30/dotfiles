-- Neovim設定エントリポイント (Lua版)
-- 旧 init.vim を全面的に Lua へ移行したもの。

if vim.fn.has('nvim-0.11') == 0 then
  error('This Neovim config requires Neovim 0.11 or newer.')
end

-- mapleaderはプラグイン読み込み前に設定する必要がある
vim.g.mapleader = ' '

-- 基本設定
require('options')

-- プラグイン (lazy.nvim)
local has_network = true
if has_network then
  require('plugins')
end

-- キーマッピング
require('keymaps')

-- 自作テキストオブジェクト
require('textobjects')

-- プラグインごとの設定読み込み
require('plugins.lualine')
require('plugins.tagbar')
-- require('plugins.coc')   -- coc.nvim は nvim-cmp に移行したため無効
-- require('plugins.denite') -- denite は fzf-lua に移行したため無効
require('plugins.easymotion')
require('plugins.treesitter')
require('plugins.fzf')
require('plugins.autopairs')
require('plugins.indentline')
require('plugins.toggleterm')
require('plugins.luasnip')
require('plugins.blink')
require('plugins.telescope')
require('plugins.scrollbar')
