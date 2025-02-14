-- Bind hotkeys for cycling
local windowList = {}
local currentIndex = 1

local function updateWindowList()
    local filter = hs.window.filter.new():setCurrentSpace(true)
    filter:setDefaultFilter{visible = true}  -- Only include visible windows in the current space
    windowList = filter:getWindows()
    table.sort(windowList, function(a, b) return a:id() < b:id() end)
    
    -- Obtain the currently focused window
    local focusedWindow = hs.window.focusedWindow()
    currentIndex = 1  -- Default in case the focused window is not in the list

    for index, win in ipairs(windowList) do
        if win:id() == focusedWindow:id() then
            currentIndex = index
            break
        end
    end
end

local function focusNextWindow()
    if #windowList == 0 then updateWindowList() end
    if #windowList > 0 then
        currentIndex = currentIndex % #windowList + 1
        windowList[currentIndex]:focus()
    end
end

local function focusPreviousWindow()
    if #windowList == 0 then updateWindowList() end
    if #windowList > 0 then
        currentIndex = (currentIndex - 2 + #windowList) % #windowList + 1
        windowList[currentIndex]:focus()
    end
end

hs.hotkey.bind({'cmd'}, '`', focusNextWindow)
hs.hotkey.bind({'cmd', 'shift'}, '`', focusPreviousWindow)

-- Log a message when Hammerspoon config is loaded
print("Hammerspoon config loaded. Optimized window cycling should be working.")

-- Define the window filter for event subscriptions (include all windows)
local eventFilter = hs.window.filter.new(nil)

-- Introduce a slight delay before updating the window list when a new window is created
local function delayedUpdateWindowList()
    hs.timer.doAfter(0.1, updateWindowList)
end

-- Subscribe to window events
eventFilter:subscribe(hs.window.filter.windowCreated, delayedUpdateWindowList)
eventFilter:subscribe({
    hs.window.filter.windowDestroyed,
    hs.window.filter.windowMinimized,
    hs.window.filter.windowUnminimized,
    hs.window.filter.windowVisible,
    hs.window.filter.windowNotVisible
}, updateWindowList)

-- Initial window list population
updateWindowList()