-- luacheck 設定: Neovim の Lua 設定 (nvim/) を対象とする
-- 実行は luacheck nvim/ (リポジトリルートから) を想定。
std = "luajit"

-- Neovim が提供するグローバル。
-- read_globals にすると vim.g / vim.opt 等への代入が
-- 「setting read-only field」(122) として誤検出されるため writable globals にする。
globals = { "vim" }

-- 設定ファイル特有のノイズを抑制
ignore = {
  "212", -- unused argument (コールバックの fallback / args / ev など)
  "631", -- line is too long (lualine 等の設定テーブルで長くなる)
}

exclude_files = {
  ".git",
}
