------------------------------------------------------------------
-- Modules
------------------------------------------------------------------

---@class ECS
ECS = {...}

---@type i18n
local i18n = ECSLoader:ImportModule("i18n")
---@type Stats
local Stats = ECSLoader:ImportModule("Stats")
---@type GearInfos
local GearInfos = ECSLoader:ImportModule("GearInfos")
---@type Profile
local Profile = ECSLoader:ImportModule("Profile")

------------------------------------------------------------------

 -- forward declaration
local _InitAddon, _InitGUI, _RegisterEvents
local _ProfileVersionIsDifferent, _MigrateToLatestProfileVersion
local _IsEmptyTable

local loadingFrame = CreateFrame("Frame", nil, UIParent)
loadingFrame:RegisterEvent("ADDON_LOADED") -- Triggers whenever all non-lod addons has been loaded, this will initialize the addon
loadingFrame:RegisterEvent("PLAYER_LOGIN") -- Triggers whenever the player has logged in and all addons are loaded

loadingFrame:SetScript("OnEvent", function(self, event, arg1, ...)

    if event == "ADDON_LOADED" and arg1 == "ExtendedCharacterStats" then
        _InitAddon()
    end

    if event == "PLAYER_LOGIN" then
        _InitGUI()
    end
end)

ECS.loadingFrame = loadingFrame

_InitAddon = function()
    if (not ExtendedCharacterStats) then
        ExtendedCharacterStats = {}
    end

    local ecs = ExtendedCharacterStats
    local defaultProfile = Profile:GetDefaultProfile()

    if _IsEmptyTable(ecs.general) then
        ExtendedCharacterStats.general = defaultProfile.general
    end

    if _IsEmptyTable(ecs.profile) then
        ExtendedCharacterStats.profile = defaultProfile.profile
    end

    if (not ecs.general.profileVersion) then
        ecs.general.profileVersion = defaultProfile.general.profileVersion
    end

    local currentProfileVersion = ecs.general.profileVersion
    local targetProfileVersion = Profile:GetProfileVersion()

    if _ProfileVersionIsDifferent(ecs, targetProfileVersion) then
        ECS:Print("Migrating ECS profile from version " .. currentProfileVersion .. " to " .. targetProfileVersion)
        _MigrateToLatestProfileVersion(currentProfileVersion, defaultProfile)
        ExtendedCharacterStats.general.profileVersion = targetProfileVersion
    end

    i18n:LoadLanguageData()
end

---@return boolean
_ProfileVersionIsDifferent = function(ecs, profileVersion)
    return ecs.general and (ecs.general.profileVersion == nil or ecs.general.profileVersion ~= profileVersion)
end

_MigrateToLatestProfileVersion = function(profileVersion, defaultProfile)
    --- Before correct migration
    if profileVersion < 6 then
        ---@class ECSProfile
        ExtendedCharacterStats.profile = defaultProfile.profile
        ExtendedCharacterStats.general = defaultProfile.general
        return
    end

    if profileVersion < 7 then
        ExtendedCharacterStats.profile.melee.attackPower.refName = "MeleeAttackPower"
        ExtendedCharacterStats.profile.melee.attackSpeed = defaultProfile.profile.melee.attackSpeed
    end

    if profileVersion < 8 then
        ExtendedCharacterStats.profile.ranged.attackSpeed = defaultProfile.profile.ranged.attackSpeed
    end
end

---@return boolean
_IsEmptyTable = function(value)
    return value == nil or (not next(value))
end

local lastSuccessfulSpellTime = 0

_InitGUI = function ()
    -- Initialize the AddOn GUI once everything has loaded
    Stats:CreateWindow()

    GearInfos:Init()

    local eventFrame = CreateFrame("Frame", nil, UIParent)
    _RegisterEvents(eventFrame)

    -- Event handler for all the subscribed events
    -- Calls the update functions to update all the relevant stats
    eventFrame:SetScript("OnEvent", function(self, event, eventTarget, ...)
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
        elseif event == "PLAYER_EQUIPMENT_CHANGED" then
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

_RegisterEvents = function (eventFrame)
    -- Subscribe to events that will trigger an update
    eventFrame:RegisterEvent("UNIT_AURA") -- Triggers whenever the player gains or loses a buff/debuff
    eventFrame:RegisterEvent("PLAYER_LEVEL_UP") -- Triggers whenever the player levels up
    eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")  -- Triggers whenever the player log in, zone in to a new zone or reloads the UI
    eventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED") -- Triggers whenever the player changes gear
    eventFrame:RegisterEvent("UNIT_POWER_UPDATE") -- Triggers whenever the player changes gear
    eventFrame:RegisterEvent("UPDATE_SHAPESHIFT_FORM") -- Triggers whenever the player changes gear
    eventFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED") -- Triggers whenever a cast was successful
    eventFrame:RegisterEvent("INSPECT_READY") -- Triggers whenever the player inspects someone else and the inspect frame is ready
end

function ECS:Error(message)
   ECS:Print("|cffff0000ERROR|r " .. message)
end

function ECS:Print(message)
    print("|cFF1de9b6[ECS]|r " .. message)
end
