# dotfiles
linux設定ファイル置き場所
setup.shを実行するだけですべての設定が展開される予定

## instalation
以下のコマンドでgitからdotfilesを持ってくる
```bash
git clone --recursive https://github.com/pacificbelt30/dotfiles
```
or
```bash
git clone https://github.com/pacificbelt30/dotfiles
git submodule update -i
```
submoduleのコミットを変更する．(以下は動作確認をする予定のコミットID)
```bash
cd i3wm-setup
git checkout 7e2bac48f65b3fdbc427df2984d624c224b68231
cd -
```

dotfilesディレクトリ直下へ戻った後以下のコマンドを実行することでセットアップが開始される．
```bash
zsh setup.sh
```

## requirements or recommended
- fzf あいまい検索
- zsh シェル
- vim エディタ
- neovim エディタ
- i3-wm ウィンドウマネージャ
- rofi アプリケーションランチャ
- tmux 仮想端末
- xfce4-terminal or terminator ターミナルエミュレータ
- compton 透過ソフトウェア

## 
