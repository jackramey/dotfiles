-- Remove animations
hs.window.animationDuration=0

HyperKey = {"cmd", "alt", "ctrl"}
VyperKey = {"cmd", "alt", "ctrl", "shift"}

---------------------
-- Resize Bindings --
---------------------

function Middle(wPercent, hPercent)
    return function()
        local win = hs.window.focusedWindow()
        local frame = win:screen():frame()
        if wPercent < 1 then
            local width = frame.w * wPercent
            local wgap = frame.w - width
            frame.w = width
            frame.x = frame.x + (wgap / 2)
        end
        if hPercent < 1 then
            local height = frame.h * hPercent
            local hgap = frame.h - height
            frame.h = height
            frame.y = frame.y + (hgap / 2)
        end
        win:setFrame(frame)
    end
end

function Full()
    return Middle(1,1)
end

function Center(percent)
    return Middle(percent, 1)
end

function Top(percent)
    return function()
        local win = hs.window.focusedWindow()
        local frame = win:screen():frame()
        if percent < 1 then
            local height = frame.h * percent
            frame.h = height
        end
        win:setFrame(frame)
    end
end

function Bottom(percent)
    return function()
        local win = hs.window.focusedWindow()
        local frame = win:screen():frame()
        if percent < 1 then
            local height = frame.h * percent
            local hgap = frame.h - height
            frame.h = height
            frame.y = frame.y + hgap
        end
        win:setFrame(frame)
    end
end

function Left(percent)
    return LeftTop(percent, 1)
end

function LeftTop(wPercent, hPercent)
    return function()
        local win = hs.window.focusedWindow()
        local frame = win:screen():frame()
        frame.w = frame.w * wPercent
        if hPercent < 1 then
            frame.h = frame.h * hPercent
        end
        win:setFrame(frame)
    end
end

function LeftBot(wPercent, hPercent)
    return function()
        local win = hs.window.focusedWindow()
        local frame = win:screen():frame()
        frame.w = frame.w * wPercent
        if hPercent < 1 then
            local height = frame.h * hPercent
            local hgap = frame.h * (1.0 - hPercent)
            frame.h = height
            frame.y = frame.y + hgap
        end
        win:setFrame(frame)
    end
end

function Right(percent)
    return RightTop(percent, 1)
end

function RightTop(wPercent, hPercent)
    return function()
        local win = hs.window.focusedWindow()
        local frame = win:screen():frame()
        frame.x = frame.x + (frame.w - frame.w * wPercent)
        frame.w = frame.w * wPercent
        if hPercent < 1 then
            frame.h = frame.h * hPercent
        end
        win:setFrame(frame)
    end
end

function RightBot(wPercent, hPercent)
    return function()
        local win = hs.window.focusedWindow()
        local frame = win:screen():frame()
        frame.x = frame.x + (frame.w - frame.w * wPercent)
        frame.w = frame.w * wPercent
        if hPercent < 1 then
            local height = frame.h * hPercent
            local hgap = frame.h * (1.0 - hPercent)
            frame.h = height
            frame.y = frame.y + hgap
        end
        win:setFrame(frame)
    end
end

function ExtendLeft(pixels)
    return function()
        local win = hs.window.focusedWindow()
        local frame = win:frame()
        frame.x = frame.x - pixels
        frame.w = frame.w + pixels
        win:setFrame(frame)
    end
end

function ShrinkLeft(pixels)
    return function()
        local win = hs.window.focusedWindow()
        local frame = win:frame()
        frame.x = frame.x + pixels
        frame.w = frame.w - pixels
        win:setFrame(frame)
    end
end

function ExtendRight(pixels)
    return function()
        local win = hs.window.focusedWindow()
        local frame = win:frame()
        frame.w = frame.w + pixels
        win:setFrame(frame)
    end
end

function ShrinkRight(pixels)
    return function()
        local win = hs.window.focusedWindow()
        local frame = win:frame()
        frame.w = frame.w - pixels
        win:setFrame(frame)
    end
end

function NextScreen()
    return function()
        local win = hs.window.focusedWindow()
        local winFrame = win:frame()
        local screen = win:screen()
        local frame = screen:frame()
        local nextScreen = screen:next()
        local nextFrame = nextScreen:frame()
        local dx = winFrame.x - frame.x
        local dy = winFrame.y - frame.y
        winFrame.x = nextFrame.x + dx
        winFrame.y = nextFrame.y + dy
        win:setFrame(winFrame)
    end
end

function printFrame(frameName, frame)
    hs.printf(frameName .. ": " .. frame.w .. " " .. frame.h)
    hs.printf(frameName .. ": " .. frame.x .. " " .. frame.y)
end


--------------------
-- Focus Bindings --
--------------------

switcher = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{})
switcher.ui.showTitles = true
switcher.ui.showThumbnails = false
switcher.ui.fontName = 'Hack'
switcher.ui.backgroundColor = {0.0,0.0,0.0,0}
switcher.ui.showSelectedTitle = false


hs.hotkey.bind(HyperKey,'tab','',function()
    switcher:next()
end)

--------------------
-- Media Bindings --
--------------------

-- function changeVolume(diff)
--     return function()
--         local current = hs.audiodevice.defaultOutputDevice():volume()
--         local new = math.min(100, math.max(0, math.floor(current + diff)))
--         if new > 0 then
--             hs.audiodevice.defaultOutputDevice():setMuted(false)
--         end
--         hs.audiodevice.defaultOutputDevice():setVolume(new)
--     end
-- end

-- hs.hotkey.bind(HyperKey, 'down', changeVolume(-5))
-- hs.hotkey.bind(HyperKey, 'up', changeVolume(5))

-----------------------
-- Location Bindings --
-----------------------

-- Switch to next screen
hs.hotkey.bind(HyperKey, "R", NextScreen())

-- Center
hs.hotkey.bind(HyperKey, "space", Full())
hs.hotkey.bind(VyperKey, "space", Center(.6))
hs.hotkey.bind(VyperKey, "C", Center(.4))
hs.hotkey.bind(VyperKey, "C", Center(.8))
hs.hotkey.bind(HyperKey, "U", Top(.5))
hs.hotkey.bind(HyperKey, "I", Bottom(.5))

-- Left
hs.hotkey.bind(VyperKey, "H", Left(.3))
hs.hotkey.bind(HyperKey, "H", Left(.5))
hs.hotkey.bind(HyperKey, "J", Left(.6))
hs.hotkey.bind(VyperKey, "J", Left(.7))

-- Right
hs.hotkey.bind(VyperKey, "K", Right(.7))
hs.hotkey.bind(HyperKey, "K", Right(.6))
hs.hotkey.bind(HyperKey, "L", Right(.5))
hs.hotkey.bind(VyperKey, "L", Right(.3))

-- Left Quadrants
hs.hotkey.bind(VyperKey, "O", LeftTop(.3, .5))
hs.hotkey.bind(HyperKey, "O", LeftTop(.5, .5))
hs.hotkey.bind(HyperKey, "N", LeftBot(.5, .5))
hs.hotkey.bind(VyperKey, "N", LeftBot(.3, .5))

-- Right Quadrants
hs.hotkey.bind(VyperKey, "P", RightTop(.3, .5))
hs.hotkey.bind(HyperKey, "P", RightTop(.5, .5))
hs.hotkey.bind(HyperKey, "M", RightBot(.5, .5))
hs.hotkey.bind(VyperKey, "M", RightBot(.3, .5))
hs.hotkey.bind(HyperKey, "0", RightBot(.7, .7))

-- Resize Window --

-- hs.hotkey.bind(HyperKey, "left", ExtendLeft(5), nil, ExtendLeft(5))
-- hs.hotkey.bind(VyperKey, "left", ShrinkRight(5), nil, ShrinkRight(5))
-- hs.hotkey.bind(HyperKey, "right", ExtendRight(5), nil, ExtendRight(5))
-- hs.hotkey.bind(VyperKey, "right", ShrinkLeft(5), nil, ShrinkLeft(5))

---------------
-- Shortcuts --
---------------

-- Lock Screen
hs.hotkey.bind(HyperKey, 'escape', function() hs.caffeinate.startScreensaver() end)
hs.hotkey.bind(VyperKey, 'escape', function() hs.caffeinate.systemSleep() end)

-- Reload Config
hs.hotkey.bind(HyperKey, "f5", function() hs.reload() end)
