set nocompatible
set hidden
call pathogen#infect()

filetype plugin on
filetype indent on

" Colors
set t_Co=256
syntax on
highlight CursorLine cterm=NONE ctermbg=235
highlight Search ctermbg=24 ctermfg=15
"highlight CursorColumn cterm=NONE ctermbg=235
set cursorline " cursorcolumn
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END
"set background=dark

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

nmap <silent> <C-w>y :call MarkWindowSwap()<CR>
nmap <silent> <C-w>p :call DoWindowSwap()<CR>

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
" toggle cursor lines
"nnoremap <leader>- :set cursorline!
"nnoremap <leader>| :set cursorcolumn!<cr>

nnoremap <tab> %
vnoremap <tab> %

set fillchars=vert:\│
highlight VertSplit ctermbg=White
highlight VertSplit ctermfg=Black

set splitbelow
set splitright
command Reindent %s/^\s\+/&&/

" Load local .vimrc files
if getcwd() != $HOME
    if filereadable(".vimrc")
        so .vimrc
    endif
endif
