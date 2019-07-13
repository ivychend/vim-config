#!/bin/bash

mkdir .vim  && cd .vim

# install vim-plug
curl -fLo autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install fonts-powerline for air-line
# sudo apt-get install fonts-powerline      # airline use unicode symbols, so we don't need to install fonts-powerline
