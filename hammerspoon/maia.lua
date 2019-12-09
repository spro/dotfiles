-- Maia 
-- TODO: Revive
--------------------------------------------------------------------------------

function maiaCommand(command, cb)
    hs.http.asyncPost("http://withmaia.com/command.json", hs.json.encode({body=command}), {['Content-Type']='application/json'}, function(status, response)
        local response = hs.json.decode(response)
        cb(response)
    end)
end

-- Prompt choices

icons = {
    lightbulb = hs.image.imageFromPath("~/.hammerspoon/icons/lightbulb-white.png"),
    lightbulb_off = hs.image.imageFromPath("~/.hammerspoon/icons/lightbulb_off-white.png"),
    sun = hs.image.imageFromPath("~/.hammerspoon/icons/sun-white.png"),
    sun_off = hs.image.imageFromPath("~/.hammerspoon/icons/sun_off-white.png"),
    volume = hs.image.imageFromPath("~/.hammerspoon/icons/volume-white.png"),
}

default_choices = {
    {text = "turn on the office light", image = icons.lightbulb},
    {text = "turn off the office light", image = icons.lightbulb},
    {text = "turn on the living room light", image = icons.lightbulb},
    {text = "turn off the living room light", image = icons.lightbulb},
    {text = "turn on all the lights", image = icons.lightbulb},
    {text = "turn off all the lights", image = icons.lightbulb},
    {text = "turn the music up", image = icons.volume},
    {text = "turn the music down", image = icons.volume},
}

function maiaPrompt()
    function chose(something)
        print('chose', something.text)
        print(hs.json.encode({command=something.text}))
        maiaCommand(something.text, function(response)
            local parsed = table.concat(response.parsed, ' ')
            if type(response.response) == 'table' then
                response_str = hs.json.encode(response.response)
            else
                response_str = tostring(response.response)
            end
            hs.notify.new({title=parsed, informativeText=response_str}):send()
        end)
    end

    c = hs.chooser.new(chose)
    c:rows(6)
    c:width(45)
    c:choices(default_choices)
    c:queryChangedCallback(function (query)
        if #query > 0 then
            c:choices({{text=query}})
        else
            c:choices(default_choices)
        end
    end)

    c:bgDark(true)
    c:show()
end

-- Open the maia prompt
-- <Ctrl + Alt + Cmd + M>

hs.hotkey.bind({"ctrl", "alt", "cmd"}, "M", maiaPrompt)


