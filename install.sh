#!/bin/bash

TOP_DIR=`pwd`
VIM_DIR=$TOP_DIR/.vim

mkdir -p $VIM_DIR  && cd $VIM_DIR

# install vim-plug
curl -fLo autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install fonts-powerline for air-line
# sudo apt-get install fonts-powerline      # airline use unicode symbols, so we don't need to install fonts-powerline


#################################################################################################
# external software download install and config
#################################################################################################
EX_DOWNLOAD=$VIM_DIR/ex-download
EX_INSTALL=$VIM_DIR/ex-install
mkdir -p $EX_DOWNLOAD
mkdir -p $EX_INSTALL

cd $EX_DOWNLOAD
# install gnu global    address: https://ftp.gnu.org/pub/gnu/global/
# sudo apt-get install global               # debian/ubuntu
GLOBAL_VER=global-6.6.3
GLOBAL=$GLOBAL_VER.tar.gz                   # install lastest version
GLOBAL_URL=https://ftp.gnu.org/pub/gnu/global/$GLOBAL
wget -c $GLOBAL_URL
tar xf $GLOBAL
cd $GLOBAL_VER
./configure --prefix=$EX_INSTALL            # added --prefix=dir config install dir, changed install dir  
make && make install                        # need sudo or root by default, cause default install dir belong to root
# use vim-plug install ludovicchabant/vim-gutentags skywind3000/gutentags_plus so that we do not need to copy *.vim anymore
#cp gtags-cscope.vim,gtags.vim $VIM_DIR/plugin/

sudo apt-get install autoconf
# install universal ctags
cd $EX_DOWNLOAD
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh                                # depend on autoconf, must install before
./configure                                 # --prefix=/where/you/want # defaults to /usr/local
make                                        # compile
sudo make install                           # install universal ctags to /usr/local/,need sudo 

# install pygments, for gtags
pip install pygments

# install nodejs and npm, needed by vim coc.vim
sudo apt-get install curl python-software-properties
# version 12.x
# curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs

# lsp
npm i -g bash-language-server               # bash lsp, for ale/coc
