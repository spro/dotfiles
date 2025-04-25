require 'helpers'
require 'resizing'
require 'glucose'

-- Quick set brightness to 50%
-- Cmd + Alt + Ctrl + W

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "W", function()
    -- hs.notify.new({title="Hello world!", informativeText="Here is some more stuff!"}):send() -- Notification
    -- hs.alert.show("Goodbye world!") -- Overlay
    hs.brightness.set(50)
end)

-- Smaller utilities
--------------------------------------------------------------------------------

-- Paste by typing each key (for inputs that don't allow paste)
-- <Alt + Cmd + V>

function typeClipboard()
    hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end

hs.hotkey.bind({ "alt", "cmd" }, "V", typeClipboard)

-- Show the Hammerspoon console
-- <Ctrl + Alt + Cmd + C>

hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "C", function() hs.console.show() end)

-- URL handler
-- TODO: What was this for

hs.urlevent.bind("someAlert", function(eventName, params)
    hs.alert.show("Some alert?")
end)

-- Reloading config
--------------------------------------------------------------------------------

function reloadConfig(files)
    doReload = false
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

-- Automatic reload
-- hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon", reloadConfig):start()

-- Manual reload
-- <Ctrl + Alt + Cmd + R>
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "R", function() reloadConfig({ 'init.lua' }) end)

--------------------------------------------------------------------------------

hs.alert.show("Loaded Hammerspoon config")
