-- スニペット (LuaSnip。ultisnips / vim-snippets から移行)
local ls = require('luasnip')

-- friendly-snippets (VSCode 形式) を読み込む
require('luasnip.loaders.from_vscode').lazy_load()

-- 自作スニペット (nvim/snippets/<filetype>.snippets は SnipMate 形式)
require('luasnip.loaders.from_snipmate').lazy_load({
  paths = { vim.fn.stdpath('config') .. '/snippets' },
})

-- スニペット内のジャンプ (補完選択中の <Tab> は nvim-cmp 側で処理)
vim.keymap.set({ 'i', 's' }, '<C-k>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<C-j>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })
