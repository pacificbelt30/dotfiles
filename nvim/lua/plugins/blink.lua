-- 補完 (blink.cmp。旧 nvim-cmp / cmp.lua から移行)
-- キーバインドは旧 nvim-cmp 設定を極力踏襲している。

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

require('blink.cmp').setup({
  -- キーマップ (旧 nvim-cmp の挙動を維持)
  keymap = {
    preset = 'none',
    -- ドキュメントスクロール (旧 <C-b>/<C-f>)
    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    -- 手動補完 (旧 <C-Space> = cmp.mapping.complete)
    ['<C-Space>'] = { 'show', 'fallback' },
    -- 中断 (旧 <C-e> = cmp.mapping.abort)
    ['<C-e>'] = { 'hide', 'fallback' },
    -- 確定 (旧 <CR> = confirm({ select = true }))
    ['<CR>'] = { 'select_and_accept', 'fallback' },
    -- Tab: 表示中は次の候補へ / スニペットジャンプ / 直前に語があれば補完起動
    ['<Tab>'] = {
      function(cmp)
        if cmp.is_visible() then
          return cmp.select_next()
        end
      end,
      'snippet_forward',
      function(cmp)
        if has_words_before() then
          return cmp.show()
        end
      end,
      'fallback',
    },
    -- S-Tab: 表示中は前の候補へ / スニペットを戻る
    ['<S-Tab>'] = {
      function(cmp)
        if cmp.is_visible() then
          return cmp.select_prev()
        end
      end,
      'snippet_backward',
      'fallback',
    },
  },

  -- 旧 nvim-cmp は手動選択 + 確定時に先頭採用 (noselect 相当) だったので合わせる
  completion = {
    list = {
      selection = { preselect = false, auto_insert = false },
    },
    documentation = { auto_show = true },
  },

  -- スニペットは LuaSnip を使う (friendly-snippets は luasnip.lua で読み込み済み)
  snippets = { preset = 'luasnip' },

  -- 旧 cmp-nvim-lsp-signature-help 相当 (blink の組み込み)
  signature = { enabled = true },

  -- 補完ソース (旧 nvim_lsp / path / luasnip / buffer / latex_symbols)
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer', 'latex_symbols' },
    providers = {
      -- cmp-latex-symbols を blink.compat 経由で利用
      latex_symbols = {
        name = 'latex_symbols',
        module = 'blink.compat.source',
      },
    },
  },

  -- cmdline 補完は blink 組み込み (既定で `:`=cmdline/path, `/`,`?`=buffer)
  cmdline = { enabled = true },

  fuzzy = { implementation = 'prefer_rust_with_warning' },
})

-- LSP 設定
local capabilities = require('blink.cmp').get_lsp_capabilities()
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'pyright', 'texlab' },
})

for _, server in ipairs({ 'pyright', 'texlab', 'ts_ls' }) do
  vim.lsp.config(server, {
    capabilities = capabilities,
  })
end
vim.lsp.enable({ 'pyright', 'texlab', 'ts_ls' })
