set nocp

syntax on
set bs=indent,eol,start "backspace
"set t_kb= "Make backspace work when ssh to cdf from Ubuntu
set hls "highlight search

"Need to put solarized.vim or zenburn.vim on ~/.vim/colors

"zenburn is better in terminal while solarized is better in gvim
"To work with zenburn on terminal add following on .bashrc
"export TERM=xterm-256color
"For ssh use desert or wombat

"solarized colorscheme
"set bg=dark
"colorscheme solarized

"colorscheme zenburn
"colorscheme Tomorrow-Night-Eighties
"onedark theme ref: https://github.com/joshdick/onedark.vim
colorscheme onedark

set sol "start of the line
set ru "cursor
set sc "show the command
"set number "show line number
set ruler "show column number

set sw=4 "shiftwidth
set ts=4 "tabstop
set sts=4 "softtabstop
set textwidth=80 "Automatic new line character
set expandtab "use space instead of tab

set sm "show the pair of bracket
set mps+=<:> "user bracket

"Open UTF-8, euc-kr Korean file
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
	set encoding=utf-8
	set fileencodings=utf-8,cp949
endif

set autoindent "auto indentation
set cindent "autoindent for C programming
set smartindent
"set paste "not reconmanded to set globally
" reference: https://superuser.com/questions/437730/always-use-set-paste-is-it-a-good-idea
