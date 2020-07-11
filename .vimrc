set nocompatible
set number relativenumber
set showmatch
let python_highlight_all=1
"------------------------------------------------------------
"------------------------------------------------------------
"                         PLUGIN MANAGER
" Install vim-plug
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"------------------------------------------------------------
" vim-plug package manager
call plug#begin('~/.vim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-surround'
"------------------------------
" fuzzy finder
Plug '/usr/bin/fzf' " has installed in system
Plug 'junegunn/fzf.vim'
"------------------------------
" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" ------------------------------
" Snippets
Plug 'sirver/ultisnips'
"Plug 'honza/vim-snippets'
"------------------------------
Plug 'jiangmiao/auto-pairs'
"------------------------------
" Syntax highlighting and indentation
Plug 'sheerun/vim-polyglot'
"------------------------------
call plug#end()

"------------------------------------------------------------
"------------------------------------------------------------
"                         COLOR SCHEME
" theme: https://github.com/joshdick/onedark.vim
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif
"---------------
colorscheme onedark

"------------------------------------------------------------
"------------------------------------------------------------
"               CODE FOLDING
set foldmethod=indent
set foldlevel=99
"------------------------------------------------------------
"               MISC
"syntax on
"filetype indent plugin on

" Wrap lines
"set wrap
set ignorecase
set hlsearch
set incsearch
"set autoindent
set smartindent
"set smarttab
" Tab length
set ts=4
set expandtab
set shiftwidth=4
set expandtab
set cursorline
set colorcolumn=80
" Enable mouse wheel scrolling
set mouse=n
" Or also visual mode
"set mouse=a
set encoding=utf-8
set showcmd
set laststatus=2
" Let buffer be switched to another one without requiring to save it first
set hidden

" Zsh like <Tab> completion in command mode
set wildmenu
set wildmode=full
" Show ruler
set ruler
set clipboard=unnamedplus
" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e
"------------------------------------------------------------
"               KEYMAP
"it is need for map <Space> key to leader key
nnoremap <Space> <Nop>
let mapleader=" "       "change leader key to <Space> key
inoremap jj <Esc>

" Copy selected text to system clipboard
vnoremap <C-c> "+y
map <C-p> "+P
"------------------------------------------------------------
"------------------------------------------------------------
"               CONFIGURE FOR UltiSnips
"must 'pip3 install --user --upgrade pynvim'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
"------------------------------------------------------------

