
hs.application.enableSpotlightForNameSearches(true)

-- Layouts
--------------------------------------------------------------------------------

getScreen = function(id)
    getter = function()
        return hs.screen.find(id)
    end
    return getter
end

display_laptop = getScreen('-1,0')
display_middle = getScreen('0,0')
display_right = getScreen('1,0')

function windowsWithTab(tab_title)
    return function(app_name) -- We know app name is always Google Chrome but w/e
        local chrome_windows = hs.application.get(app_name):visibleWindows()
        chrome_windows = filter(chrome_windows, hasTabs)
        return filter(chrome_windows, hasTab(tab_title))
    end
end

function hasTab(match_tab_title)
    return function(hs_window)
        local tab_titles = getChromeTabTitles(hs_window)
        local has_tab = false
        for i, tab_title in pairs(tab_titles) do
            if string.match(tab_title, match_tab_title) then
                return true
            end
        end
        return false
    end
end

--  {"App name", "Window name", "Display Name", "unitrect", "framerect", "fullframerect"}

office_layout = {
    {nil, ".*", display_middle, nil, nil, nil},
    {"Google Chrome", nil, display_middle, hs.layout.right50, nil, nil},
    {"Google Chrome", windowsWithTab("Nexus"), display_laptop, hs.layout.maximized, nil, nil},
    {"iTerm2", nil, display_middle, hs.layout.left50, nil, nil},
    {"iTerm2", "logs", display_right, hs.layout.maximized, nil, nil},
    {"TextEdit", nil, display_right, nil, nil, nil},
    {"MacDown", nil, display_right, nil, nil, nil},
}

-- Watch for screen count changes (plugging in all 3) to trigger layouts
--------------------------------------------------------------------------------

windowTitleComparator = function(window_title, layout_title)
    print('window_title =', window_title)
    return string.match(window_title, layout_title)
end

onScreensChanged = function()
    n_screens = #hs.screen.allScreens()
    print('n_screens =', n_screens)

    -- If unplugging screens, turn the main brightness to 50%
    if n_screens == 1 and hs.brightness.get() == 0 then
        hs.brightness.set(50)
    end

    -- If plugging in screens, distribute windows with above office layout
    if n_screens == 3 then
        hs.layout.apply(office_layout, windowTitleComparator)
    end
end

local timer = null
debouncedOnScreensChanged = function()
    if (timer) then
        timer:stop()
    end
    timer = hs.timer.doAfter(5, onScreensChanged)
end
screenWatcher = hs.screen.watcher.new(debouncedOnScreensChanged)
screenWatcher:start()

onScreensChanged()


