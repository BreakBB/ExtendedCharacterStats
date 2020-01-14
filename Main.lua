------------------------------------------------------------------
-- Namespaces
------------------------------------------------------------------

local _, core = ...

---@class ECSUtils
core.Utils = {}
local Utils = core.Utils

------------------------------------------------------------------
-- Events and Variables
------------------------------------------------------------------

local _InitAddon, _InitGUI

-- Configure ADDON_LOADED event frame
ECS_ADDON_EVENTS = CreateFrame("Frame", nil, UIParent)
ECS_ADDON_EVENTS:RegisterEvent("ADDON_LOADED") -- Triggers whenever all non-lod addons has been loaded, this will initialize the addon
ECS_ADDON_EVENTS:RegisterEvent("PLAYER_LOGIN") -- Triggers whenever the player has logged in and all addons are loaded

ECS_ADDON_EVENTS:SetScript("OnEvent", function(self, event, arg1, ...)

    if event == "ADDON_LOADED" and arg1 == "ExtendedCharacterStats" then
        _InitAddon()
    end

    if event == "PLAYER_LOGIN" then
        _InitGUI()
    end
end)

_InitAddon = function()
    if ExtendedCharacterStats == nil then
        ExtendedCharacterStats = {}
    elseif ExtendedCharacterStats.v21reset == nil then
        -- Reset the settings for the update to v2.1.0
        ExtendedCharacterStats = {}
        ExtendedCharacterStats.v21reset = true
    end

    if ExtendedCharacterStats.profile == nil then
        ---@class ECSProfile
        ExtendedCharacterStats.profile = core.ECSConfig:GetProfileData()
    end

    ExtendedCharacterStats.windowSize = {
        height = 425,
        width = 225,
        xOffset = 200,
        yOffset = 30
    }
end

_InitGUI = function ()
    -- Initialize the AddOn GUI once everything has loaded
    core.ECSConfig:CreateWindow()

    -- Configure Update Event Frame for updating the UI
    ECS_EVENT_FRAME = CreateFrame("Frame", nil, UIParent)

    -- Subscribe to events that will trigger an update
    ECS_EVENT_FRAME:RegisterEvent("UNIT_AURA") -- Triggers whenever the player gains or loses a buff/debuff
    ECS_EVENT_FRAME:RegisterEvent("PLAYER_LEVEL_UP") -- Triggers whenever the player levels up
    ECS_EVENT_FRAME:RegisterEvent("PLAYER_ENTERING_WORLD")  -- Triggers whenever the player log in, zone in to a new zone or reloads the UI
    ECS_EVENT_FRAME:RegisterEvent("PLAYER_EQUIPMENT_CHANGED") -- Triggers whenever the player changes gear
    ECS_EVENT_FRAME:RegisterEvent("UNIT_POWER_UPDATE") -- Triggers whenever the player changes gear
    ECS_EVENT_FRAME:RegisterEvent("UPDATE_SHAPESHIFT_FORM") -- Triggers whenever the player changes gear

    -- Event handler for all the subscribed events
    -- Calls the update functions to update all the relevant stats
    ECS_EVENT_FRAME:SetScript("OnEvent", function(self, event, ...)
        C_Timer.After(0.5, function ()
            core.ECSConfig:UpdateInformation()
        end)
    end)
end


local cachedTitle = nil
function Utils:GetAddonVersionInfo()
    if (not cachedTitle) then
        local name, title, _, _, _ = GetAddOnInfo("ExtendedCharacterStats")
        cachedTitle = title
    end
    -- %d = digit, %p = punctuation character, %x = hexadecimal digits.
    local major, minor, patch, commit = string.match(cachedTitle, "(%d+)%p(%d+)%p(%d+)")
    return tonumber(major), tonumber(minor), tonumber(patch)
end

function Utils:GetAddonVersionString()
    local major, minor, patch = Utils:GetAddonVersionInfo()
    return "v" .. tostring(major) .. "." .. tostring(minor) .. "." .. tostring(patch)
end
