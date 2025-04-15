local hs = hs

-- Resizing / moving windows
--------------------------------------------------------------------------------

hs.window.animationDuration = 0.1

local move_amount = 200
local move_more_amount = 500

function moveLeft(f) f.x = f.x - move_amount end
function moveRight(f) f.x = f.x + move_amount end
function moveUp(f) f.y = f.y - move_amount end
function moveDown(f) f.y = f.y + move_amount end

function moveFullScreen(win, screen)
    win:moveToScreen(screen, true, true, 0)
    win:setFrame(screen:frame(), 0)
end

function moveScreenLeft()
    local win = hs.window.focusedWindow()
    moveFullScreen(win, win:screen():toWest())
end

function moveScreenRight()
    local win = hs.window.focusedWindow()
    moveFullScreen(win, win:screen():toEast())
end

function moveScreenUp()
    local win = hs.window.focusedWindow()
    moveFullScreen(win, win:screen():toNorth())
end

function moveScreenDown()
    local win = hs.window.focusedWindow()
    moveFullScreen(win, win:screen():toSouth())
end

function resizeFull(f, win)
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h
end

function resizeHorizontal(width, start)
    return function (f, win)
        local screen = win:screen()
        local max = screen:frame()
        f.x = max.x + max.w * start
        f.y = max.y
        f.w = max.w * width
        f.h = max.h
    end
end

function resizeVertical(height, start, keepHeight)
    return function (f, win)
        local screen = win:screen()
        local max = screen:frame()
        f.y = max.y + max.h * start
        f.h = max.h * height
        if not keepHeight then
            f.x = max.x
            f.w = max.w
        end
    end
end

-- Corners
-- ------------

function resizeTopLeft(f, win)
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x
    f.y = max.y
    f.w = max.w * 0.5
    f.h = max.h * 0.5
end

function resizeTopRight(f, win)
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x + max.w * 0.5
    f.y = max.y
    f.w = max.w * 0.5
    f.h = max.h * 0.5
end

function resizeBottomLeft(f, win)
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x
    f.y = max.y + max.h * 0.5
    f.w = max.w * 0.5
    f.h = max.h * 0.5
end

function resizeBottomRight(f, win)
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x + max.w * 0.5
    f.y = max.y + max.h * 0.5
    f.w = max.w * 0.5
    f.h = max.h * 0.5
end

-- Halves
-- ------------

resizeLeftHalf = resizeHorizontal(0.5, 0)
resizeRightHalf = resizeHorizontal(0.5, 0.5)
resizeTopHalf = resizeVertical(0.5, 0)
resizeBottomHalf = resizeVertical(0.5, 0.5)

function resizeLeftToEdge(f, win)
    local screen = win:screen()
    local max = screen:frame()
    f.w = f.w + (max.x + f.x)
    f.x = max.x
end

function resizeRightToEdge(f, win)
    local screen = win:screen()
    local max = screen:frame()
    f.w = f.w + (max.x + max.w - f.x)
end

function resizeLeft(f) f.w = f.w - move_amount end
function resizeRight(f) f.w = f.w + move_amount end
function resizeUp(f) f.h = f.h - move_amount end
function resizeDown(f) f.h = f.h + move_amount end

function resizeCenter(size)
    return function (f, win)
	local screen = win:screen()
	local max = screen:frame()
	f.x = max.x + max.w * (1.0 - size) / 2.0
	f.w = max.w * size
	f.y = max.y + max.h * (1.0 - size) / 2.0
	f.h = max.h * size
    end
end

function resizeTo1080p()
    return function (f, win)
        local screen = win:screen()
        local max = screen:frame()

        -- Set width and height to 1080p dimensions
        f.w = 1920
        f.h = 1080

        -- Center the window on the screen
        f.x = max.x + (max.w - f.w) / 2
        f.y = max.y + (max.h - f.h) / 2
    end
end

-- Note: This is what actually sets the window frame, above functions only build the frame description
function adjustWindow(mover)
    doMove = function()
        local win = hs.window.focusedWindow()
        local f = win:frame()
        mover(f, win)
        win:setFrame(f)
    end
    return doMove
end

hs.hotkey.bind({"ctrl", "alt", "cmd"}, "H", adjustWindow(moveLeft))
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "L", adjustWindow(moveRight))
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "K", adjustWindow(moveUp))
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "J", adjustWindow(moveDown))

hs.hotkey.bind({"ctrl", "alt", "cmd", "shift"}, "H", moveScreenLeft)
hs.hotkey.bind({"ctrl", "alt", "cmd", "shift"}, "L", moveScreenRight)
hs.hotkey.bind({"ctrl", "alt", "cmd", "shift"}, "K", moveScreenUp)
hs.hotkey.bind({"ctrl", "alt", "cmd", "shift"}, "J", moveScreenDown)

hs.hotkey.bind({"ctrl", "alt"}, "H", adjustWindow(resizeLeft))
hs.hotkey.bind({"ctrl", "alt"}, "L", adjustWindow(resizeRight))
hs.hotkey.bind({"ctrl", "alt"}, "K", adjustWindow(resizeUp))
hs.hotkey.bind({"ctrl", "alt"}, "J", adjustWindow(resizeDown))

hs.hotkey.bind({"ctrl", "cmd"}, "F", adjustWindow(resizeFull))
hs.hotkey.bind({"ctrl", "cmd"}, "H", adjustWindow(resizeLeftHalf))
hs.hotkey.bind({"ctrl", "cmd"}, "L", adjustWindow(resizeHorizontal(0.5, 0.5)))
hs.hotkey.bind({"ctrl", "cmd"}, "K", adjustWindow(resizeTopHalf))
hs.hotkey.bind({"ctrl", "cmd"}, "J", adjustWindow(resizeBottomHalf))

hs.hotkey.bind({"ctrl", "cmd", "shift"}, "K", adjustWindow(resizeVertical(0.5, 0, true)))
hs.hotkey.bind({"ctrl", "cmd", "shift"}, "J", adjustWindow(resizeVertical(0.5, 0.5, true)))

-- hs.hotkey.bind({"ctrl", "cmd"}, "G", adjustWindow(resizeLeftToEdge))
-- hs.hotkey.bind({"ctrl", "cmd"}, ";", adjustWindow(resizeRightToEdge))
hs.hotkey.bind({"ctrl", "cmd"}, "G", adjustWindow(resizeHorizontal(0.333, 0)))
-- hs.hotkey.bind({"ctrl", "cmd"}, "C", adjustWindow(resizeHorizontal(0.333, 0.333)))
hs.hotkey.bind({"ctrl", "cmd"}, "C", adjustWindow(resizeCenter(0.5)))
hs.hotkey.bind({"ctrl", "cmd", "shift"}, "C", adjustWindow(resizeCenter(0.75)))
hs.hotkey.bind({"ctrl", "cmd"}, "1", adjustWindow(resizeTo1080p()))
hs.hotkey.bind({"ctrl", "cmd"}, ";", adjustWindow(resizeHorizontal(0.333, 0.666)))

hs.hotkey.bind({"ctrl", "cmd"}, "u", adjustWindow(resizeTopLeft))
hs.hotkey.bind({"ctrl", "cmd"}, "n", adjustWindow(resizeBottomLeft))
hs.hotkey.bind({"ctrl", "cmd"}, "o", adjustWindow(resizeTopRight))
hs.hotkey.bind({"ctrl", "cmd"}, ".", adjustWindow(resizeBottomRight))

hs.hotkey.bind({"alt", "cmd"}, "H", hs.window.filter.focusWest)
hs.hotkey.bind({"alt", "cmd"}, "L", hs.window.filter.focusEast)
hs.hotkey.bind({"alt", "cmd"}, "K", hs.window.filter.focusNorth)
hs.hotkey.bind({"alt", "cmd"}, "J", hs.window.filter.focusSouth)
