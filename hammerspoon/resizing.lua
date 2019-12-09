-- Resizing / moving windows
--------------------------------------------------------------------------------

hs.window.animationDuration = 0.1

move_amount = 200
move_more_amount = 500

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

function resizeFull(f, win)
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h
end

function resizeHalfLeft(f, win)
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
end

function resizeHalfRight(f, win)
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x + max.w / 2
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
end

function resizeHalfTop(f, win)
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h / 2
end

function resizeHalfBottom(f, win)
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x
    f.y = max.y + max.h / 2
    f.w = max.w
    f.h = max.h / 2
end

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

hs.hotkey.bind({"ctrl", "alt"}, "H", adjustWindow(resizeLeft))
hs.hotkey.bind({"ctrl", "alt"}, "L", adjustWindow(resizeRight))
hs.hotkey.bind({"ctrl", "alt"}, "K", adjustWindow(resizeUp))
hs.hotkey.bind({"ctrl", "alt"}, "J", adjustWindow(resizeDown))

hs.hotkey.bind({"ctrl", "cmd"}, "F", adjustWindow(resizeFull))
hs.hotkey.bind({"ctrl", "cmd"}, "H", adjustWindow(resizeHalfLeft))
hs.hotkey.bind({"ctrl", "cmd"}, "L", adjustWindow(resizeHalfRight))
hs.hotkey.bind({"ctrl", "cmd"}, "K", adjustWindow(resizeHalfTop))
hs.hotkey.bind({"ctrl", "cmd"}, "J", adjustWindow(resizeHalfBottom))

hs.hotkey.bind({"ctrl", "cmd"}, "G", adjustWindow(resizeLeftToEdge))
hs.hotkey.bind({"ctrl", "cmd"}, ";", adjustWindow(resizeRightToEdge))

hs.hotkey.bind({"alt", "cmd"}, "H", hs.window.filter.focusWest)
hs.hotkey.bind({"alt", "cmd"}, "L", hs.window.filter.focusEast)
hs.hotkey.bind({"alt", "cmd"}, "K", hs.window.filter.focusNorth)
hs.hotkey.bind({"alt", "cmd"}, "J", hs.window.filter.focusSouth)


