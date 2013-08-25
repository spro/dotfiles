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
set wildignore+=*/tmp/*,*/log/*,*.so,*.swp,*.zip,*/node_modules/*
let g:ctrlp_custom_ignore = '\v[\/](\.(git|hg|svn)|log|solr|public\/js\/vendor|components|builtAssets|node_modules)$'

set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
set laststatus=2

let mapleader=","
" some special functions i guess
nnoremap <leader><space> :noh<cr>
nnoremap <leader>{ i{%  %}<Esc>3ha
nnoremap <leader>: ^:s/\s*=/:<cr>:noh<cr>
nnoremap <leader>= ^:s/\s*:/ =<cr>:noh<cr>

nnoremap <tab> %
vnoremap <tab> %

set splitbelow
set splitright
command Reindent %s/^\s\+/&&/
