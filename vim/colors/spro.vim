" Vim color file
" Maintainer: Sean Robertson
" Last Change: 2014 Mar 13

let colors_name = "spro"

hi Identifier gui=NONE cterm=NONE guifg=#5fdfff ctermfg=81
hi Operator guifg=#ffffaf ctermfg=229
hi Conditional gui=bold cterm=bold guifg=#ffff00 ctermfg=11
hi String guifg=#d0d0d0 ctermfg=252
hi Comment guifg=#8a8a8a ctermfg=245
hi Statement guifg=#87afff ctermfg=111
hi Structure gui=bold cterm=bold guifg=#87afdf ctermfg=110
hi Function gui=bold cterm=bold guifg=#5fffff ctermfg=87
hi Constant gui=bold cterm=bold guifg=#ff8787 ctermfg=210
hi Label guifg=#87ffdf ctermfg=122
hi Include guifg=#8787af ctermfg=103
" hi Variable

hi coffeeObjAssign gui=bold cterm=bold guifg=#afffff ctermfg=159

hi MatchParen ctermfg=white guibg=#8a8a8a ctermbg=245

" Note fg and bg are backwards for status line
hi StatusLineNC ctermfg=233 ctermbg=240
hi StatusLine ctermfg=237 ctermbg=255

hi Search guibg=#005f87 ctermbg=24 guifg=#ffffff ctermfg=15
hi CursorLine cterm=NONE ctermbg=235
hi LineNr guifg=#585858 ctermfg=240
hi CursorLineNr guifg=#808080 ctermfg=244
hi Visual gui=NONE cterm=NONE guibg=#444444 ctermbg=238

hi VertSplit ctermbg=black ctermfg=black

hi TabLineFill ctermfg=233
hi TabLine cterm=NONE ctermbg=233
hi TabLineSel cterm=bold ctermfg=black ctermbg=45

hi Fold ctermbg=240
hi Folded ctermbg=234 ctermfg=245
