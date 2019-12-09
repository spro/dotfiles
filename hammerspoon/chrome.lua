hs.ax = require 'hs._asm.axuielement'

function hasTabs(hs_window)
    local ax_window = hs.ax.windowElement(hs_window)
    tab_groups = ax_window:elementSearch('AXTabGroup')
    return (tab_groups ~= nil) and (tab_groups[1] ~= nil)
end

function getChromeTabTitles(hs_window)
    local ax_window = hs.ax.windowElement(hs_window)
    local tab_group = ax_window:elementSearch('AXTabGroup')[1]
    local tabs = tab_group:attributeValue('AXChildren')
    local tab_titles = {}
    for i, tab in pairs(tabs) do
        local title = tab:attributeValue('AXTitle')
        table.insert(tab_titles, title)
    end
    return tab_titles
end
