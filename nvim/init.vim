" nate's neovimrc
"
" fold commands:   zo = open fold, zc = close fold
"                  zR = open all,  zM = close all
" fold navigation: [z = fold start, ]z = fold end

" Plugins: {{{1
" ======================
" Install vim-plug by running this:
"     curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" Initialize vim-plug to install plugins at this path:
call plug#begin('~/.local/share/nvim/plugged')

" Solarized aka the best color scheme!
" configure iterm2 to use 16 color solarized
" this fork fixes the awful bright grey neomake SignColumn where
" line-level warnings and errors are highlighted.
" see https://github.com/altercation/solarized/issues/252
Plug 'jumski/vim-colors-solarized'

" Always follow project specific whitespace rules
Plug 'editorconfig/editorconfig-vim'

" Easily select all text at a given indentation by hitting vii
Plug 'michaeljsmith/vim-indent-object'

" Visualize the undo tree
Plug 'mbbill/undotree'

" git integration: super useful!
Plug 'tpope/vim-fugitive'

" Convenience shortcuts
Plug 'tpope/vim-unimpaired'

" make replacement for syntax and lint checking
Plug 'neomake/neomake'

" formatter, used for the prettier js formatter
Plug 'sbdchd/neoformat'

" Overly fancy statusline
"Plug 'vim-airline/vim-airline'

" The airline solarized theme plugin gets automatically enabled, apparently
"Plug 'vim-airline/vim-airline-themes'

" For async completion (added for typescript)
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" yet another typescript syntax plugin
"Plug 'HerringtonDarkholme/yats.vim'

" typescript language server plugin
"Plug 'mhartington/nvim-typescript', {'do': './install.sh'}

" fix double-size hanging indents
Plug 'Vimjas/vim-python-pep8-indent'

" newer than built-in python syntax -- supports f strings etc
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" handy plugin for text notes where you want to align tabular data
"Plug 'junegunn/vim-easy-align'

" fzf default plugin installed via homebrew
"Plug '/usr/local/opt/fzf'
" fzf.vim for nice commands :Files, :Rg
"Plug 'junegunn/fzf.vim'

call plug#end()

" ============================== }}}1

" Display: {{{1
" ======================

" Set background to dark or light based on MacOS system setting; linux is dark
set background=dark

function! SetBackgroundMode(...)
  let s:mode = systemlist("defaults read -g AppleInterfaceStyle")[0]
  if s:mode ==? "dark"
    let s:new_bg = "dark"
  else
    let s:new_bg = "light"
  endif
  if &background !=? s:new_bg
    let &background = s:new_bg
  endif
endfunction

"if $TERM_PROGRAM ==? "iTerm.app"
"  call SetBackgroundMode()
"  call timer_start(3000, "SetBackgroundMode", {"repeat": -1})
"endif

" Enable solarized dark and light (requires iterm2 profile be set to solarized too)
colorscheme solarized

" Set the terminal title to display the open file name etc
set title

" Highlight real tabs and trail whitespace
set list listchars=tab:»\ ,trail:·

" Show line numbers relative to the line you're on for easy jumps
set relativenumber

" Override netrw defaults to show relativenumbers on directory listings
"let g:netrw_bufsettings='noma nomod nonu nobl nowrap ro relativenumber'

" Highlight the line under the cursor
set cursorline

" Highlight the word under the cursor everywhere it's visible on screen
autocmd! CursorMoved * exe printf('match CursorLine /\V\<%s\>/', escape(expand('<cword>'), '/\'))

" ============================== }}}1

" Formatting: {{{1
" ==============================

" Default tab widths, this will be overridden by editorconfig when available
set tabstop=4
set shiftwidth=4
set softtabstop=0
set noexpandtab
set smarttab

" Enable auto-indentation
set autoindent
set smartindent

" ============================== }}}1

" Input: {{{1
" ==============================

" Enable xterm mouse support
set mouse=a

" Search as you type
set incsearch

" 1000 undos.
set undolevels=1000
set history=50

" ============================== }}}1

" Mappings: {{{1
" ==============================

" Define a leader key.
let g:mapleader = " "

" Open the undo tree
nnoremap <F5> :UndotreeToggle<CR>

" Open and source my .vimrc file by hitting \ev or \sv
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Easy tab naviagation
nnoremap tn :tabnext<cr>
nnoremap tp :tabprev<cr>
nnoremap td :tabnew %:p:h<cr>
nnoremap tc :e %:p:h<cr>

" Easy vertical split to the right that also splits the quickfix window
nnoremap ts :vertical botright split<cr>
" Horizontal split
nnoremap th :split<cr>

" Unmap the netrw shortcut that conflicts with the above mappings
autocmd! FileType netrw noremap <buffer>q <Nop>
autocmd! FileType netrw noremap <buffer>t <Nop>

" Easy buffer navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Run neoformat by hitting <space>ff (it never runs automatically)
nnoremap <leader>ff :Neoformat<cr>

" Run neomake by hitting <space>nn (otherwise it only runs on file write)
nnoremap <leader>nn :Neomake<CR>

" Sort a block of imports (or any block. blocks are separated by blank lines)
nnoremap <leader>si :Neoformat isort<cr>
nnoremap <leader>fi :Neoformat isort<cr>

" Python test assertions
nnoremap <leader>ae ^iself.assertEqual(<esc>A)<esc>^
nnoremap <leader>ai ^iself.assertIn(<esc>A)<esc>^
nnoremap <leader>an ^iself.assertIsNone(<esc>A)<esc>^
nnoremap <leader>at ^iself.assertTrue(<esc>A)<esc>^
nnoremap <leader>af ^iself.assertFalse(<esc>A)<esc>^


" easily inject python dependency path when typing :e or :tabe commands
cnoremap <c-e> <C-R>=expand('$VIRTUAL_ENV/lib/python*/site-packages/')<cr>
cnoremap <c-s> <C-R>=expand('%:p:h')<cr>/

" nvim-typescript bindings
"nnoremap <leader>tg :TSDef<cr>
"nnoremap <leader>tp :TSDefPreview<cr>
"nnoremap <leader>tr :TSRefs<cr>
"nnoremap <leader>td :TSDoc<cr>
"nnoremap <leader>tt :TSType<cr>

" Start interactive EasyAlign in visual mode (e.g. vipga)
"xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
"nmap ga <Plug>(EasyAlign)

" ============================== }}}1

" Snippets: {{{1

" Python:
iabbrev pdbst import ipdb; ipdb.set_trace()
iabbrev log= log = logging.getLogger(__name__)

" ============================== }}}1
"
" Helper Functions: {{{1

" Navigate up the tree looking for node_module/.bin/{binname}
" Falls back to what I know to be the `npm bin -g` folder when using nvm
function! GetNpmBin(binname)
  let suffix = '/node_modules/.bin/' . a:binname

  let dir = getcwd()
  while dir != '/'
    if filereadable(dir . suffix)
      return dir . suffix
    else
      let dir = fnamemodify(dir, ':h')
    end
  endwhile

  let dir = expand("$NVM_BIN")
  if filereadable(dir . suffix)
    return dir . suffix
  end

  return a:binname . '-not-found-by-nvim-GetNpmBin'
endfunction

" ============================== }}}1

" Neomake: {{{1
" ==============================

" for debugging, see :messages
"let g:neomake_verbose = 3

" Configure neomake to run writes
call neomake#configure#automake('w')

" open quickfix/loclist only if there's output, always preserve cursor position
let g:neomake_open_list = 2

let g:neomake_java_enabled_makers = []

" enable locally-installed eslint wherever possible
let g:neomake_javascript_enabled_makers = []
let g:neomake_javascript_eslint_exe = GetNpmBin('eslint')

" running neomake on unsaved files causes it to be run on dot-prefixed temp
" files which eslint emits a warning about, so add a custom --ignore-pattern
" to the default neomake eslint args
let g:neomake_javascript_eslint_args = ['-f', 'compact', '--ignore-pattern', '!**/*.js']

" jsx is the same as javascript as far as i am concerned
let g:neomake_jsx_enabled_makers = g:neomake_javascript_enabled_makers
let g:neomake_jsx_eslint_exe = g:neomake_javascript_eslint_exe
let g:neomake_jsx_eslint_args = g:neomake_javascript_eslint_args

" automatically close corresponding loclist when quitting a window
autocmd! QuitPre * if &filetype != 'qf' | silent! lclose | endif

" ============================== }}}1

" Neoformat: {{{1
" ==============================

"let g:neoformat_try_formatprg = 1
"autocmd FileType javascript setlocal formatprg=/Users/nathan.wright/Code/cx-poc/client/node_modules/.bin/prettier\ --stdin\ --stdin-filepath\ a.js\ --config\ /Users/nathan.wright/Code/cx-poc/.prettierrc
"autocmd FileType javascript.jsx setlocal formatprg=/Users/nathan.wright/Code/cx-poc/client/node_modules/.bin/prettier\ --stdin\ --stdin-filepath\ a.jsx\ --config\ /Users/nathan.wright/Code/cx-poc/.prettierrc
"autocmd FileType typescript setlocal formatprg=/Users/nathan.wright/Code/cx-poc/client/node_modules/.bin/prettier\ --stdin\ --stdin-filepath\ a.ts\ --config\ /Users/nathan.wright/Code/cx-poc/.prettierrc
"autocmd FileType typescript.tsx setlocal formatprg=/Users/nathan.wright/Code/cx-poc/client/node_modules/.bin/prettier\ --stdin\ --stdin-filepath\ a.tsx\ --config\ /Users/nathan.wright/Code/cx-poc/.prettierrc

" ============================== }}}1

" Filetypes: {{{1
" ==============================

" uncommon file types
autocmd! BufRead,BufNewFile *.docker setfiletype dockerfile

" ============================== }}}1

" Configure misc plugins: {{{1
" ==============================

" python environments
" see https://github.com/tweekmonster/nvim-python-doctor/wiki/Advanced:-Using-pyenv
let g:python_host_prog = $PYENV_ROOT . '/versions/neovim2/bin/python'
let g:python3_host_prog = $PYENV_ROOT . '/versions/neovim3/bin/python'

" asynchronous autocompletion
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible()? "\<c-n>" : "\<tab>"
set completeopt=menu,preview,noinsert,noselect

set wildmode=longest:full
set wildignore+=*/__pycache__/*

" ============================== }}}1

" vim:fdm=marker
