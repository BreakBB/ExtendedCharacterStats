------------------------------------------------------------------
-- Namespaces
------------------------------------------------------------------

local _, core = ...

------------------------------------------------------------------
-- Events and Variables
------------------------------------------------------------------

-- Configure ADDON_LOADED event frame
ECS_ADDON_EVENTS = CreateFrame("Frame", nil, UIParent)
ECS_ADDON_EVENTS:RegisterEvent("ADDON_LOADED") -- Triggers whenever all non-lod addons has been loaded, this will initialize the addon
ECS_ADDON_EVENTS:RegisterEvent("PLAYER_LOGIN") -- Triggers whenever the player has logged in and all addons are loaded

ECS_ADDON_EVENTS:SetScript("OnEvent", function(self, event, arg1, ...)

    if event == "ADDON_LOADED" and arg1 == "ExtendedCharacterStats" then
        if ExtendedCharacterStats == nil then
            ExtendedCharacterStats = {}
        end

        if ExtendedCharacterStats.Profile == nil then
            ExtendedCharacterStats.Profile = core.ECSConfig:GetProfileData()
        end


        ExtendedCharacterStats.WindowSize = {
            Height = 425,
            Width = 225,
            xOffset = 200,
            yOffset = 30
        }
    end

    if event == "PLAYER_LOGIN" then

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
            core.ECSConfig:UpdateInformation()
        end)

    end
end)
