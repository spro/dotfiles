set nocompatible
set hidden
set shell=bash

call pathogen#infect()

filetype plugin on
filetype indent on

set undodir=~/.vim/undo/
set undofile
set backupcopy=yes " Otherwise entr does double-runs on save

let g:ftplugin_sql_omni_key = '<C-j>'

let g:bracey_refresh_on_save = 1
let g:bracey_auto_start_browser = 0
let g:bracey_server_port = 3483

set ttimeoutlen=0

let mapleader=","

runtime macros/matchit.vim

" Extra whitespace
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL
hi ExtraWhitespace ctermbg=red

" Filetype-specific
" ----------------------------------------------------------------------------------------

au BufRead,BufNewFile *.sss set filetype=sass

au Filetype typescriptreact set iskeyword+=-

" CoC
" ----------------------------------------------------------------------------------------

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
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> <leader>w <Plug>(coc-diagnostic-next)
nmap <silent> <leader>W <Plug>(coc-diagnostic-prev)

nmap <silent> <leader>e <Plug>(coc-diagnostic-next-error)
nmap <silent> <leader>E <Plug>(coc-diagnostic-prev-error)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" CoC Snippets
" ----------------------------------------------------------------------------------------

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

" Emmet

let g:user_emmet_settings = {
\    'typescriptreact': {
\        'extends': 'jsx'
\    }
\}

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

" Turn off mac bell
set noerrorbells 
set novisualbell
set t_vb=
autocmd! GUIEnter * set vb t_vb=

" Functions & Commands
" ----------------------------------------------------------------------------------------

" ,, to save
nnoremap <leader><leader> :w<CR>
inoremap <leader><leader> <C-c>:w<CR>a
" ,q to save and quit
noremap <leader>q :wq<CR>

" ,t to rename tab
noremap <leader>t :TabooRename 

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

set foldmethod=syntax
" set nofoldenable
set foldlevelstart=20

set mouse=a

set path+=**
set wildmenu
set wildmode=longest:list,full

set wildignore+=*/tmp/*,*/log/*,*/node_modules/*,*.so,*.swp,*.zip,*.bounced,package-lock.json
let g:ctrlp_custom_ignore = '\v[\/](\.(git|hg|svn)|log|solr|public\/js\/vendor|builtAssets|node_modules)$'

let g:closetag_filenames = "*.html,*.coffee,*.js,*.tsx"

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

" let g:snipMate = {}
" let g:snipMate.override = 1

let g:closetag_emptyTags_caseSensitive = 1

" fzf 

let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
nnoremap <c-p> :FZF<cr>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --type-not svg --type-not lock --type-not config --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

nnoremap \ :Rg<cr>

let g:jedi#completions_command = "<C-;>"

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
