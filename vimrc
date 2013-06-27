set nocompatible
set hidden
call pathogen#infect()

filetype plugin on
filetype indent on
syntax on
set background=dark

set autoindent
set smartindent
set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set bs=2

set mouse=a

set wildmenu

function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction

autocmd VimEnter * call StartUp()
let g:NERDTreeDirArrows=0

set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

let mapleader=","
nnoremap <leader><space> :noh<cr>
nnoremap <leader>{ i{%  %}<Esc>3ha
nnoremap <tab> %
vnoremap <tab> %

set splitbelow
set splitright
command Reindent %s/^\s\+/&&/
