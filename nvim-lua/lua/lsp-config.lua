local lspconfig = require("lspconfig")
local null_ls = require("null-ls")

null_ls.setup({
    debug = true,
    sources = {
        null_ls.builtins.diagnostics.eslint_d, -- eslint or eslint_d
        null_ls.builtins.code_actions.eslint_d, -- eslint or eslint_d
        null_ls.builtins.formatting.prettier -- prettier, eslint, eslint_d, or prettierd
    },
    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
        end

        require 'illuminate'.on_attach(client)
    end,
})

lspconfig.tsserver.setup({
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    init_options = require("nvim-lsp-ts-utils").init_options,
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false

        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({
            debug = true,
            enable_import_on_completion = true,
            auto_inlay_hints = false,
        })
        ts_utils.setup_client(client)

        -- no default maps, so you may want to define some here
        local opts = { silent = true }
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>si", ":TSLspOrganize<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>fi", ":TSLspImportAll<CR>", opts)

        require 'illuminate'.on_attach(client)
    end,
})
