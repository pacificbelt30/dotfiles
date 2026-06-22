#!/bin/zsh
# dotfilesのセットアップスクリプト
# vim, i3, zsh, picom, rofi, terminator, latex, starship などの設定を配置し、
# 続けて Python(uv) / Node.js(nvm) のインストールスクリプトを実行する。

set -e
cd "$(dirname "$0")"

# ---- デスクトップ環境(i3/picom/rofi/terminator)の設定を適用するか選択 -------------
# 非対話実行時やCI等では DOTFILES_DESKTOP=yes/no で明示できる。
APPLY_DESKTOP="${DOTFILES_DESKTOP:-}"
if [ -z "$APPLY_DESKTOP" ]; then
  if [ -t 0 ]; then
    read "REPLY?デスクトップ環境(i3/picom/rofi/terminator)の設定を適用しますか? [y/N] "
    case "$REPLY" in
      [yY]*) APPLY_DESKTOP=yes ;;
      *) APPLY_DESKTOP=no ;;
    esac
  else
    APPLY_DESKTOP=no
  fi
fi

# ---- vim-plug -------------------------------------------------------------
echo "vim-plugのインストール"
echo "Install vim-plug"
zsh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# ---- ディレクトリ作成 -------------------------------------------------------
echo "設定ファイルを配置するディレクトリを作成"
echo "Create a directory to place the configuration files."
makedir () {
  if [ ! -e "$HOME/$1" ]; then
    mkdir -p "$HOME/$1"
  fi
}
makedir .vim
makedir .config
makedir .config/nvim
makedir .config/nvim/colors
if [ "$APPLY_DESKTOP" = yes ]; then
  makedir .config/picom
  makedir .config/terminator
  makedir .config/i3
  makedir .config/rofi
  makedir .config/dunst
  makedir .config/xfce4
  makedir .config/xfce4/terminal
fi

# ---- $HOME 直下の設定ファイル -------------------------------------------------
echo "設定ファイルのリンク貼り付け開始(\$HOME以下)"
echo "Start pasting the link to the configuration file (under \$HOME)."
ln -snf "$(pwd)"/vimrc $HOME/.vimrc
ln -snf "$(pwd)"/co.vim $HOME/.vim/co.vim
ln -snf "$(pwd)"/tmux/tmux.conf $HOME/.tmux.conf
ln -snf "$(pwd)"/latex/latexmkrc $HOME/.latexmkrc
ln -snf "$(pwd)"/shell/zsh/zshrc $HOME/.zshrc
echo "リンク貼り付け終了(\$HOME以下)"
echo "End pasting the link to the configuration file (under \$HOME)."

# ---- $HOME/.config 以下の設定ファイル ------------------------------------------
echo "リンク貼り付け開始(\$HOME/.config/以下)"
echo "Start pasting the link to the configuration file (under \$HOME/.config/)."
# 旧 vimscript 構成の残骸を掃除 (init.vim が残っていると init.lua と競合する)
rm -f "$HOME"/.config/nvim/init.vim "$HOME"/.config/nvim/plugins "$HOME"/.config/nvim/rc
ln -snf "$(pwd)"/nvim/init.lua $HOME/.config/nvim/init.lua
ln -snf "$(pwd)"/nvim/lua $HOME/.config/nvim/lua
ln -snf "$(pwd)"/nvim/snippets $HOME/.config/nvim/snippets
ln -snf "$(pwd)"/nvim/ftplugin $HOME/.config/nvim/ftplugin
ln -snf "$(pwd)"/starship.toml $HOME/.config/starship.toml

if [ "$APPLY_DESKTOP" = yes ]; then
  echo "デスクトップ環境(i3/picom/rofi/terminator)の設定も配置"
  ln -snf "$(pwd)"/desktop/rofi/config.rasi $HOME/.config/rofi/config.rasi
  ln -snf "$(pwd)"/desktop/rofi/rofi_system.sh $HOME/.config/rofi/rofi_system.sh
  ln -snf "$(pwd)"/desktop/i3/config $HOME/.config/i3/config
  ln -snf "$(pwd)"/desktop/i3/i3blocks_up.conf $HOME/.config/i3/i3blocks_up.conf
  ln -snf "$(pwd)"/desktop/i3/i3blocks_bottom.conf $HOME/.config/i3/i3blocks_bottom.conf
  makedir Pictures
  ln -snf "$(pwd)"/desktop/i3/wallpaper.jpg $HOME/Pictures/wallpaper.jpg
  ln -snf "$(pwd)"/desktop/i3/scripts $HOME/.config/i3/scripts
  ln -snf "$(pwd)"/desktop/terminator/config $HOME/.config/terminator/config
  ln -snf "$(pwd)"/desktop/picom/picom.conf $HOME/.config/picom/picom.conf

  # i3wm-setup submodule から持ってくるもの
  ln -snf "$(pwd)"/i3wm-setup/.config/i3/keybindings $HOME/.config/i3/keybindings
  ln -snf "$(pwd)"/i3wm-setup/.config/xfce4/terminal/terminalrc $HOME/.config/xfce4/terminal/terminalrc
  ln -snf "$(pwd)"/i3wm-setup/.config/xfce4/terminal/accels.scm $HOME/.config/xfce4/terminal/accels.scm
  ln -snf "$(pwd)"/i3wm-setup/.config/dunst/dunstrc $HOME/.config/dunst/dunstrc
else
  echo "デスクトップ環境の設定はスキップ(再度実行する場合は DOTFILES_DESKTOP=yes を指定)"
fi
echo "リンク貼り付け終了(\$HOME/.config/以下)"
echo "End pasting the link to the configuration file (under \$HOME/.config/)."

# ---- 言語ランタイムのインストール (Python: uv / Node.js: nvm) -----------------------
echo "Python(uv)のインストール"
./lang/python/install_uv.sh
echo "Node.js(nvm)のインストール"
./lang/node/install_nvm.sh

# ---- AI CLI (Claude Code, Codex) のインストール -----------------------------
echo "Claude Code / Codex CLIのインストール"
./tools/ai/install_ai_clis.sh

echo "セットアップ完了。シェルを再起動するか 'exec zsh' を実行してください。"
echo "Setup complete. Restart your shell or run 'exec zsh'."
