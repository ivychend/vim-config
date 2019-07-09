#!/bin/bash

cd ../          # will be delete

# install vim-plug
curl -fLo .vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
