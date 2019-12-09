set nocompatible
set hidden
set shell=bash

call pathogen#infect()

filetype plugin on
filetype indent on

set undodir=~/.vim/undo/
set undofile

" Appearance
" ----------------------------------------------------------------------------------------

set t_Co=256
syntax on
colorscheme spro
set relativenumber

set cursorline
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Functions & Commands
" ----------------------------------------------------------------------------------------

let mapleader=","

nnoremap <leader><leader> :w<CR>
inoremap <leader><leader> <C-c>:w<CR>a
noremap <leader>q :wq<CR>

" Convert 2-space tabbing to 4-space
command -range=% Reindent <line1>,<line2>s/^\s\+/&&/

" Trim any blank line endings
command -range=% Trimlines <line1>,<line2>s/\s\+$//

" Turn selected text into Title Case Text
command -range=% Sentencecase <line1>,<line2>!python -c "import sys; print(' '.join(line.title() for line in sys.stdin).strip())"

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
" nnoremap <tab> %
" vnoremap <tab> %
" Move nicely over wrapped lines
nnoremap j gj
nnoremap k gk
" Easy insertion of blank lines
nnoremap <leader>o o<Esc>k
nnoremap <leader>O O<Esc>j
" `gf` for opening markdown files from wiki links
" nnoremap <leader>f f(lvt)gf
" ack shortcut
" nnoremap <leader>/ :Ack 

" Omnicomplete for line
inoremap <C-l> <C-x><C-l>
inoremap <C-l> <C-x><C-l>

" Avoid killing leader
inoremap <C-c> <Esc>

" Press F10 to display matching syntax rules for character under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" General configuration
" ----------------------------------------------------------------------------------------

" Indentation
set autoindent
set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set bs=2

" Fix # indents
set cindent
set cinkeys-=0#
set indentkeys-=0#

set foldmethod=indent
set nofoldenable

set mouse=a

set path+=**
set wildmenu
set wildmode=full

set wildignore+=*/tmp/*,*/log/*,*/node_modules/*,*.so,*.swp,*.zip,*.bounced,package-lock.json
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
set splitbelow
set splitright

" Highlight lines ending with space
autocmd Syntax * syntax match ExtraSpace /\s\+$/
highlight ExtraSpace cterm=NONE ctermbg=124

" Load project-specific .vimrc files from local directory
if getcwd() != $HOME
    if filereadable(".vimrc")
        so .vimrc
    endif
endif

autocmd BufRead package.json set shiftwidth=2

" Plugin config
" ----------------------------------------------------------------------------------------

" map  <leader>F <Plug>(easymotion-bd-f)
" nmap <leader>f <Plug>(easymotion-overwin-f)

" let g:UltiSnipsSnippetDirectories=["snips"]
" let g:UltiSnipsExpandTrigger           = '<tab>'
" let g:UltiSnipsJumpForwardTrigger      = '<tab>'

let g:closetag_emptyTags_caseSensitive = 1

" Vim Instant Preview
" https://github.com/spro/vim-instant-preview
" ----------------------------------------------------------------------------------------

function PreviewOpenChannel()
    let g:preview_ch_handle = ch_open('localhost:8765')
endfunction

function PreviewMaybeOpenChannel()
    if !exists("g:preview_ch_handle")
        call PreviewOpenChannel()
    elseif ch_status(g:preview_ch_handle) != "open"
        call PreviewOpenChannel()
    endif
endfunction

function PreviewSendContents()
    call PreviewMaybeOpenChannel()
    let filename = expand('%:p')
    let contents = join(getline(1, '$'), "\n")
    let response = ch_sendexpr(g:preview_ch_handle, filename . "\n" . contents)
endfunction

function PreviewStart()
    autocmd! * <buffer>
    autocmd BufEnter <buffer> call PreviewSendContents()
    autocmd TextChanged <buffer> call PreviewSendContents()
    autocmd TextChangedI <buffer> call PreviewSendContents()
    call PreviewSendContents()
endfunction

nnoremap <leader>p :call PreviewStart()<CR>

" ----

function! SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
