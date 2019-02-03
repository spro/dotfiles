syn match coffeeConsoleLog 'console\.log'
syn match coffeeConsoleLog 'console\.error'
syn match coffeeConsoleLog 'console\.warn'
syn match coffeeExports 'exports'
syn match coffeeExports 'module.exports'
hi coffeeConsoleLog ctermfg=181
hi link coffeeExports Include

" syn match innerBrace /{[a-zA-Z0-9_, \n]\+}/ transparent contains=coffeeObjExtract
" syn match coffeeObjExtract /\w\+/ contained
" hi link coffeeObjExtract coffeeObjAssign

" hi coffeeObjAssign cterm=none

" syn cluster coffeeAll add=coffeeObjExtract

syn match coffeeFunctionDec /^\s\?\zs[a-z][a-zA-Z]\+\ze = .*->$/
hi coffeeFunctionDec ctermfg=68
