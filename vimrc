set nocompatible
set hidden
set shell=bash

call pathogen#infect()

filetype plugin on
filetype indent on

" Appearance
" ----------------------------------------------------------------------------------------

set t_Co=256
syntax on
colorscheme spro

highlight Search ctermbg=24 ctermfg=15
highlight CursorLine cterm=NONE ctermbg=235
highlight Visual cterm=NONE ctermbg=235

set cursorline
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Functions & Commands
" ----------------------------------------------------------------------------------------

let mapleader=","

" Swap windows more easily
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf 
endfunction

" 'Yank and paste' buffers with above
nmap <silent> <C-w>y :call MarkWindowSwap()<CR>
nmap <silent> <C-w>p :call DoWindowSwap()<CR>

" Clear search highlight
nnoremap <leader><space> :noh<cr>
" Insert Jade tag
nnoremap <leader>{ i{%  %}<Esc>3ha
" Change ` = ` to `: ` and vice-versa
nnoremap <leader>: ^:s/\s*=/:<cr>:noh<cr>
nnoremap <leader>= ^:s/\s*:/ =<cr>:noh<cr>
" Toggle cursor lines
"nnoremap <leader>- :set cursorline!
"nnoremap <leader>| :set cursorcolumn!<cr>
" Tab to jump between braces
nnoremap <tab> %
vnoremap <tab> %
" Convert 2-space tabbing to 4-space
command Reindent %s/^\s\+/&&/
" Move nicely over wrapped lines
nnoremap j gj
nnoremap k gk
" Easy insertion of blank lines
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>
" `gf` for opening markdown files from wiki links
nnoremap <leader>f f(lvt)gf
" ack shortcut
nnoremap <leader>/ :Ack 

" General configuration
" ----------------------------------------------------------------------------------------

" Indentation
set autoindent
set smartindent
set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set bs=2

set mouse=a

set path+=**
set wildmenu
set wildignore+=*/tmp/*,*/log/*,*.so,*.swp,*.zip,*/node_modules/*
let g:ctrlp_custom_ignore = '\v[\/](\.(git|hg|svn)|log|solr|public\/js\/vendor|builtAssets|node_modules)$'

let g:closetag_filenames = "*.html,*.coffee"

set gdefault
set laststatus=2
set showmatch

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Dividers & splits
highlight VertSplit ctermbg=236
highlight VertSplit ctermfg=Black
set splitbelow
set splitright

" Load project-specific .vimrc files from local directory
if getcwd() != $HOME
    if filereadable(".vimrc")
        so .vimrc
    endif
endif
