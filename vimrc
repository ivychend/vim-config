""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug 配置，把vim-plug放到最前是为了使用各插件路径加到rtp 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins will be downloaded under the specified directory.
call plug#begin('$MY_VIM_PATH/plugged')

" 通用插件 
Plug 'Lokaltog/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 通用配置 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:mapleader = "\<Space>"        " leader默认为\, 可以修改为, 现为空格
colorscheme gruvbox                 " 主题, 前提主题路径已添加到rtp
set bg=dark                         " gruvbox dark/light mode

" 通用按键映射
nnoremap <silent> yaf [m{jV]m%y     " 复制整个函数，适用于Java, PHP等

set number	                " 显示行号
set tabstop=4	            " 一个tab四个空格字符
set softtabstop=4           " 编辑模式的时按退格退回缩进的长度
set shiftwidth=4            " 每一级缩进的长度
set autoindent              " 自动缩进，与set paste冲突，不能共存
set expandtab	            " 用空格来替换tab
set nocompatible            " 不兼容vi
set t_Co=256                " 256色
set encoding=utf-8          " utf-8编码

filetype plugin indent on           " 根据文件类型加载插件、缩进
autocmd FileType help,* wincmd L    " 执行:help时，右侧另开窗口,默认上方


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" matchit 配置 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
runtime macros/matchit.vim              " 激活 matchit
autocmd Filetype c 
	\ let b:match_words = ''

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gtags 配置 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cscopetag 			            " 使用 cscope 作为 tags 命令
set cscopeprg='gtags-cscope' 	    " 使用 gtags-cscope 代替 cscope

let GtagsCscope_Auto_Load = 1
let CtagsCscope_Auto_Map = 1
let GtagsCscope_Quiet = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline 配置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set langmenu=zh_CN.UTF-8
set laststatus=2                                        "永远显示状态栏
"let g:airline_theme="molokai" 
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1            " 顶部tab显示"
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 2

let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = '⮂'
let g:airline#extensions#tabline#right_alt_sep = ''

let g:airline_skip_empty_sections = 1
let g:Powerline_sybols = 'unicode'

if !exists('g:airline_symbols') 
  let g:airline_symbols = {}                                                              
endif                                                                           
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = '⮂'
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty=''

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdtree 配置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

