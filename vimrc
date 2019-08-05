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
Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'liuchengxu/vim-which-key'
"Plug 'yszou/vimim-wubi'                         " vim内置五笔输入法

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 通用配置 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:mapleader = "\<Space>"                    " leader默认为\, 可以修改为, 现为空格

" 通用按键映射
nnoremap <silent> yaf [m{jV]m%y                 " 复制整个函数，适用于Java, PHP等
nnoremap <silent> <tab> :bnext<CR>              " 设置切换buffer快捷键为tab，shift + tab
nnoremap <silent> <s-tab> :bprevious<CR> 


set nocompatible                                " 不兼容vi
set noswapfile                                  " 不生成.swp文件

" 颜色、主题
colorscheme gruvbox                             " 主题, 前提主题路径已添加到rtp
set bg=dark                                     " gruvbox dark/light mode
set t_Co=256                                    " 256色

" 行号
set relativenumber                              " 绝对行号    
set number                                      " 相对行号    
autocmd InsertEnter * :set norelativenumber     " 插入模式下撤下相对行号
autocmd InsertLeave * :set relativenumber       " 普通模式下加上相对行号

" 缩进、tab、换行、paste
set tabstop=4	                                " 一个tab四个空格字符
set softtabstop=4                               " 编辑模式的时按退格退回缩进的长度
set expandtab	                                " 用空格来替换tab
set shiftwidth=4                                " 每一级缩进的长度
set textwidth=150                               " 设置150自动换行,150已经接近nerdtree窗口了
set autoindent                                  " 自动缩进，与set paste冲突，不能共存
"set paste                                       " vim粘贴外部内容时，autoindent会修改缩进，此时需要使用
set smartindent                                 " 智能缩进

" 编码、格式
set encoding=utf-8                              " utf-8编码,缓冲的文本(你正在编辑的文件)，寄存器，Vim 脚本文件
"set termencoding=utf-8                          " 输出到客户终端（Term）采用的编码类型，默认为空，就是不进行编码转换
set fileencoding=utf-8                          " vim写入文件时采用的编码类型
"set fileformats=unix,dos                        " vim可以显示的格式，默认是unix、dos，添加dos后^M将不会显示
set fileformats=unix                            " dos格式文件会显示^M
set fileformat=unix                             

" 光标、鼠标
"set ruler                                       " 高亮当前行
set cursorcolumn cursorline                     " 高亮当前列/行
set mouse=a                                     " 所有模式下鼠标生效
"set mouse-=a                                   " 关闭鼠标，鼠标可以配置在指定模式下生效或者多种模式生效

" 搜索
set incsearch                                   " 实时搜索，根据当前输入字符串实时匹配
set hlsearch                                    " 高亮搜索结果，输入:nohlsearch(noh)取消，也可以:set nohlsearch

" UI
set laststatus=2                                "永远显示状态栏
set fillchars=vert:\                            " 窗口分隔默认为"|"，修改为空格，"\"后有空格 
"highlight VertSplit ctermbg=100 ctermfg=100     " 设置窗口分隔符颜色
"hi VertSplit ctermfg=244 ctermbg=232 cterm=bold
highlight VertSplit term=reverse ctermbg=242 guibg=Grey40   " 灰色

" 自动化
let autosave=60                                 " 60s自动保存
set autoread                                    " Automatically read a file changed outside of vim                        

" 折叠
set foldmethod=marker                           " 开启折叠，并保存折叠信息

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
" vim-Gutentags 提供了后台无缝更新 gtags 数据库的功能，而 gutentags_plus 提供了无缝切换 gtags 数据库的功能
" pip install pygments，用来支持其他语言
"
" 快捷键
" <leader>cs    Find symbol (reference) under cursor
" <leader>cg    Find symbol definition under cursor
" <leader>cd    Functions called by this function
" <leader>cc    Functions calling this function
" <leader>ct    Find text string under cursor
" <leader>ce    Find egrep pattern under cursor
" <leader>cf    Find file name under cursor
" <leader>ci    Find files #including the file name under cursor
" <leader>ca    Find places where current symbol is assigned
"
" You can disable the default keymaps by:
"
" let g:gutentags_plus_nomap = 1
" and define your new maps like:
"
" noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
" noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
" noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
" noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
" noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
" noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
" noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
" noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
" noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let $GTAGSLABEL = 'native-pygments'             " pygments支持gtags原生支持语言外的语言，修改为'native'禁用pygments

" gutentags_add_default_project_roots设置为0，取消gutentags_project_root默认值
let g:gutentags_add_default_project_roots = 0

" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
"let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project', 'kernel', 'u\-boot']
let g:gutentags_project_root = ['.root', '.svn', '.hg', '.project', 'kernel', 'u\-boot']

" gutentags_exclude_project_root无效，后期测试
let g:gutentags_exclude_project_root = ['*android*', '*linux*', '/home/rpdzkj_debug/first/ivy/nano-rk3399-lpddr4-android8.1/']

" 所生成的数据文件的名称，不添加默认生成tags，必须要有tags文件无法使用ctrl + ]跳转
let g:gutentags_ctags_tagfile = '.tags'

" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif

" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let g:gutentags_cache_dir = expand('$MY_VIM_PATH/.cache/tags')

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 如果使用 universal ctags 需要增加下面一行，如果不是universal ctags不要添加，添加后报错：gutentags: ctags job failed, returned: 1
"let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0

" 解决 gutentags: ctags job failed, returned: 1
let g:gutentags_define_advanced_commands = 1
" 需要查看更多的信息时将下面打开，打开的vim中执行messages，显示gtags的信息
"let g:gutentags_trace = 1

set cscopetag 			                                " 使用 cscope 作为 tags 命令
set cscopeprg='gtags-cscope' 	                        " 使用 gtags-cscope 代替 cscope，如果不在PATH，需要完整路径
"let GtagsCscope_Auto_Load = 1
"let CtagsCscope_Auto_Map = 1
"let GtagsCscope_Quiet = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline 配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set langmenu=zh_CN.UTF-8
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

let g:NERDTreeStatusline="nerdtree"             " nerdtree窗口statusline显示为nerdtree
let g:airline#extensions#gutentags#enabled = 1 

" 添加vim窗口序号，但是tagbar不生效
function! WindowNumber(...)
    let builder = a:1
    let context = a:2
    call builder.add_section('airline_b', '%{tabpagewinnr(tabpagenr())}')
    return 0
endfunction

call airline#add_statusline_func('WindowNumber')
call airline#add_inactive_statusline_func('WindowNumber')
" added end

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdtree 配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinSize = 30                      " 设定 NERDTree 视窗大小
let g:NERDTreeWinPos="right"                     " 窗口在左侧、右侧 right left
let NERDTreeMinimalUI = 1                       " 不显示 press ? for help 那一行，使用u返回上一层目录
"let NERDTreeShowBookmarks=1                    " 开启Nerdtree时自动显示Bookmarks
let g:NERDTreeDirArrowExpandable = '▸'          " 设置树的显示图标
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeDirArrows = 1                       " 显示目录图标
let NERDTreeIgnore = ['\.pyc$']                 " 过滤所有.pyc文件不显示
"let g:NERDTreeShowLineNumbers=1                " 是否显示行号
let g:NERDTreeShowHidden=1                      " 显示隐藏文件、目录 
"let NERDTreeHighlightCursorline=0               " 不高亮显示光标所在的文件
"map <C-f> :NERDTreeToggle<CR>                  " 开启/关闭nerdtree快捷键

autocmd vimenter * NERDTree                     " 自动开启Nerdtree
autocmd vimenter * if !argc()|NERDTree|endif    " 打开vim时如果没有文件自动打开NERDTree
"当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tagbar 配置
" 不再建议使用 tagbar, 它会在你保存文件的时候以同步等待的方式运行 ctags （即便你没有打开 tagbar），
" 导致vim操作变卡，可以使用LeaderF来显示函数列表
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:Tagbar_title = "[Tagbar]"
let g:tagbar_ctags_bin='ctags'                  " 设置tagbar使用的ctags的插件,ctags在PATH路径上的，不需要路径 
"let g:tagbar_width=25                          " 窗口宽度的设置
"let g:tagbar_left=1                            " 设置tagbar的窗口显示的位置,为边
"let g:tagbar_right=1                           " 设置tagbar的窗口显示的位置,为右边
"autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()  "如果是c语言的程序的话，tagbar自动开启,开了会导致nerdtree加载慢，autochdir无效
let g:tagbar_vertical = 20                      " nerdtree tagbar同一侧，20开始分隔
let g:tagbar_compact = 1                        " 去除第一行的帮助信息
let g:tagbar_autoshowtag = 1                    " 当编辑代码时，在Tagbar自动追踪变量
let g:tagbar_iconchars = ['▸', '▾']             " 展开关闭文件夹的图标，设置图标后不会乱码
set updatetime=2000                             " tagbar刷新时间间隔

" 打开vim时自动打开，默认不打开，默认打开会导致tagbar加载很慢，有时显示不出来，
" 需要使用时再打开，使用ctrl + w + w切换到tagbar窗口再切换出来，tagbar可以立刻
" 刷新
autocmd VimEnter * nested :call tagbar#autoopen(1)  " 打开tagbar支持的文件类型时打开tagbar窗口
"autocmd VimEnter * nested :TagbarOpen              " 只要打开vim就打开tagbar窗口
nmap <Leader>tb :TagbarToggle<CR>               " 快捷键设置 
"map <F3> :Tagbar<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" winmanager 配置, 在 nerdtree、tagbar 后面，部分变量需要被 winmanager 使用到
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:winManagerWindowLayout='NERDTree'        " 设置界面分割 Bufexplorer放到后面           
"let g:winManagerWidth = 30                     " 设置winmanager的宽度，默认为25     
"let g:AutoOpenWinManager = 1                   " 在进入vim时自动打开winmanager      
"let g:persistentBehaviour = 0                  " 所有文件关闭，只剩资源管理窗口时，退出vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ale配置，乱码，设置终端软件(xshell)及vim/linux配置合适的编码、字体解决
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_sign_column_always = 1				"始终开启标志列
let g:ale_set_highlights = 0
let g:ale_sign_error = '✗'						"自定义error和warning图标
let g:ale_sign_warning = '⚡'
"
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']	"在vim自带的状态栏中整合ale	
"let g:ale_echo_msg_error_str = 'E'						"显示Linter名称,出错或警告等相关信息
"let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"
"nmap sp <Plug>(ale_previous_wrap)				"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
"nmap sn <Plug>(ale_next_wrap)
"nmap <Leader>s :ALEToggle<CR>					"显示Linter名称,出错或警告等相关信息
"nmap <Leader>d :ALEDetail<CR>					"显示Linter名称,出错或警告等相关信息
"
""设置状态栏显示的内容
""set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}\ %{ALEGetStatusLine()}
"
"let g:ale_lint_on_text_changed = 'never'		"文件内容发生变化时不进行检查，保存文件时才运行Linters
"let g:ale_lint_on_enter = 0						"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
"
"使用clang对c和c++进行语法检查，对python使用pylint进行语法检查
let g:ale_linters = {
\   'c++': ['clang'],
\   'c': ['clang', 'gcc'],
\   'python': ['pylint'],
\}
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''
"let g:ale_sign_error = "\ue009\ue009"
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! SpellBad gui=undercurl guisp=red
hi! SpellCap gui=undercurl guisp=blue
hi! SpellRare gui=undercurl guisp=magenta

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-which-key配置 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:mapleader = "\<Space>"
let g:maplocalleader = ","

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :WhichKey ','<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 通用配置2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 需要在nerdtree窗口打开后执行，否则无法跳转到打开文件窗口
"autocmd vimenter * wincmd w                     " 相当执行一次ctrl + w + w，跳转到下一个窗口
"autocmd vimenter * wincmd w                     " 前面打开了nerdtree/tagbar，所以需要两次跳转到buffer
autocmd VimEnter * wincmd p                     " 打开新的buffer时自动定位到编辑窗口
set autochdir                                   " nerdtree自动切换到当前buffer文件所在目录
" nerdtree tagbar窗口行、列不高亮
autocmd FileType nerdtree setlocal nocursorcolumn
autocmd FileType tagbar setlocal nocursorcolumn

"set termencoding=cp936                         " 解决tagbar窗口边符号乱码，但是中文乱码，不能用，使用tagbar_iconchars后解决
"language messages zh_CN.UTF-8 "解决输出乱码 
source $VIMRUNTIME/delmenu.vim "解决菜单乱码
source $VIMRUNTIME/menu.vim "解决consle输出乱码 
