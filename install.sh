#!/bin/bash

#backup old vimrc
cp $HOME/.vimrc $HOME/.vimrc.bak_$(date +"%Y_%m_%d")
#copy new vimrc over
cp vim/vimrc $HOME/.vimrc

#backup old zshrc
cp $HOME/.zshrc $HOME/.zshrc.back_$(date +"%Y_%m_%d")
#copy new zshrc over
cp zsh/zshrc $HOME/.zshrc

