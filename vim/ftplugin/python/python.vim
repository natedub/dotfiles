" treat tabs as spaces
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal smarttab
setlocal expandtab

" intelligent indenting
setlocal autoindent
setlocal nosmartindent

" enable autocompletion
"setlocal omnifunc=pythoncomplete#Complete

" clear trailing whitespace on save
autocmd BufWritePre <buffer> :%s/[ \t\r]\+$//e
