---@class Init
local Init = ECSLoader:CreateModule("Init")
local _Init = {}

---@type Migration
local Migration = ECSLoader:ImportModule("Migration")
---@type i18n
local i18n = ECSLoader:ImportModule("i18n")
---@type Stats
local Stats = ECSLoader:ImportModule("Stats")
---@type GearInfos
local GearInfos = ECSLoader:ImportModule("GearInfos")
---@type Profile
local Profile = ECSLoader:ImportModule("Profile")

local lastSuccessfulSpellTime = 0


function Init:OnAddonLoaded()
    if (not ExtendedCharacterStats) then
        ExtendedCharacterStats = {}
    end

    _Init:LoadProfile()
    i18n:SetLanguage(ExtendedCharacterStats.general.language)
end

function Init:OnPlayerLogin()
    -- Initialize the AddOn GUI once everything has loaded
    Stats:CreateWindow()

    GearInfos:Init()

    local eventFrame = CreateFrame("Frame", nil, UIParent)
    _Init:RegisterEvents(eventFrame)

    -- Event handler for all the subscribed events
    -- Calls the update functions to update all the relevant stats
    eventFrame:SetScript("OnEvent", function(_, event, eventTarget, ...)
        if eventTarget == "player" then
            if event == "UNIT_SPELLCAST_SUCCEEDED" then -- If a player casted something the 5 sec rule comes into play
                lastSuccessfulSpellTime = GetTime()
            elseif event == "UNIT_POWER_UPDATE" then
                -- Only check power update after the 5 sec rule (mana reg is back to normal)
                if lastSuccessfulSpellTime > 0 and (GetTime() - lastSuccessfulSpellTime) > 5.5 then
                    lastSuccessfulSpellTime = 0
                    Stats:UpdateInformation()
                end
            else
                C_Timer.After(0.5, function ()
                    Stats:UpdateInformation()
                end)
            end
        elseif event == "PLAYER_EQUIPMENT_CHANGED" or event == "SOCKET_INFO_SUCCESS" then
            GearInfos:UpdateGearColorFrames()
            C_Timer.After(0.5, function ()
                Stats:UpdateInformation()
            end)
        elseif event == "INSPECT_READY" then
            GearInfos:UpdateInspectGearColorFrames()
        end
    end)

    -- Update whenever the CharacterFrame is shown
    PaperDollItemsFrame:HookScript("OnShow", function ()
        GearInfos:UpdateGearColorFrames()
    end)

    ECS.eventFrame = eventFrame
end

function _Init:LoadProfile()
    local ecs = ExtendedCharacterStats
    local defaultProfile = Profile:GetDefaultProfile()

    if ecs.general == nil or (not next(ecs.general)) then
        ExtendedCharacterStats.general = defaultProfile.general
    end

    if ecs.profile == nil or (not next(ecs.profile)) then
        ExtendedCharacterStats.profile = defaultProfile.profile
    end

    if (not ecs.general.profileVersion) then
        ecs.general.profileVersion = defaultProfile.general.profileVersion
    end

    local currentProfileVersion = ecs.general.profileVersion
    local targetProfileVersion = Profile:GetProfileVersion()

    local isProfileVersionDifferent = ecs.general and (currentProfileVersion == nil or currentProfileVersion ~= targetProfileVersion)

    if isProfileVersionDifferent then
        ECS:Print("Migrating ECS profile from version " .. currentProfileVersion .. " to " .. targetProfileVersion)
        Migration:ToLatestProfileVersion(currentProfileVersion)
        ExtendedCharacterStats.general.profileVersion = targetProfileVersion
    end
end


---Subscribes to events that will trigger an update
function _Init:RegisterEvents(eventFrame)
    eventFrame:RegisterEvent("UNIT_AURA") -- Triggers whenever the player gains or loses a buff/debuff
    eventFrame:RegisterEvent("PLAYER_LEVEL_UP") -- Triggers whenever the player levels up
    eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")  -- Triggers whenever the player log in, zone in to a new zone or reloads the UI
    eventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED") -- Triggers whenever the player changes gear
    eventFrame:RegisterEvent("UNIT_POWER_UPDATE") -- Triggers whenever the player changes gear
    eventFrame:RegisterEvent("UPDATE_SHAPESHIFT_FORM") -- Triggers whenever the player changes gear
    eventFrame:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED") -- Triggers whenever the player mounts or dismounts
    eventFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED") -- Triggers whenever a cast was successful
    eventFrame:RegisterEvent("INSPECT_READY") -- Triggers whenever the player inspects someone else and the inspect frame is ready
    if ECS.IsTBC then
        eventFrame:RegisterEvent("SOCKET_INFO_SUCCESS") -- Triggers whenever the player successfully sockets an item
    end
end
