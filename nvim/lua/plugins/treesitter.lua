-- nvim-treesitter (旧 plugins/tree-sitter.rc.vim)
-- master ブランチ固定のため .configs の旧 API がそのまま使える。
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
    disable = {
      'lua',
      'ruby',
      'toml',
      'c_sharp',
      'vue',
    },
  },
})
require('hlargs').setup()

-- rainbow括弧 (メンテ終了した nvim-ts-rainbow の後継)
-- インストールするだけで自動的に有効化されるが、明示的に setup しておく。
require('rainbow-delimiters.setup').setup({})
