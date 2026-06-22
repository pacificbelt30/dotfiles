# neovim プラグイン動作確認メモ

`nvim/lua/plugins/init.lua`（旧 `nvim/rc/plug.rc.vim`）に記載の全プラグインについて、ヘッドレス neovim
(`nvim --headless +PlugInstall +qa`、ホームディレクトリを隔離した状態) で
クローン・読み込みを確認した。

このファイルは確認結果と代替候補の記録のみが目的。
**plug.rc.vim や各プラグインのrcファイル自体への代替プラグインの差し替えは行っていない。**
（ローカルパス参照のバグ修正 `easyCO.vim` / `exasterisk.vim` のみ別途修正済み）

## 確認方法

```sh
export NVIM=/path/to/nvim
export TESTHOME=/tmp/nvimtest_home
HOME="$TESTHOME" XDG_CONFIG_HOME="$TESTHOME/.config" XDG_DATA_HOME="$TESTHOME/.local/share" \
  "$NVIM" --headless +PlugInstall +qa
```

その後、プラグイン導入済みの状態で再度起動し、エラー出力（`:messages` /
stderr）を確認。

## 結果: 問題なし

記載されている約60個のプラグインのうち、以下を除く全てが正常にクローン・
読み込みできた（エラーなし）。
vim-operator-user/replace, vim-textobj-user, nvim-autopairs,
context_filetype.vim, vim-airline 系, lualine.nvim, nvim-web-devicons,
vim-devicons, vim-fugitive, vim-gitgutter, nvim-lspconfig, mason.nvim,
mason-lspconfig.nvim, nvim-cmp 系一式, cmp-latex-symbols, ultisnips,
cmp-nvim-ultisnips, vista.vim, nvim-treesitter-context, nvim_context_vt,
hlargs.nvim, vim-easymotion, vimdoc-ja, vim-repeat, goyo.vim, winresizer,
vimhelpgenerator, vim-snippets, plenary.nvim, telescope.nvim, fzf,
fzf.vim, undotree, nvim-scrollbar, vim-smoothie, indentLine,
vim-cursorword, readablefold.vim, nvim-notify, toggleterm.nvim, および
全7種のカラースキーム。

## 問題が見つかったプラグイン

### 1. `p00f/nvim-ts-rainbow` — 動作しない（メンテナンス終了）

- 症状: `nvim/plugins/tree-sitter.rc.vim` 読み込み時に
  `module 'nvim-treesitter.query' not found` でエラー。
- 原因: リポジトリ自身の README に
  "NO LONGER MAINTAINED / archiving the GitHub repo" と明記されており、
  2023-01 で開発終了。依存している `nvim-treesitter` 側のモジュール構成が
  その後大きく変わり、互換性が無くなっている。
- 代替候補:
  - **`HiPhish/rainbow-delimiters.nvim`**（最有力。現行 nvim-treesitter と
    互換性があり、後継として広く使われている）
  - Neovim 0.10+ の組み込み機能だけで完結させ、rainbow括弧自体を諦める
    という選択肢もある。

### 2. `nvim-treesitter/nvim-treesitter` の設定方法が現行版と不一致

- 症状: `nvim/plugins/tree-sitter.rc.vim` の
  `require'nvim-treesitter.configs'.setup{...}` の行で
  `module 'nvim-treesitter.configs' not found` エラー。
- 原因: `Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}` は
  ブランチ指定がないため `main` ブランチを取得する。`main` は
  Neovim 0.12+ 向けに大幅刷新された版で、旧来の `.configs`/`.query`
  モジュール一式（highlight/rainbow等のモジュール式設定）を撤廃している。
  プラグイン自体（パーサ管理・`:TSUpdate`）は動作するが、現状の
  `tree-sitter.rc.vim` の書き方は新APIと噛み合っていない。
- 対応候補（プラグイン差し替えではなく、同プラグインの設定/取得方法の選択）:
  - **(a)** 旧API互換ブランチを使う:
    `Plug 'nvim-treesitter/nvim-treesitter', {'branch': '0.5-compat', 'do': ':TSUpdate'}`
    → 既存の `tree-sitter.rc.vim` をそのまま使い続けられる。
  - **(b)** 新APIに書き換える:
    highlight は `vim.treesitter.start()` を `FileType` autocmd で呼ぶ方式に
    変更（`README` の `## Highlighting` 節を参照）。rainbow設定は
    `nvim-ts-rainbow` 自体が(1)の理由で動かないため、(a)と合わせて
    `rainbow-delimiters.nvim` 等への移行が前提になる。

### 3. `Shougo/denite.nvim` — 動作はするが事実上メンテナンス終了

- 症状: エラーは出ない。`:UpdateRemotePlugins` も pynvim 経由で正常に
  remote plugin 登録できる（`python3 host registered plugins ['denite']`）。
- 注意点: 本体の最終実質コミットは 2024-03 (`Remove CI`) で、それ以降の
  更新がない。リポジトリの README 内で作者本人が後継として
  `Shougo/ddu.vim` を案内している。
- 代替候補:
  - **`Shougo/ddu.vim`**（作者公式の後継。ただし `ddu-ui-ff` /
    `ddu-source-file_rec` / `ddu-filter-matcher_substring` など
    周辺プラグインを別途組み合わせる必要があり、単純な1対1の
    差し替えにはならない）
  - 既にリストにある `nvim-telescope/telescope.nvim` で機能的に代替可能
    （ファジーファインダー用途が重複しているため、追加導入なしで移行できる）

### 4. `nvim-lspconfig` の `tsserver` 指定（プラグインではなく設定値）【対応済み】

- 症状: 旧 `nvim-cmp.lua` 内の
  `require('lspconfig')['tsserver'].setup{...}` で
  `tsserver is deprecated, use ts_ls instead` という警告が出ていた
  （エラーではないため起動は継続する）。
- 原因: `nvim-lspconfig` 側で `tsserver` という設定名が `ts_ls` に
  改名されている。
- 対応: Lua移行に伴い `lua/plugins/cmp.lua` で `tsserver` → `ts_ls` に
  置き換え済み（プラグイン差し替えではなく設定名の追従のみ）。

## まとめ

- 即座に動かないのは `nvim-ts-rainbow` のみ。代替: `rainbow-delimiters.nvim`。
- それに付随して `lua/plugins/treesitter.lua` の設定もどのみち更新が必要
  （ブランチ固定 or 新API移行）。
- `denite.nvim` はまだ動くが将来性は無く、移行するなら `ddu.vim` か
  既存の `telescope.nvim` に役割を統合するのが現実的。
- `tsserver`→`ts_ls` は単純な設定値の追従で済む軽微な対応（対応済み）。

注: 設定は全面的に Lua へ移行済み（`init.vim` ＋ `rc/`・`plugins/` の
vimscript 一式 → `init.lua` ＋ `lua/` 以下）。上記のうちプラグイン差し替えを
伴う項目（`nvim-ts-rainbow` / treesitter 新API / `denite.nvim`）は、
「使用プラグイン自体は変更しない」方針に従い未対応のまま記録のみ。
採用するかどうかはユーザー側で判断のこと。
