#!/bin/zsh
# dotfilesのセットアップスクリプト
# vim, i3, zsh, picom, rofi, terminator, latex, starship などの設定を配置し、
# 続けて Python(uv) / Node.js(nvm) のインストールスクリプトを実行する。

set -e
cd "$(dirname "$0")"

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
makedir .config/picom
makedir .config/terminator
makedir .config/i3
makedir .config/rofi
makedir .config/dunst
makedir .config/xfce4
makedir .config/xfce4/terminal
makedir .config/nvim
makedir .config/nvim/colors

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
ln -snf "$(pwd)"/nvim/init.vim $HOME/.config/nvim/init.vim
ln -snf "$(pwd)"/nvim/plugins $HOME/.config/nvim/plugins
ln -snf "$(pwd)"/nvim/snippets $HOME/.config/nvim/snippets
ln -snf "$(pwd)"/nvim/ftplugin $HOME/.config/nvim/ftplugin
ln -snf "$(pwd)"/nvim/rc $HOME/.config/nvim/rc
ln -snf "$(pwd)"/desktop/rofi/config.rasi $HOME/.config/rofi/config.rasi
ln -snf "$(pwd)"/desktop/rofi/rofi_system.sh $HOME/.config/rofi/rofi_system.sh
ln -snf "$(pwd)"/desktop/i3/config $HOME/.config/i3/config
ln -snf "$(pwd)"/desktop/i3/i3blocks_up.conf $HOME/.config/i3/i3blocks_up.conf
ln -snf "$(pwd)"/desktop/i3/i3blocks_bottom.conf $HOME/.config/i3/i3blocks_bottom.conf
ln -snf "$(pwd)"/desktop/i3/wallpaper.jpg $HOME/Pictures/wallpaper.jpg
ln -snf "$(pwd)"/desktop/i3/scripts $HOME/.config/i3/scripts
ln -snf "$(pwd)"/desktop/terminator/config $HOME/.config/terminator/config
ln -snf "$(pwd)"/desktop/picom/picom.conf $HOME/.config/picom/picom.conf
ln -snf "$(pwd)"/starship.toml $HOME/.config/starship.toml

# i3wm-setup submodule から持ってくるもの
ln -snf "$(pwd)"/i3wm-setup/.config/i3/keybindings $HOME/.config/i3/keybindings
ln -snf "$(pwd)"/i3wm-setup/.config/xfce4/terminal/terminalrc $HOME/.config/xfce4/terminal/terminalrc
ln -snf "$(pwd)"/i3wm-setup/.config/xfce4/terminal/accels.scm $HOME/.config/xfce4/terminal/accels.scm
ln -snf "$(pwd)"/i3wm-setup/.config/dunst/dunstrc $HOME/.config/dunst/dunstrc
echo "リンク貼り付け終了(\$HOME/.config/以下)"
echo "End pasting the link to the configuration file (under \$HOME/.config/)."

# ---- 言語ランタイムのインストール (Python: uv / Node.js: nvm) -----------------------
echo "Python(uv)のインストール"
./lang/python/install_uv.sh
echo "Node.js(nvm)のインストール"
./lang/node/install_nvm.sh

echo "セットアップ完了。シェルを再起動するか 'exec zsh' を実行してください。"
echo "Setup complete. Restart your shell or run 'exec zsh'."
