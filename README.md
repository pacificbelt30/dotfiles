# dotfiles

Linux環境の設定ファイル置き場。`install.sh` を実行するとすべての設定が展開される。

## 構成

```
.
├── install.sh             # セットアップの起点。シンボリックリンク配置と言語ランタイム導入を行う
├── shell/zsh/zshrc         # zshの設定 (~/.zshrc にリンク)。プロンプトはstarshipに一本化
├── starship.toml           # starshipの設定 (~/.config/starship.toml にリンク)
├── lang/
│   ├── python/install_uv.sh    # Python = uv で管理
│   └── node/install_nvm.sh     # Node.js = nvm で管理
├── tmux/tmux.conf
├── latex/latexmkrc
├── desktop/                 # X11デスクトップ周りの設定
│   ├── i3/
│   ├── picom/
│   ├── rofi/
│   └── terminator/
├── i3wm-setup/              # submodule (endeavouros-i3wm-setup)
├── vimrc, co.vim            # vim設定 (整理は後回し)
└── nvim/                    # neovim設定 (整理は後回し)
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

## shell

シェルは zsh。フレームワーク (prezto等) は使わず、`shell/zsh/zshrc` 単体で完結させている。
プロンプトは [starship](https://starship.rs/) のみを使用し、powerlevel10kなど他のプロンプト実装は導入しない。
マシン固有の設定は `~/.zshrc.local`（gitには置かない）に書くと `zshrc` の最後で自動的に読み込まれる。

## requirements or recommended

- zsh シェル
- [starship](https://starship.rs/) rust製プロンプト
- [uv](https://docs.astral.sh/uv/) Pythonのインストール・パッケージ管理 (`lang/python/install_uv.sh`)
- [nvm](https://github.com/nvm-sh/nvm) Node.jsのバージョン管理 (`lang/node/install_nvm.sh`)
- fzf あいまい検索
- vim / neovim エディタ
- i3-wm (i3-gaps) ウィンドウマネージャ
- i3-blocks ステータスバー
- rofi アプリケーションランチャ
- tmux 仮想端末
- xfce4-terminal or terminator ターミナルエミュレータ
- picom (compton) 透過ソフトウェア
