-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = false, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        clipboard = "",
        relativenumber = true,
        number = true,
        spell = false,
        wrap = true,
        list = true,
        listchars = "tab:» ,trail:·",

        hlsearch = false,
        incsearch = true,

        tabstop = 4,
        shiftwidth = 4,
        smartindent = true,

        signcolumn = "yes",
        scrolloff = 8,

        swapfile = false,
        backup = false,
        undodir = os.getenv "HOME" .. "/.vim/undodir",
        undofile = true,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,

        -- MINE
        ["<C-h>"] = { "<C-w>h" },
        ["<C-j>"] = { "<C-w>j" },
        ["<C-k>"] = { "<C-w>k" },
        ["<C-l>"] = { "<C-w>l" },

        -- Center cursor when scrolling by half page or searching
        ["<C-d>"] = { "<C-d>zz" },
        ["<C-u>"] = { "<C-u>zz" },
        ["n"] = { "nzzzv" },
        ["N"] = { "Nzzzv" },

        -- Tab navigation
        ["td"] = { ":tabnew %:p:h<cr>", desc = "New tab with current file's directory listing" },
        ["th"] = { ":split<cr>", desc = "Horizontal split" },
        ["tn"] = { ":tabnext<cr>", desc = "New tab" },
        ["tp"] = { ":tabprev<cr>", desc = "Previous tab" },
        ["ts"] = { ":vsplit<cr>", desc = "Vertical split" },
        -- this variant tries to split quickfix windows too, may no longer be necessary :vertical botright split<cr,

        ["<Leader>ev"] = { ":tabe ~/.config/nvim/lua/plugins/<cr>", desc = "Open vimrc" },
        ["<Leader>sv"] = { function() require("astrocore").reload() end, desc = "Reload Astronvim (experimental)" },
      },
      c = {
        ["<C-s>"] = { '<C-R>=expand("%:p:h")<cr>/', desc = "" },
        ["<C-e>"] = { '<C-R>=expand("~/Code/dotfiles/astronvim/lua")<cr>/', desc = "" },
      },
      x = {
        ["<Leader>p"] = '"_dP',
      },
    },
  },
}
