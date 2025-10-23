" General configs
scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp949,default,latin1
set nocompatible " able keyboard cursor

" Indentation
set autoindent " auto indent
set smartindent " smart indent

" Tab
set tabstop=4 " tab indent size
set shiftwidth=4 " \> indent size

" Line number
set number " line number
set cursorline " highlight current line

" column width
set textwidth=80 " line limitation
set colorcolumn=+1,+2,+3 " highlight column width

" Searching
set hlsearch " highlighting searched results
set ignorecase " ignore case when searching
syntax enable " setting colors depending on the grammer

" Plugins
"" require `vim-plug`, `git`
""" https://github.com/junegunn/vim-plug#installation
""" :PlugInstall command required
"" For root user to copy user's vimrc
""" sudo ln -s /home/username/.vimrc /root/.vimrc
""" sudo ln -s /home/username/.vim /root/.vim

call plug#begin()

Plug 'ghifarit53/tokyonight-vim'

call plug#end()

" Color scheme - tokyonignt
set termguicolors
set background=dark

let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1

colorscheme tokyonight

