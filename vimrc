call plug#begin('~/.vim/plugged')

"Plug 'kevinw/pyflakes-vim'
Plug 'altercation/vim-colors-solarized'
Plug 'bling/vim-airline'
Plug 'derekwyatt/vim-scala'
Plug 'duganchen/vim-soy'
Plug 'editorconfig/editorconfig-vim'
Plug 'ervandew/supertab'
Plug 'hynek/vim-python-pep8-indent'
Plug 'leafgarland/typescript-vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'mitsuhiko/vim-jinja'
Plug 'pangloss/vim-javascript'
Plug 'sjl/gundo.vim'
Plug 'tfnico/vim-gradle'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/argtextobj.vim'
Plug 'vim-syntastic/syntastic'

call plug#end()

syntax on

set background=dark
colorscheme solarized

" default text encoding (needed for the tab/trail chars)
set encoding=utf-8

" tab/trail chars
set list listchars=tab:»\ ,trail:·

" enable line wrapping when using backspace/delete
set backspace=indent,eol,start

" set the terminal title to display the open file name etc
set title

" always show the cursor position
set ruler

" enable xterm mouse support
set mouse=a
set ttymouse=urxvt

set laststatus=2

let g:python_version_2=0
let g:airline_left_sep=''
let g:airline_right_sep=''

let g:airline_detect_modified=1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_python_checkers = ['flake8']
"let g:syntastic_python_checker_args='--ignore=E501'

" enable ~/.vim/ftplugin/* file-specific scripts
filetype plugin on
filetype indent on

" uncommon file types
autocmd! BufRead,BufNewFile *.wsgi setfiletype python
autocmd! BufRead,BufNewFile *.proto setfiletype proto
autocmd! BufRead,BufNewFile *.gss setfiletype css
autocmd! BufRead,BufNewFile *.as setfiletype actionscript
autocmd! BufRead,BufNewFile *.jinja2,*.jinja2js,*.jinja setfiletype htmljinja
autocmd! BufRead,BufNewFile .envrc setfiletype bash

" tab widths
set tabstop=4
set shiftwidth=4
set softtabstop=0
set noexpandtab
set smarttab

" enable auto-indentation
set autoindent
set smartindent

" show line numbers relative to the line you're on for easy jumps
set relativenumber
autocmd! filetype netrw set relativenumber

" highlight the line under the cursor
set cursorline
" highlight all visible instances of the word under the cursor
autocmd CursorMoved * exe printf('match CursorLine /\V\<%s\>/', escape(expand('<cword>'), '/\'))

" enable autocomplete
set wildmenu
set wildmode=longest:full
let g:SuperTabDefaultCompletionType = "<c-n>"

" 1000 undos. good for gundo especially!
set undolevels=1000
set history=50

" Resize splits when the window is resized
autocmd! VimResized * exe "normal! \<c-w>="

" make searching case-insensitive unless you use a capital
set ignorecase
set smartcase

" incremental search
set incsearch

" Define a leader key. This is the default.
let mapleader = " "

" Open and source my .vimrc file by hitting \ev or \sv
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Easy tab naviagation
nnoremap tn :tabnext<cr>
nnoremap tp :tabprev<cr>
nnoremap td :tabnew %:p:h<cr>
nnoremap tc :e %:p:h<cr>

" Disable arrow keys
"inoremap  <Up>     <NOP>
"inoremap  <Down>   <NOP>
"inoremap  <Left>   <NOP>
"inoremap  <Right>  <NOP>
"noremap   <Up>     <NOP>
"noremap   <Down>   <NOP>
"noremap   <Left>   <NOP>
"noremap   <Right>  <NOP>

" Easy buffer navigation
noremap <C-h>  <C-w>h
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l

" Easy window splitting
nnoremap ts :vsplit<cr>
nnoremap th :split<cr>

" Disable the damn manual key
nnoremap K <nop>
vnoremap K <nop>

" Strip docstrings and linebreaks from a sqlalchemy Table definition
vnoremap <leader>sd :s/, doc=\_.\{-}""")/)/g<cr>gv!grep .<cr>
vnoremap <leader>se :s/, doc=\_.\{-}")/)/g<cr>gv!grep .<cr>

" Sort a block of imports (or any block. blocks are separated by blank lines)
nnoremap <leader>si vip:!sort\|uniq<cr>

" Split the comma separated import on the current line into two separate
" imports, then sort. Returns to the same line after, so can be repeated
" when there are many imports on the same line.
nnoremap <leader>fi 0v/import<cr>eyf,pF,s<cr><esc>vip:!sort\|uniq<cr>

" Search forward or back for the selected characters by re-using * and #,
" but only when in visual mode.
vnoremap * "py/<c-r>p<cr>
vnoremap # "py?<c-r>p<cr>

" Automatically open the quickfix window when using :Ggrep
autocmd QuickFixCmdPost *grep* cwindow

" Forgot to sudo ??
" Run this! :w !sudo tee %

nnoremap <F5> :GundoToggle<CR>

" Navigate diffs when opened by my gitcfo shell alias {{{
"     function gitcfo() { CFO_BASE=$1 vim -c "Gdiff $1" `git show --pretty="format:" --name-only $1..$2 | grep . | uniq`; }
" (Still buggy but sometimes useful)
function! NavigateDiffs(direction)
	execute ":" . a:direction
	try
		execute ":Gdiff " . $CFO_BASE
	catch /Needed a single revision/
		execute "normal! :echo 'This file did not exist before now'\r"
	endtry
endfunction
nnoremap [f <C-W>l<C-W><C-O>:call NavigateDiffs('previous')<cr>
nnoremap ]f <C-W>l<C-W><C-O>:call NavigateDiffs('next')<cr>
" }}}

iabbrev foriin for (var i = 0, x; x = y[i]; ++i) {
iabbrev googreq goog.require('');
iabbrev googpro goog.provide('');
iabbrev googscope goog.scope(function() {});  // goog.scope
iabbrev pdbst import ipdb; ipdb.set_trace()
iabbrev log= log = logging.getLogger(__name__)
iabbrev pprint import pprint; pprint.pprint(
iabbrev decl goog.module.declareLegacyNamespace();
iabbrev vtagname var TagName = goog.require('goog.dom.TagName');
iabbrev vassert var assert = goog.require('goog.asserts').assert;
iabbrev veid var EventId = goog.require('goog.events.EventId');

function! SavesuperClass_(proto)
	let s:js_prototype = a:proto
endfunction
function! PrintPrototype()
	execute 'normal! "0p'
endfunction
vnoremap <leader>lp "0y
nnoremap <leader>p "0p
"inoremap <leader>p <C-r>0p

nnoremap <leader>h yypVr=
nnoremap <leader>j yypVr-

nnoremap <leader>ae ^iself.assertEqual(<esc>A)<esc>^
nnoremap <leader>ai ^iself.assertIn(<esc>A)<esc>^
nnoremap <leader>an ^iself.assertIsNone(<esc>A)<esc>^
nnoremap <leader>at ^iself.assertTrue(<esc>A)<esc>^
nnoremap <leader>af ^iself.assertFalse(<esc>A)<esc>^
nnoremap <leader>bd :w<cr>:!sphinx-build -b html -c sphinx-conf -d sphinx-conf/build/doctrees mediacore/docs sphinx-conf/build/html<cr>
nnoremap <leader>tt viw<esc>a``<esc>`<i``<esc>l
nnoremap <leader>fm vip:!fmt -79<cr>
nnoremap <leader>fg vip:!fmt -72<cr>
vnoremap <leader>fm !fmt -79<cr>
nnoremap <leader>mh yypVr

" take a goog.scope alias and wrap it in goog.require
nnoremap <leader>wc ^f f f agoog.require('<esc>$i')<esc>0
" turn a constructor fn into a class
nnoremap <leader>cc ^iclass <esc>lvt bhxea {<esc>constructor<esc>ldejVk$%>$k%lx%j<esc>Osuper();<esc>
" class method with docstring
nnoremap <leader>cm V/*\/<cr>j/function<cr>% %>/*\/<cr>j^t bd^eldt(^% %lx
" class method with docstring and a following method (removes an extra blank
" line and lets so you can repeeat this)
nnoremap <leader>cn V/*\/<cr>j% %>/*\/<cr>j^t bd^eldt(^% %lxjddj
" class method with docstring
nnoremap <leader>cb V/function<cr>% %>/function<cr>^t bd^eldt(^% %lx
nnoremap <leader>cv v/*\/<cr>jt;>/*\/<cr>jht bhv^xf vlls() {<cr>return <esc>o}<esc>
" find the next superClass_ reference
nnoremap <leader>sf /\<superClass_\><cr>
" replace the superClass_ method call with a call to super...() -- no args
nnoremap <leader>sr ev^ssuper<esc>f.f.delde
" replace the superClass  method call with a call to super...() -- with args
nnoremap <leader>st ev^ssuper<esc>f.f.deldede
" replace the goog.base call
nnoremap <leader>sb vf'ssuper.<esc>f's(<esc>
" when on a line containing this:
"    var A = goog.require('B')
" initiate a find and replace for B to A
nnoremap <leader>fa ^f l"ayt f'l"syt'<esc>:%s/<c-R>s/<c-R>a/gc<cr>n
" insert 'var N = ' in front of a line containing a require
nnoremap <leader>vi ^f'f'hvby0ivar <esc>pa = <esc>0
" write a goog.module.get line for the current require
nnoremap <leader>fg yypf't'vby0ivar <esc>pa = <esc>t(vbsmodule.get<esc>0
" replace a goog.provide with goog.module
nnoremap <leader>rp fpcwmodule<esc>0
" rewrite the module function to an export
nnoremap <leader>ef ^vt F.hsexports<esc>^
" rewrite a namespaced function into a local-only function
nnoremap <leader>lf ^f vllxhvbdhv0"_dea <esc>pl%l%lx
" take a property name and wrap it in this. and = null;
nnoremap <leader>in Ithis.<esc>ea = null;<esc>
" rewrite a prototype initialization into a constructor initialization
nnoremap <leader>pn }kt bhhv0sthis<esc>vip2>

" type out the path to my site-packages folder in most projects
nnoremap <leader>ve :e .virtualenv/lib/python2.7/site-packages/

nnoremap <leader>sc 0vt yo<esc>p0i  <esc>/prototype<cr>cwsuperClass_<esc>$a.call(this);<esc>k0/function(<cr>f(l
nnoremap <leader>gs 0f'vi'y/goog.scope<cr>o<cr>var  = ;<esc>Pvby2F P0xx
vnoremap <leader>gr ygg/goog.require<cr>ogoog.require('<esc>pa');<esc>2<c-o>
vnoremap <leader>gp yggOgoog.provide('<esc>pa');<esc>2<c-o>
