local glucose_url = hs.settings.get("glucose_url")

if glucose_url == nil then
    hs.notify.new({
        title = "Glucose menubar error",
        informativeText = 'use hs.settings.set("glucose_url", "...")',
    }):send()
    return
end

local glucose_menuitem = hs.menubar.new()

function updateGlucose()
    print("[updateGlucose] Loading...")
    glucose_menuitem:setTitle("...")

    -- Make request
    local status, body = hs.http.get(glucose_url)
    if body == nil then return end

    -- Decode latest
    local response = hs.json.decode(body)
    local latest = response["latest"]

    -- Get min/max values
    local values = {}
    local v_min = 500
    local v_max = 0
    for i, l in ipairs(latest) do
        local v = l["value"]
        if v < v_min then
            v_min = v
        end
        if v > v_max then
            v_max = v
        end
        table.insert(values, v)
    end

    values = reverse(values)

    -- Set up canvas
    local a = hs.canvas.new { h = 16, w = 64 }
    a[1] = {
        type = "segments",
        closed = false,
        action = "stroke",
        strokeColor = { red = 1, green = 1 },
        strokeWidth = 2
    }

    -- Build bar graph
    local z = {}
    for x = 1, #values do
        local v = values[x]
        table.insert(z, {
            x = x - 1,
            y = 16 - (v - v_min) / (v_max - v_min) * 16
        })
    end
    a[1].coordinates = z

    -- Set icon and value
    glucose_menuitem:setIcon(a:imageFromCanvas())
    glucose_menuitem:setTitle(values[#values])

    print("[updateGlucose] Done")
end

updateTimer = hs.timer.doEvery(60, function() updateGlucose() end)
updateGlucose()

glucose_menuitem:setClickCallback(updateGlucose)
