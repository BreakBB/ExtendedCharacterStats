---@class EventHandler
local EventHandler = ECSLoader:CreateModule("EventHandler")

---@type Stats
local Stats = ECSLoader:ImportModule("Stats")
---@type GearInfos
local GearInfos = ECSLoader:ImportModule("GearInfos")

local UPDATE_INTERVAL = 2
local currentGroupMembers = 0
local shouldUpdate = false

function EventHandler.Init()
    currentGroupMembers = GetNumGroupMembers()

    C_Timer.NewTicker(UPDATE_INTERVAL, function()
        if shouldUpdate then
            Stats:UpdateInformation()
            shouldUpdate = false
        end
    end)
end

local lastEventTime = 0
local DEBOUNCE_INTERVAL = 0.5 -- 0.5 seconds debounce interval

---Event handler for all the events subscribed to in _Init.RegisterEvents
function EventHandler.HandleOnEvent(_, event, ...)
    local currentTime = GetTime()
    local shouldDebounce = currentTime - lastEventTime < DEBOUNCE_INTERVAL
    lastEventTime = currentTime

    if (not shouldDebounce) and event == "GROUP_ROSTER_UPDATE" then
        -- Someone joined or left the group
        currentGroupMembers = GetNumGroupMembers()
    elseif ((not shouldDebounce) and event == "UNIT_AURA") or event == "PLAYER_LEVEL_UP" or event == "CHARACTER_POINTS_CHANGED" then
        if currentGroupMembers > 5 then
            -- When in a raid update on the next UPDATE_INTERVAL tick
            shouldUpdate = true
        else
            -- Otherwise update right away
            Stats:UpdateInformation()
        end
    elseif event == "PLAYER_EQUIPMENT_CHANGED" or event == "SOCKET_INFO_SUCCESS" then
        GearInfos.UpdateGearColorFrames()
        C_Timer.After(0.5, function ()
            Stats:UpdateInformation()
        end)
    elseif event == "PLAYER_MOUNT_DISPLAY_CHANGED" then
        C_Timer.After(0.5, function ()
            Stats:UpdateInformation()
        end)
    elseif event == "INSPECT_READY" then
        GearInfos:UpdateInspectGearColorFrames()
    end
end