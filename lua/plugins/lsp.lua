return {
    {
        "williamboman/mason.nvim",
        lazy = true,
        config = function()
            require('mason').setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            auto_install = true,
        },
        config = function()
            local lspconfig = require('lspconfig')

            require('mason-lspconfig').setup({
                handlers = {
                    function(server_name)
                        lspconfig[server_name].setup {}
                    end,

                    omnisharp = function()
                        lspconfig.omnisharp.setup({
                            handlers = {
                                ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
                                ["textDocument/references"] = require('omnisharp_extended').references_handler,
                                ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
                                ["textDocument/hover"] = function(_, result, ctx, config)
                                    if result == nil then
                                        vim.notify("No information available", vim.log.levels.INFO)
                                        return
                                    end
                    
                                    -- Call the original hover handler if the result is valid
                                    vim.lsp.handlers["textDocument/hover"](nil, result, ctx, config)
                                end
                            },
                            capabilities = require('cmp_nvim_lsp').default_capabilities(),
                            enable_roslyn_analysers = true,
                            enable_import_completion = true,
                            organize_imports_on_format = true,
                            enable_decompilation_support = true,
                            filetypes = { 'cs', 'csproj', 'sln' },
                        })

                        -- Set custom key mappings
                        vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
                        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
                        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
                        vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
                        vim.keymap.set('n', 'ca', vim.lsp.buf.code_action, { buffer = bufnr }) -- possible fixes
                    end
                },
                ensure_installed = { "omnisharp" }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
    },
    {
        "Hoffs/omnisharp-extended-lsp.nvim",
        lazy = true,
    },
    {
        'nvimtools/none-ls.nvim',
        lazy = true,
        config = function()
            local null_ls = require('null-ls')
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.csharpier
                }
            })
        end
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        config = function()
            require('mason-null-ls').setup({
                automatic_setup = true
            })
        end,
    },
    {
        'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        event = "BufReadPre",
        config = function()
            require('lsp_lines').setup()
    
            -- Set virtual lines to always be on and virtual text to be off
            vim.diagnostic.config({
                virtual_lines = true,
                virtual_text = false
            })
        end
    }
}