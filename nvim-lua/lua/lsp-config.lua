--local lspconfig = require("lspconfig")
--local null_ls = require("null-ls")

--local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
--local util = require 'vim.lsp.util'

--null_ls.setup({
--    debug = false,
--    sources = {
--        null_ls.builtins.formatting.prettier
--    },
--    on_attach = function(client)
--        if client.resolved_capabilities.document_formatting then
--            vim.cmd([[
--            augroup LspFormatting
--                autocmd! * <buffer>
--                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
--            augroup END
--            ]])
--        end
--
--        -- highlight the word under the cursor
--        require 'illuminate'.on_attach(client)
--    end,
--})

--lspconfig.tsserver.setup({
--    init_options = require("nvim-lsp-ts-utils").init_options,
--    on_attach = function(client, bufnr)
--        local ts_utils = require("nvim-lsp-ts-utils")
--
--        client.resolved_capabilities.document_formatting = false
--        client.resolved_capabilities.document_range_formatting = false
--
--        ts_utils.setup({
--            debug = false,
--            enable_import_on_completion = true,
--            auto_inlay_hints = true,
--        })
--        ts_utils.setup_client(client)
--
--        -- no default maps, so you may want to define some here
--        --local opts = { silent = true }
--        --vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>si", ":TSLspOrganize<CR>", opts)
--        --vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>fi", ":TSLspImportAll<CR>", opts)
--
--        --require 'illuminate'.on_attach(client)
--    end,
--})

require("typescript").setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    go_to_source_definition = {
        fallback = true, -- fall back to standard LSP definition on failure
    },
    server = { -- pass options to lspconfig's setup method
        on_attach = ...,
    },
})
