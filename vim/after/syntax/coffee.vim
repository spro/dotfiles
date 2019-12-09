syn match coffeeConsoleLog 'console\.log'
syn match coffeeConsoleLog 'console\.error'
syn match coffeeConsoleLog 'console\.warn'
syn match coffeeConsoleLog 'debug'
hi coffeeConsoleLog ctermfg=181

syn match coffeeExports 'exports'
syn match coffeeExports 'module.exports'
syn match coffeeExports /^export/
syn match coffeeExports /^import/
hi link coffeeExports Include

syn match coffeeAsync 'await'
syn match coffeeAsync 'yield'
hi coffeeAsync ctermfg=121

syn match coffeeFunctionDec /^\s\?\zs[a-z][a-zA-Z]\+\ze = [^\.]*->/
hi coffeeFunctionDec ctermfg=68

" syn match innerBrace /{[a-zA-Z0-9_, \n]\+}/ transparent contains=coffeeObjExtract
" syn match coffeeObjExtract /\w\+/ contained
" hi link coffeeObjExtract coffeeObjAssign

" hi coffeeObjAssign cterm=none

" syn cluster coffeeAll add=coffeeObjExtract

