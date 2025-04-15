-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Set up `mapleader` and `maplocalleader` before loading
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- Navigation between panes and tmux with Ctrl-hjkl
        "christoomey/vim-tmux-navigator",

        -- :S command for case-varying substitutions
        "tpope/vim-abolish",

        -- Comment stuff with gcc
        "tpope/vim-commentary",

        -- Better surround commands like cs, ds, yss, ysiw
        "tpope/vim-surround",

        -- For Ctrl-P fuzzy file search
        "nvim-telescope/telescope.nvim",

        -- Color scheme
        {
            "rebelot/kanagawa.nvim",
            lazy = false,
            priority = 1000,
            opts = {},
            config = function()
                require('kanagawa').setup({
                    transparent = true,
                })
            end
        },

        -- Plugins defined in lua/plugins/*.lua
        { import = "plugins" }
    },
    install = { colorscheme = { "default" } },
    checker = { enabled = true },
})
