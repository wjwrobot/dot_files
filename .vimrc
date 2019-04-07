set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
Plugin 'scrooloose/nerdtree'				" File Explorer

Plugin 'lervag/vimtex'	" Latex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

"Plugin 'SirVer/ultisnips'	" snippets
"let g:UltiSnipsExpandTrigger = '<tab>'
"let g:UltiSnipsJumpForwardTrigger = '<tab>'
"let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" Airline
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line



" show line number
" if not, specify [ set nonumber ]
set number

" highlights parentheses
set showmatch

" show color display
" if not, specify [ syntax off ]
syntax on
filetype indent plugin on

" wrap lines
" if not, specify [ set nowrap ]
"set wrap

" ignore case when searching
set ignorecase

" highlight search results
set hlsearch

" 
set incsearch

" enable syntax highlighting
syntax enable

" auto indent
"set autoindent

" smart indent
set smartindent

" smart tab
"set smarttab

" tab length
set tabstop=4
set shiftwidth=4
"set expandtab

" enable mouse wheel scrolling
set mouse=n
" or also visual mode
" set mouse=a

" set for powerline-vim
"let g:powerline_pycmd="py3"
" enable statusline all the time
"set laststatus=2

" Airline fonts
"let g:airline_powerline_fonts = 1

" NERDTree automatically open when vim starts up
"autocmd vimenter * NERDTree

" Enable syntax highlight for markdown file
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
