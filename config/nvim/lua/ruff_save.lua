--  ~/.config/nvim/lua/ruff_on_save.lua  (source it from init.lua)

-- Pick the first runner that exists on the system / in the project
local function ruff_cmd()
    if vim.fn.executable('uv') == 1 then
        return { 'uv', 'run', 'ruff' }
    elseif vim.fn.executable('poetry') == 1 then
        return { 'poetry', 'run', 'ruff' }
    elseif vim.fn.executable('ruff') == 1 then
        return { 'ruff' }
    end
end

local aug = vim.api.nvim_create_augroup('RuffOnSave', { clear = true })

function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

function concat(t1, t2)
    for i = 1, #t2 do
        t1[#t1 + 1] = t2[i]
    end
    return t1
end

vim.api.nvim_create_autocmd('BufWritePost', {
    group    = aug,
    pattern  = '*.py',
    callback = function(ev)
        local base = ruff_cmd()
        if not base then return end -- Ruff not available → do nothing

        local file = vim.fn.fnameescape(ev.match)
        local cmd  = concat(base, { 'format', file })
        -- print(dump(cmd))

        -- run asynchronously so the UI never blocks
        vim.fn.jobstart(cmd, {
            stdout_buffered = true,
            stderr_buffered = true,
            on_exit = function(_, code)
                -- reload buffer if Ruff changed the file on disk
                if code == 0 then vim.cmd('checktime ' .. ev.buf) end
            end,
        })
    end,
})
