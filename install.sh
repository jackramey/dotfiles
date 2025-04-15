#!/bin/bash
git stash
git rebase master
git stash pop

#backup old vimrc
echo "Creating backup of .vimrc"
cp $HOME/.vimrc $HOME/.vimrc.bak_$(date +"%Y_%m_%d")
#copy new vimrc over
echo "Copying new .vimrc to $HOME/"
cp vim/vimrc $HOME/.vimrc

#backup old zshrc
echo "Creating backup of .zshrc"
cp $HOME/.zshrc $HOME/.zshrc.bak_$(date +"%Y_%m_%d")
#copy new zshrc over
echo "Copying new .zshrc to $HOME/"
cp zsh/zshrc $HOME/.zshrc

