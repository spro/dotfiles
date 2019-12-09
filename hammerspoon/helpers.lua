function inspect(o)
    for i, v in ipairs(o) do
        print(i, v)
    end
end

function filter(l, fn)
    local filtered = {}
    for i, value in pairs(l) do
        if fn(value) then
            table.insert(filtered, value)
        end
    end
    return filtered
end
