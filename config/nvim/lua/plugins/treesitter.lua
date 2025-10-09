return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { "lua", "vim", "markdown", "typescript", "tsx", "javascript", "css", "html", "htmldjango", "go", "ruby", "scala", "gleam" },
                sync_install = false,
                auto_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    }
}
