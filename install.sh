#!/bin/sh


echo "Downloading basic dependencies.."

set -x

sudo apt install xorg xinit stterm suckless-tools build-essential libx11-dev libxinerama-dev libxft-dev make gcc git clangd vim cargo npm

mkdir -p "$HOME/.config"

# Setup git parameters
git config --global core.editor "vim"

# Setup vimrc
git clone https://github.com/emilio-gambino/vimrc.git

# 1. Copy vimrc file
if [ -e ~/.vimrc ]; then
    echo "~/.vimrc file already exists, exiting."
    exit 1
else
    echo "1. Copying vimrc file."
    cp ./vimrc/vimrc ~/.vimrc 
fi

# 2. Setup colorscheme
mkdir -p ~/.vim/colors
echo "2. Downloading colorscheme.."
curl -s -o ~/.vim/colors/toast.vim https://raw.githubusercontent.com/jsit/toast.vim/master/colors/toast.vim 

# 3. Download plugin manager
echo "3. Downloading vim-plug.."
curl -sfLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && echo 

# 4. Install plugins
echo "4. Installing plugins.."
vim +PlugInstall +qall 

# 5. Python codestyle
mv vimrc/pycodestyle ~/.config

echo "Vim Setup complete!"

# Setting up bashrc, xinitrc, bash_profile
mv vimrc/bashrc ~/.bashrc
mv vimrc/xinitrc ~/.xinitrc
rm -rf ./vimrc
touch "$HOME/.bash_profile"
echo "startx" >> "$HOME/.bash_profile"

echo "Downloading st and dwm.."

git clone https://github.com/emilio-gambino/dwm.git "$HOME/.config/dwm"
(
 cd "$HOME/.config/dwm" 
 sudo make clean install
)

git clone https://github.com/emilio-gambino/st.git "$HOME/.config/st"
(
 cd "$HOME/.config/st" 
 sudo make clean install
)

echo "Installing brave browser"

curl -fsS https://dl.brave.com/install.sh | sh

echo "Finished install!"
echo "You can reboot with \`sudo reboot\`"
set +x

# TODO install Language servers, ex bash, python, vimscript...
