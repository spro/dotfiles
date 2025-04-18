return {
    {
        "neovim/nvim-lspconfig",

        dependencies = {
            -- specifically for editing vim lua scripts
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },

        config = function()
            local lspconfig = require('lspconfig')
            lspconfig.lua_ls.setup {}
            lspconfig.ts_ls.setup {}

            vim.keymap.set("n", "<space>f", vim.lsp.buf.format)

            vim.keymap.set("n", "ge", vim.diagnostic.open_float)

            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if not client then return end

                    if client.supports_method('textDocument/formatting') then
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                            end,
                        })
                    end
                end
            })
        end
    }
}
