# this file maybe renamed to vim.ew for vim_ew, ew means everywhere
# you can source vim_ew where .vim cantain to make vimrc and vim add-on effect

export MY_VIM_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export MYVIMRC=$MY_VIM_PATH/vimrc		
export VIMINIT="let &rtp='$MY_VIM_PATH,' . &rtp
so $MYVIMRC"					

