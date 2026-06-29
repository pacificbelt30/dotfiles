# dotfiles

Linux環境の設定ファイル置き場。`install.sh` を実行するとすべての設定が展開される。

## 構成

```
.
├── install.sh             # セットアップの起点。シンボリックリンク配置と言語ランタイム導入を行う
├── shell/zsh/zshrc         # zshの設定 (~/.zshrc にリンク)。プロンプトはstarshipに一本化
├── starship.toml           # starshipの設定 (~/.config/starship.toml にリンク)
├── lang/
│   ├── python/
│   │   ├── install_uv.sh       # Python = uv で管理
│   │   └── pwn/                # pwn(CTF)用のuv仮想環境
│   │       ├── pyproject.toml  # pwntools, ptrlib などの依存定義
│   │       ├── uv.lock
│   │       └── setup_pwn_env.sh
│   └── node/install_nvm.sh     # Node.js = nvm で管理
├── tools/
│   ├── cli/install_cli_tools.sh    # ripgrep, eza, fd, bat, hexyl, binwalk, binutils, gdb, checksec
│   ├── rev/
│   │   ├── install_ghidra.sh       # Ghidra (逆コンパイラ)
│   │   └── install_pwndbg.sh       # pwndbg (gdbプラグイン)
│   └── sandbox/
│       ├── Dockerfile              # `sand` で使うサンドボックスイメージ
│       ├── sand.sh                 # build + run をまとめたラッパー
│       ├── install_docker.sh       # Docker Engine 導入 (Ubuntu 24.04)
│       └── install_codex_dock.sh   # codex-dock ビルド・導入 (Go自動導入付き)
├── tmux/tmux.conf
├── latex/latexmkrc
├── desktop/                 # X11デスクトップ周りの設定
│   ├── i3/
│   ├── picom/
│   ├── rofi/
│   └── terminator/
├── i3wm-setup/              # submodule (endeavouros-i3wm-setup)
├── vimrc, co.vim            # vim設定 (整理は後回し)
└── nvim/                    # neovim設定 (init.lua + lua/ 以下にLuaで記述)
```

## installation

以下のコマンドでgitからdotfilesを持ってくる。
```bash
git clone --recursive https://github.com/pacificbelt30/dotfiles
```
or
```bash
git clone https://github.com/pacificbelt30/dotfiles
git submodule update -i
```

dotfilesディレクトリ直下で以下を実行するとセットアップが開始される。
```bash
zsh install.sh
```

`install.sh` は以下を行う。
1. vim-plugの導入
2. 各設定ファイルを `$HOME` 以下にシンボリックリンクとして配置
3. `lang/python/install_uv.sh` で uv（Pythonのインストール・バージョン管理）を導入
4. `lang/node/install_nvm.sh` で nvm（Node.jsのインストール・バージョン管理）を導入

言語ランタイムだけ個別に導入・更新したい場合はそれぞれのスクリプトを直接実行する。
```bash
./lang/python/install_uv.sh
./lang/node/install_nvm.sh
```

## pwn (CTF) 用Python環境

`lang/python/pwn/` に pwntools / ptrlib などpwn用ライブラリを定義した uv プロジェクトを用意している。
ほかのプロジェクトと依存関係を混ぜないよう専用の仮想環境として配置する。

```bash
./lang/python/pwn/setup_pwn_env.sh
source lang/python/pwn/.venv/bin/activate
```

ライブラリを追加・更新したい場合は `lang/python/pwn/pyproject.toml` を編集して
`uv lock && uv sync`（`lang/python/pwn/` 内で実行）する。

含まれるライブラリ: pwntools, ptrlib, ropper, capstone, unicorn, z3-solver, pycryptodome, requests

## rev (リバースエンジニアリング) 用ツール

```bash
./tools/cli/install_cli_tools.sh   # ripgrep, eza, fd, bat, hexyl, binwalk, binutils, gdb, checksec
./tools/rev/install_ghidra.sh      # Ghidra本体 (~/.local/share/ghidra, JDK 21+が必要)
./tools/rev/install_pwndbg.sh      # pwndbg (gdb起動時に自動ロードされる)
```

- `install_cli_tools.sh` はpacman/aptを検出してパッケージを導入し、Debian/Ubuntuで
  `fd`/`bat` が `fdfind`/`batcat` という名前になる問題は `~/.local/bin` にシンボリックリンクして解消する。
  `checksec` はディストリ間で差異が出ないよう単体スクリプトとして導入する。
- `install_ghidra.sh` はGitHubの最新リリースを取得して展開し、`ghidra` コマンドとして使えるようにする。
- `install_pwndbg.sh` は `~/.gdbinit` にpwndbgを登録し、gdb起動時に自動で読み込まれるようにする。

これらは `install.sh` からは呼ばれない（重い・sudoが必要なため）。必要なときに個別に実行する。

## sandbox（`sand` コマンド）

カレントディレクトリを `/work` としてマウントしたDockerコンテナに入るための `sand` コマンドを用意している
（`shell/zsh/zshrc` で定義、実体は `tools/sandbox/sand.sh` + `tools/sandbox/Dockerfile`）。

```bash
cd ~/ctf/some_challenge
sand            # イメージをbuildし（初回のみ時間がかかる）、コンテナ内でzshに入る
sand gdb ./chal # ワンショットでコマンドを実行することも可能
```

コンテナにはホストの `shell/zsh/zshrc` / `starship.toml` と pwn(CTF)用venv、pwndbg、
ripgrep/eza/fd/bat/hexyl/binwalk/binutils/gdb/checksec を含む。GUIが必要なGhidraはコンテナには含めていない
（ホスト側で `tools/rev/install_ghidra.sh` を使う）。
リポジトリを `~/dotfiles` 以外に置いている場合は `DOTFILES_DIR` を上書きする。

## Docker + codex-dock（AI サンドボックス）

Ubuntu 24.04（WSL2 / VM）向けに Docker Engine と
[codex-dock](https://github.com/pacificbelt30/sandbox-codex)
（AI コーディングエージェントを隔離コンテナで実行するマネージャ）を導入できる。

```bash
# Docker Engine のインストール
./tools/sandbox/install_docker.sh

# codex-dock のビルド・インストール（Go も自動導入）
./tools/sandbox/install_codex_dock.sh
```

`install.sh` の実行時にも `DOTFILES_DOCKER=yes` で一括導入できる。

```bash
DOTFILES_DOCKER=yes zsh install.sh
```

インストール後の初期セットアップ:

```bash
codex-dock network create
codex-dock proxy build && codex-dock proxy run
export OPENAI_API_KEY=sk-... && export ANTHROPIC_API_KEY=sk-ant-...
codex-dock auth set
codex-dock build
codex-dock run --agent claude --approval-mode full-auto
```

## shell

シェルは zsh。フレームワーク (prezto等) は使わず、`shell/zsh/zshrc` 単体で完結させている。
プロンプトは [starship](https://starship.rs/) のみを使用し、powerlevel10kなど他のプロンプト実装は導入しない。
マシン固有の設定は `~/.zshrc.local`（gitには置かない）に書くと `zshrc` の最後で自動的に読み込まれる。

## neovim

設定は Lua で記述している（`nvim/init.lua` + `nvim/lua/` 以下）。プラグイン管理は vim-plug。

設定ファイルの静的チェック（構文チェック + luacheck）:

```bash
./nvim/tests/check.sh
```

nvim 本体やプラグインのインストールは不要。`luac`（lua5.x）と `luacheck` があれば実行でき、
無いものは自動でスキップする。push / PR 時には `.github/workflows/nvim-lua-lint.yml` が
同じチェックを CI で実行する。

## requirements or recommended

- zsh シェル
- [starship](https://starship.rs/) rust製プロンプト
- [uv](https://docs.astral.sh/uv/) Pythonのインストール・パッケージ管理 (`lang/python/install_uv.sh`)
- [nvm](https://github.com/nvm-sh/nvm) Node.jsのバージョン管理 (`lang/node/install_nvm.sh`)
- fzf あいまい検索
- [eza](https://github.com/eza-community/eza) `ls` の代替 (`tools/cli/install_cli_tools.sh`、旧exaから移行)
- ripgrep, fd, bat, hexyl, binwalk, binutils, gdb, checksec (`tools/cli/install_cli_tools.sh`)
- [Ghidra](https://ghidra-sre.org/) / [pwndbg](https://github.com/pwndbg/pwndbg) (`tools/rev/`)
- Docker (`sand` コマンドおよび codex-dock で必要。`tools/sandbox/install_docker.sh`)
- [codex-dock](https://github.com/pacificbelt30/sandbox-codex) AIエージェントの隔離実行 (`tools/sandbox/install_codex_dock.sh`)
- vim / neovim エディタ
- i3-wm (i3-gaps) ウィンドウマネージャ
- i3-blocks ステータスバー
- rofi アプリケーションランチャ
- tmux 仮想端末
- xfce4-terminal or terminator ターミナルエミュレータ
- picom (compton) 透過ソフトウェア
