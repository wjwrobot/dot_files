set nocompatible
set number
set showmatch
let python_highlight_all=1
"------------------------------------------------------------
"------------------------------------------------------------
"                         PLUGIN MANAGER
" vim-plug package manager
call plug#begin('~/.vim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-surround'
"------------------------------
" fuzzy finder
Plug '/usr/bin/fzf' " has installed in system
Plug 'junegunn/fzf.vim'
"------------------------------
" Ag
"Plug 'mileszs/ack.vim'
"------------------------------
" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
"------------------------------
" Async Autocompletion
" https://github.com/prabirshrestha/asyncomplete.vim
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
"------------------------------
" Vim Lsp
" https://github.com/prabirshrestha/vim-lsp
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
"------------------------------
" LSP support for vim and neovim
"Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': 'bash install.sh',
"    \ }
"
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"------------------------------
" Another Completion Plugin
" see https://github.com/Shougo/deoplete.nvim
"------------------------------
" Asynchronous Linting and Make Framework
"Plug 'neomake/neomake'
"------------------------------
" Code Fold
"Plug 'tmhedberg/SimpylFold'
"------------------------------
call plug#end()

" see http://yannesposito.com/Scratch/en/blog/Vim-as-IDE/
"------------------------------------------------------------
"------------------------------------------------------------
"                         COLOR SCHEME
" theme: https://github.com/joshdick/onedark.vim
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
"---------------
colorscheme onedark
"set background=dark
"colorscheme solarized

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
"------------------------------------------------------------
"               KEYMAP
"it is need for map <Space> key to leader key
nnoremap <Space> <Nop>
let mapleader=" "       "change leader key to <Space> key
inoremap jj <Esc>
"------------------------------------------------------------
"------------------------------------------------------------
"               PYTHON PEP 8
"au BufNewFile,BufRead *.py
"    \ set tabstop=4
"    \ set softtabstop=4
"    \ set shiftwidth=4
"    \ set textwidth=79
"    \ set expandtab
"    \ set autoindent
"    \ set fileformat=unix

"------------------------------------------------------------
"               WEB DEVELOPMENT
"au BufNewFile,BufRead *.js, *.html, *.css
"    \ set tabstop=2
"    \ set softtabstop=2
"    \ set shiftwidth=2
"    \ set expandtab

"------------------------------------------------------------
"               FLAG UNNECESSARY WHITESPACE
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"------------------------------------------------------------
"------------------------------------------------------------
"               LSP FOR PYTHON
" see more details: https://github.com/prabirshrestha/vim-lsp
" Register pyls Python language server.
" MUST DO 'pip install python-language-server'
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif
"------------------------------------------------------------
"               LSP FOR C/C++
"see https://github.com/MaskRay/ccls/wiki/vim-lsp
" Register ccls C++ lanuage server.
" MUST DO 'yay -S ccls-git'
if executable('ccls')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'ccls',
      \ 'cmd': {server_info->['ccls']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'initialization_options': {'cache': {'directory': '/tmp/ccls/cache' }},
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      \ })
endif
"------------------------------------------------------------
"------------------------------------------------------------
"               CONFIGURE 'asyncomplete' PLUGIN
"Tab completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
"Auto popup menu
let g:asyncomplete_auto_popup = 1
"------------------------------------------------------------
"               CONFIGURE 'vim-lsp'
"see https://github.com/MaskRay/ccls/wiki/vim-lsp
" Key bindings for vim-lsp.
nn <silent> <Leader>d :LspDefinition<cr>
nn <silent> <Leader>r :LspReferences<cr>
nn <f2> :LspRename<cr>
nn <silent> <Leader>a :LspWorkspaceSymbol<cr>
nn <silent> <Leader>l :LspDocumentSymbol<cr>
"------------------------------------------------------------
