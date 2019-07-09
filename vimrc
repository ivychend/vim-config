
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 通用配置 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number	            " 显示行号
set tabstop=4	        " 一个tab四个空格字符
set expandtab	        " 用空格来替换tab
set nocompatible        " 不兼容vi

filetype plugin on                  " 根据文件类型加载插件
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

