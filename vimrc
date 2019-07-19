""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug 配置，把vim-plug放到最前是为了使用各插件路径加到rtp，在配置前生效 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins will be downloaded under the specified directory.
call plug#begin('$MY_VIM_PATH/plugged')

" 通用插件, vim.org 上几乎所有插件都可以在 https://github.com/vim-scripts 找到
Plug 'Lokaltog/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'benjifisher/matchit.zip'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
Plug 'vim-scripts/winmanager'
Plug 'majutsushi/tagbar'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 通用配置 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:mapleader = "\<Space>"        " leader默认为\, 可以修改为, 现为空格
colorscheme gruvbox                 " 主题, 前提主题路径已添加到rtp
set bg=dark                         " gruvbox dark/light mode

" 通用按键映射
nnoremap <silent> yaf [m{jV]m%y     " 复制整个函数，适用于Java, PHP等

set relativenumber                              " 绝对行号    
set number                                      " 相对行号    
autocmd InsertEnter * :set norelativenumber     " 插入模式下撤下相对行号
autocmd InsertLeave * :set relativenumber       " 普通模式下加上相对行号
set tabstop=4	                                " 一个tab四个空格字符
set softtabstop=4                               " 编辑模式的时按退格退回缩进的长度
set shiftwidth=4                                " 每一级缩进的长度
set autoindent                                  " 自动缩进，与set paste冲突，不能共存
set expandtab	                                " 用空格来替换tab
set nocompatible                                " 不兼容vi
set t_Co=256                                    " 256色
set encoding=utf-8                              " utf-8编码
"set ruler                                       " 高亮当前行
let autosave=60                                 " 60s自动保存
set cursorcolumn                                " 高亮当前列
set cursorline                                  " 高亮当前行
set noswapfile                                  " 不生成.swp文件
set fillchars=vert:\                            " 窗口分隔默认为"|"，修改为空格，"\"后有空格 
"highlight VertSplit ctermbg=100 ctermfg=100     " 设置窗口分隔符颜色
"hi VertSplit ctermfg=244 ctermbg=232 cterm=bold
highlight VertSplit term=reverse ctermbg=242 guibg=Grey40   " 灰色


filetype plugin indent on                       " 根据文件类型加载插件、缩进
" autocmd FileType help,* wincmd L 导致nerdtree tagbar等窗口无法调整大小
"autocmd FileType help,* wincmd L                " 执行:help时，右侧另开窗口,默认上方

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" matchit 配置 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
runtime macros/matchit.vim                      " 激活 matchit
autocmd Filetype c                              " c 文件自定义跳转匹配
            \ let b:match_words = ''
            \ . ''

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gtags 配置 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cscopetag 			                        " 使用 cscope 作为 tags 命令
set cscopeprg='gtags-cscope' 	                " 使用 gtags-cscope 代替 cscope

let GtagsCscope_Auto_Load = 1
let CtagsCscope_Auto_Map = 1
let GtagsCscope_Quiet = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline 配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set langmenu=zh_CN.UTF-8
set laststatus=2                                        "永远显示状态栏
"let g:airline_theme="molokai" 
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1            " 顶部tab显示"
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline#extensions#tabline#fnamemod = ':t'        " tab只显示文件名


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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdtree 配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd vimenter * NERDTree                     " 自动开启Nerdtree
autocmd vimenter * if !argc()|NERDTree|endif    " 打开vim时如果没有文件自动打开NERDTree
"当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeWinSize = 25                      " 设定 NERDTree 视窗大小
let g:NERDTreeWinPos="left"                     " 窗口在左侧、右侧 right left
let NERDTreeMinimalUI = 1                       " 不显示 press ? for help 那一行
set autochdir                                   " nerdtree自动切换到当前buffer文件所在目录
"map <C-f> :NERDTreeToggle<CR>                  " 开启/关闭nerdtree快捷键
"let NERDTreeShowBookmarks=1                    " 开启Nerdtree时自动显示Bookmarks
let g:NERDTreeDirArrowExpandable = '▸'          " 设置树的显示图标
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeDirArrows = 1                       " 显示目录图标
let NERDTreeIgnore = ['\.pyc$']                 " 过滤所有.pyc文件不显示
"let g:NERDTreeShowLineNumbers=1                " 是否显示行号
"let g:NERDTreeHidden=0                         " 不显示隐藏文件
""Making it prettier


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tagbar 配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:Tagbar_title = "[Tagbar]"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" winmanager 配置, 在 nerdtree、tagbar 后面，部分变量需要被 winmanager 使用到
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:winManagerWindowLayout='NERDTree'      "设置界面分割 Bufexplorer放到后面           
"let g:winManagerWidth = 30                          "设置winmanager的宽度，默认为25     
"let g:AutoOpenWinManager = 1                        "在进入vim时自动打开winmanager      
"let g:persistentBehaviour = 0                       "所有文件关闭，只剩资源管理窗口时，退出vim

