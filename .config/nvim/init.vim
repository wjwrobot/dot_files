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
call plug#begin('~/.local/share/nvim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-surround'
"------------------------------
" Intellisense engine, full lsp support as VSCode
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"------------------------------
" fuzzy finder
Plug '/usr/bin/fzf' " has installed in system
Plug 'junegunn/fzf.vim'
"------------------------------
" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" ------------------------------
" Latex
Plug 'lervag/vimtex'
"------------------------------
" Snippets
Plug 'sirver/ultisnips'
"Plug 'honza/vim-snippets'
"------------------------------
Plug 'jiangmiao/auto-pairs'
"------------------------------
" Ag
"Plug 'mileszs/ack.vim'
"------------------------------
" Code Fold
"Plug 'tmhedberg/SimpylFold'
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
"               CONFIGURE FOR LATEX
"must to install 'latexmk'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
"------------------------------------------------------------
"               CONFIGURE FOR UltiSnips
"must 'pip3 install --user --upgrade pynvim'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
"------------------------------------------------------------
"               CONFIGURE FOR coc.vim
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" --------------------------------------------------
"               CONFIGURE FOR coc.snippet
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
" --------------------
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" --------------------------------------------------
"               CONFIGURE FOR fzf
" https://jesseleite.com/posts/2/its-dangerous-to-vim-alone-take-fzf
nnoremap <C-p> :Files<Cr>
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>
nmap <Leader>H :Helptags!<CR>
nmap <Leader>t :BTags<CR>
nmap <Leader>T :Tags<CR>
