local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
    -- Manage packer updates with packer
    use 'wbthomason/packer.nvim'

    -- colorscheme
    use {'dracula/vim', as = 'dracula'}

    -- parse .editorconfig files instead of configuring whitespace manually in vim
    use 'editorconfig/editorconfig-vim'

    -- used by gitsigns and nvim-lsp-ts-utils
    use 'nvim-lua/plenary.nvim'

    -- https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf
    -- used by feline and nvim-tree
    use 'kyazdani42/nvim-web-devicons'

    -- file explorer
    -- <C-]> cd to dir under cursor
    -- <C-v> will open the file in a vertical split
    -- <C-x> will open the file in a horizontal split
    -- <C-t> will open the file in a new tab
    -- <Tab> will open the file as a preview (keeps the cursor in the tree)
    -- <BS> will close current opened directory or parent
    -- <Tab> will open the file as a preview (keeps the cursor in the tree)
    -- type a to add a file. Adding a directory requires leaving a leading / at the end of the path. 
    -- type r to rename a file
    -- type I will toggle visibility of hidden folders / files
    -- type H will toggle visibility of dotfiles (files/folders starting with a .)
    -- type R will refresh the tree
    -- type d to delete a file (will prompt for confirmation)
    use 'kyazdani42/nvim-tree.lua'

    -- lightweight git integration to show added/changed lines, blame
    use 'lewis6991/gitsigns.nvim'

    -- status line
    use 'feline-nvim/feline.nvim'

    -- base language server support
    use 'neovim/nvim-lspconfig'
    --use {'jose-elias-alvarez/null-ls.nvim', branch = 'main'}

    -- typescript language server
    use {'jose-elias-alvarez/typescript.nvim', branch = 'main'}

    -- good autocomplete
    use {'hrsh7th/cmp-nvim-lsp', branch = 'main'}
    use {'hrsh7th/cmp-buffer', branch = 'main'}
    use {'hrsh7th/cmp-path', branch = 'main'}
    use {'hrsh7th/cmp-cmdline', branch = 'main'}
    use {'hrsh7th/nvim-cmp', branch = 'main'}

    -- snippets... haven't started using these yet
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    -- highlight word under cursor, with lsp support
    use 'RRethy/vim-illuminate'

--    use {
--        'nvim-treesitter/nvim-treesitter',
--        run = ':TSUpdate'
--    }

    -- useful pairs of keymappings like [q ]q
    use 'tpope/vim-unimpaired'

    -- run :Obsess to start tracking a Session.vim file in the cwd. reopen with vim -S or source.
    use 'tpope/vim-obsession'

    -- still super handy for git blame
    use 'tpope/vim-fugitive'

    -- allow easy manipulation of blocks of text at the same indent level (eg. type vii)
    use 'michaeljsmith/vim-indent-object'

    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzf-native.nvim'
end)

-- setup dracula, assuming that the terminal has the correct 16 ansi colors set
vim.o.background = 'dark'
vim.g.dracula_colorterm = 0
vim.g.dracula_full_special_attrs_support = 1
vim.o.termguicolors = true
vim.cmd('colorscheme dracula')

-- basics
vim.o.list = true
vim.o.listchars = "tab:» ,trail:·"
vim.o.mouse = 'a'
vim.o.relativenumber = true
vim.o.title = true
vim.o.cursorline = true
vim.o.tabstop, vim.o.shiftwidth = 4, 4
vim.o.smartindent = true
vim.o.history = 50

vim.g.mapleader = " "
vim.g.python3_host_prog = '$HOME/.pyenv/versions/neovim3/bin/python'

local function mapkey(mode, key, cmd)
    vim.api.nvim_set_keymap(mode, key, cmd, { noremap = true })
end

mapkey('n', '<C-h>', '<C-w>h')
mapkey('n', '<C-j>', '<C-w>j')
mapkey('n', '<C-k>', '<C-w>k')
mapkey('n', '<C-l>', '<C-w>l')
mapkey('n', 'tc', ':NvimTreeFindFile<cr>')
mapkey('n', 'td', ':tabnew %:p:h<cr>')
mapkey('n', 'th', ':split<cr>')
mapkey('n', 'tn', ':tabnext<cr>')
mapkey('n', 'tp', ':tabprev<cr>')
mapkey('n', 'ts', ':vsplit<cr>') -- this variant tries to split quickfix windows too, may no longer be necessary :vertical botright split<cr>

mapkey('n', '<leader>ld', ':lua vim.lsp.buf.definition()<cr>')
mapkey('n', '<leader>lr', ':lua vim.lsp.buf.references()<cr>')
mapkey('n', '<leader>ls', ':lua vim.lsp.buf.signature_help()<cr>')

mapkey('c', '<C-e>', '<C-R>=expand("$VIRTUAL_ENV/lib/python*/site-packages/")<cr>')
mapkey('c', '<C-s>', '<C-R>=expand("%:p:h")<cr>/')

mapkey('n', '<Leader>ev', ':tabe $MYVIMRC<cr>')
mapkey('n', '<leader>ep', ':lua require"telescope.builtin".find_files({cwd="~/.local/share/nvim/site/pack/packer/start"})<cr>')
mapkey('n', '<leader>en', ':lua require"telescope.builtin".find_files({cwd="~/.config/nvim"})<cr>')
mapkey('n', '<leader>gp', ':lua require"telescope.builtin".live_grep({cwd="~/.local/share/nvim/site/pack/packer/start"})<cr>')
mapkey('n', '<Leader>sv', ':source $MYVIMRC<cr>:bufdo e<cr>')

mapkey('n', '<leader>ef', ':lua require"telescope.builtin".find_files()<cr>')
mapkey('n', '<leader>ea', ':lua require"telescope.builtin".find_files({no_ignore=true})<cr>')
mapkey('n', '<leader>gf', ':lua require"telescope.builtin".live_grep()<cr>')
mapkey('n', '<leader>ga', ':lua require"telescope.builtin".live_grep({no_ignore=true})<cr>')

--local reload = require('plenary.reload').reload_module
require 'lsp-config'
require 'cmp-config'
require 'feline-config'
require 'telescope-config'

require('gitsigns').setup({
    current_line_blame = true,
})
require('nvim-tree').setup({
    hijack_cursor = true,
    git = {
        ignore = false,
    },
    view = {
        adaptive_size = true,
        relativenumber = true,
        width = 50,
    }
})
require 'illuminate'

--require'nvim-treesitter.configs'.setup {
--  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
--  ensure_installed = "maintained",
--
--  -- Install languages synchronously (only applied to `ensure_installed`)
--  sync_install = false,
--
--  -- List of parsers to ignore installing
--  ignore_install = { "javascript" },
--
--  highlight = {
--    -- `false` will disable the whole extension
--    enable = false,
--
--    -- list of language that will be disabled
--    disable = { "c", "rust" },
--
--    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
--    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
--    -- Using this option may slow down your editor, and you may see some duplicate highlights.
--    -- Instead of true it can also be a list of languages
--    additional_vim_regex_highlighting = false,
--  },
--}
