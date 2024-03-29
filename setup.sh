#!/bin/zsh
# vim,i3その他諸々の設定を配置するシェルスクリプト

#Plugインストール
#cd ~/dotfiles
#chsh -s $(which zsh)
echo "vim-plugのインストール"
echo "Install vim-plug"
zsh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

#make directry
echo "設定ファイルを配置するディレクトリを作成"
echo "Create a directory to place the configuration files."
makedir () {
  if [ ! -e $HOME/$1 ]; then
    mkdir $HOME/$1
  fi
}
makedir .vim
makedir .config
makedir .config/picom
makedir .config/terminator
makedir .config/i3
makedir .config/i3status
makedir .config/rofi
makedir .config/dunst
makedir .config/xfce4
makedir .config/xfce4/terminal
makedir .config/nvim
makedir .config/nvim/colors
#makedir .config/nvim/plugins
#makedir .config/nvim/snippets

#$HOME 以下の設定ファイル
echo "設定ファイルのリンク貼り付け開始($HOME以下)"
echo "Start pasting the link to the configuration file (under $HOME)."
ln -snf `pwd`/vimrc $HOME/.vimrc
ln -snf `pwd`/co.vim $HOME/.vim/co.vim
ln -snf `pwd`/tmux.conf $HOME/.tmux.conf
#ln -snf `pwd`/p10k.zsh $HOME/.p10k.zsh
ln -snf `pwd`/latexmkrc $HOME/.latexmkrc
echo "リンク貼り付け終了($HOME以下)"
echo "End pasting the link to the configuration file (under $HOME)."

#$HOME/.config 以下の設定ファイル
echo "リンク貼り付け開始($HOME/.config/以下)"
echo "Start pasting the link to the configuration file (under $HOME/.config/)."
ln -snf `pwd`/nvim/init.vim $HOME/.config/nvim/init.vim
#ln -snf `pwd`/nvim/colors/gruvbox.vim $HOME/.config/nvim/colors/gruvbox.vim
#ln -snf `pwd`/nvim/colors $HOME/.config/nvim/colors
ln -snf `pwd`/nvim/plugins $HOME/.config/nvim/plugins
ln -snf `pwd`/nvim/snippets $HOME/.config/nvim/snippets
ln -snf `pwd`/nvim/ftplugin $HOME/.config/nvim/ftplugin
ln -snf `pwd`/nvim/rc $HOME/.config/nvim/rc
ln -snf `pwd`/rofi/config.rasi $HOME/.config/rofi/config.rasi
ln -snf `pwd`/rofi/rofi_system.sh $HOME/.config/rofi/rofi_system.sh
ln -snf `pwd`/i3/config $HOME/.config/i3/config
# ln -snf `pwd`/i3/config.endeavoros $HOME/.config/i3/config
# ln -snf `pwd`/i3/keybindings $HOME/.config/i3/keybindings
#ln -snf `pwd`/i3/wallpaper.jpg $HOME/.config/i3/wallpaper.jpg
ln -snf `pwd`/i3/i3blocks_up.conf $HOME/.config/i3/i3blocks_up.conf
ln -snf `pwd`/i3/i3blocks_bottom.conf $HOME/.config/i3/i3blocks_bottom.conf
ln -snf `pwd`/i3/wallpaper.jpg $HOME/Pictures/wallpaper.jpg
ln -snf `pwd`/i3/scripts $HOME/.config/i3/scripts
ln -snf `pwd`/i3status/config $HOME/.config/i3status/config
ln -snf `pwd`/terminator/config $HOME/.config/terminator/config
ln -snf `pwd`/picom/picom.conf $HOME/.config/picom/picom.conf
# ln -snf `pwd`/xfce4/terminal/terminalrc $HOME/.config/xfce4/terminal/terminalrc
# ln -snf `pwd`/xfce4/terminal/accels.scm $HOME/.config/xfce4/terminal/accels.scm
# ln -snf `pwd`/dunst/dunstrc $HOME/.config/dunst/dunstrc

#/i3wm-setup/.config から持ってくるやつ
#ln -snf `pwd`/i3wm-setup/.config/rofi/config.rasi $HOME/.config/rofi/config.rasi
#ln -snf `pwd`/i3wm-setup/.config/rofi/rofi_system.sh $HOME/.config/rofi/rofi_system.sh
#ln -snf `pwd`/i3wm-setup/.config/i3/i3blocks.conf $HOME/.config/i3/i3blocks.conf
ln -snf `pwd`/i3wm-setup/.config/i3/keybindings $HOME/.config/i3/keybindings
#ln -snf `pwd`/i3wm-setup/.config/i3/scripts $HOME/.config/i3/scripts
#ln -snf `pwd`/i3wm-setup/.config/picom.conf $HOME/.config/compton/picom.conf
ln -snf `pwd`/i3wm-setup/.config/xfce4/terminal/terminalrc $HOME/.config/xfce4/terminal/terminalrc
ln -snf `pwd`/i3wm-setup/.config/xfce4/terminal/accels.scm $HOME/.config/xfce4/terminal/accels.scm
ln -snf `pwd`/i3wm-setup/.config/dunst/dunstrc $HOME/.config/dunst/dunstrc
ln -snf `pwd`/starship.toml $HOME/.config/starship.toml
echo "リンク貼り付け終了($HOME/.config/以下)"
echo "End pasting the link to the configuration file (under $HOME/.config/)."


#zprezto
echo "preztoの設定"
echo "setup prezto"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
#prezto
# ln -snf `pwd`/prezto/runcoms/zlogin $HOME/.zprezto/runcoms/zlogin
# ln -snf `pwd`/prezto/runcoms/zlogout $HOME/.zprezto/runcoms/zlogout
# ln -snf `pwd`/prezto/runcoms/zpreztorc $HOME/.zprezto/runcoms/zpreztorc
# ln -snf `pwd`/prezto/runcoms/zprofile $HOME/.zprezto/runcoms/zprofile
# ln -snf `pwd`/prezto/runcoms/zshenv $HOME/.zprezto/runcoms/zshenv
# ln -snf `pwd`/prezto/runcoms/zshrc $HOME/.zprezto/runcoms/zshrc
ln -snf `pwd`/prezto/runcoms/myzshrc $HOME/.zprezto/runcoms/myzshrc

# myzshrcをzshrcで読み込むように追加
echo "source $HOME/.zprezto/runcoms/myzshrc" >> $HOME/.zprezto/runcoms/zshrc


