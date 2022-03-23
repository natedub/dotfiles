local telescope = require 'telescope'

telescope.setup()

local M = {}

M.edit_plugins = function()
    require('telescope.builtin').find_files({
        cwd = '~/.local/share/nvim/site/pack/packer/start'
    })
end
return M
