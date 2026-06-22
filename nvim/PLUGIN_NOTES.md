# neovim プラグイン動作確認メモ

`nvim/lua/plugins/init.lua` に記載の全プラグインについて、ヘッドレス neovim
でクローン・読み込みを確認した記録。当初は代替が必要なプラグインを記録のみ
していたが、現在は対応済み（下記参照）。

## プラグインマネージャ

vim-plug から **lazy.nvim** へ移行済み。`nvim/lua/plugins/init.lua` が
未導入時に lazy.nvim を自動 clone し、宣言したプラグインを管理する。
各プラグインの設定本体は `nvim/lua/plugins/*.lua`（`nvim/init.lua` から
require）に置いている。

## 確認方法

```sh
export NVIM=/path/to/nvim
export TESTHOME=/tmp/nvimtest_home
HOME="$TESTHOME" XDG_CONFIG_HOME="$TESTHOME/.config" XDG_DATA_HOME="$TESTHOME/.local/share" \
  "$NVIM" --headless "+Lazy! sync" +qa
```

その後、プラグイン導入済みの状態で再度起動し、エラー出力（`:messages` /
stderr）を確認。

## 対応済みの項目

### 1. `p00f/nvim-ts-rainbow`（メンテナンス終了）→ 対応済み

- 症状: `module 'nvim-treesitter.query' not found` でエラー。
- 原因: リポジトリ自身が 2023-01 で開発終了。現行 `nvim-treesitter` と
  互換性が無くなっていた。
- 対応: **`HiPhish/rainbow-delimiters.nvim`** へ移行
  （`lua/plugins/init.lua` / `lua/plugins/treesitter.lua`）。

### 2. `nvim-treesitter/nvim-treesitter` の設定方法が現行版と不一致 → 対応済み

- 症状: `module 'nvim-treesitter.configs' not found` エラー。
- 原因: ブランチ指定が無いと `main`（Neovim 0.12+ 向けの刷新版で旧 `.configs`
  API を撤廃）を取得してしまう。
- 対応: lazy.nvim の宣言で **`branch = 'master'`** に固定し、既存の
  `.configs` ベースの設定をそのまま使えるようにした
  （`lua/plugins/init.lua`）。`rainbow` モジュール設定は廃止し、
  `rainbow-delimiters.nvim` に置き換え済み（`lua/plugins/treesitter.lua`）。

### 3. `Shougo/denite.nvim`（事実上メンテナンス終了）→ 対応済み

- 注意点: 最終実質コミットは 2024-03。作者本人が後継として
  `Shougo/ddu.vim` を案内していた。
- 対応: **`ibhagwan/fzf-lua`** へ移行し、`fzf.vim` ともども役割を統合
  （`lua/plugins/fzf.lua`）。`denite`/`fzf`/`fzf.vim` は宣言から削除。

### 4. スニペットエンジン `SirVer/ultisnips` → 対応済み

- 対応: **`L3MON4D3/LuaSnip`** + `saadparwaiz1/cmp_luasnip` +
  `rafamadriz/friendly-snippets` へ移行。`ultisnips` /
  `cmp-nvim-ultisnips` / `honza/vim-snippets` は削除。
  自作スニペット（`nvim/snippets/*.snippets`、SnipMate 形式）は
  `luasnip.loaders.from_snipmate` で読み込む（`lua/plugins/luasnip.lua`）。
  cmp 側の snippet engine / source / Tab マッピングも luasnip に変更済み
  （`lua/plugins/cmp.lua`）。

### 5. `nvim-lspconfig` の `tsserver` 指定 → 対応済み

- 原因: `nvim-lspconfig` 側で `tsserver` が `ts_ls` に改名された。
- 対応: `lua/plugins/cmp.lua` で `tsserver` → `ts_ls` に置き換え済み。

## 補足

- `nvim/snippets/tex.snip` は neosnippet 形式のため LuaSnip では読み込まれない
  （`.snippets`（SnipMate 形式）のみ対象）。必要なら SnipMate 形式へ変換する。
