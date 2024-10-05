#/bin/sh

# Check for cargo 
echo "Downloading dependencies.."
set -x
sudo apt install cargo npm
set +x

# 1. Copy vimrc file
if [ -e ~/.vimrc ]; then
    echo "~/.vimrc file already exists, exiting."
    exit 1
else
    echo "1. Copying vimrc file."
    cp ./vimrc ~/.vimrc 
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

echo "Setup complete!"
