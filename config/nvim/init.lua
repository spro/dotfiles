-- Indentation
vim.o.autoindent = true
vim.o.smarttab = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.backspace = "2"

-- Searching
vim.o.gdefault = true
vim.o.laststatus = 2
vim.o.showmatch = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"

-- Dividers & splits
vim.o.splitbelow = true
vim.o.splitright = true

-- Set leader to ","
vim.g.mapleader = ","

-- Clear search highlight with <leader><space>
vim.api.nvim_set_keymap('n', '<leader><space>', ':nohlsearch<CR>', { noremap = true, silent = true })

require("config.lazy")

-- Open fzf file search with Ctrl-P
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<C-P>', telescope.find_files)

require("conform").setup({
    default_format_opts = { lsp_format = "fallback" },
    formatters_by_ft = {
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        javascript = { "prettier" },
        json = { "prettier" },
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
    },
    log_level = vim.log.levels.DEBUG,
})
