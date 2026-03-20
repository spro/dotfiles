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
local function project_root(bufnr)
    local markers = {
        "tsconfig.json",
        "jsconfig.json",
        "package.json",
        "vite.config.ts",
        "vite.config.js",
        "vite.config.mts",
        "vite.config.mjs",
        ".git",
    }
    bufnr = bufnr or 0

    for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
        if client.root_dir and client.root_dir ~= "" then
            return client.root_dir
        end
    end

    local current = vim.api.nvim_buf_get_name(bufnr)
    if current == "" then
        current = vim.uv.cwd()
    end

    return vim.fs.root(current, markers) or vim.uv.cwd()
end

require('telescope').setup {
    defaults = {
        file_ignore_patterns = {
            "node_modules/",
            ".git/",
            "dist/",
            "build/",
            "coverage/",
        },
        path_display = { "smart" },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
    },
}
vim.keymap.set('n', '<C-P>', telescope.find_files)
vim.keymap.set('n', '<C-F>', telescope.live_grep)
vim.keymap.set('n', '<leader>p', function()
    telescope.find_files({ cwd = project_root(0) })
end, { desc = "Find project files" })
vim.keymap.set('n', '<leader>/', function()
    telescope.live_grep({ cwd = project_root(0) })
end, { desc = "Grep project" })

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    callback = function()
        vim.opt_local.path:append({ "src", "src/**" })
        vim.opt_local.suffixesadd:append({
            ".ts",
            ".tsx",
            ".js",
            ".jsx",
            ".d.ts",
            "/index.ts",
            "/index.tsx",
            "/index.js",
            "/index.jsx",
        })
    end,
})

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

-- vim.api.nvim_create_autocmd("BufWritePre", {
--     pattern = "*",
--     callback = function(args)
--         require("conform").format({ bufnr = args.buf })
--     end
-- })
