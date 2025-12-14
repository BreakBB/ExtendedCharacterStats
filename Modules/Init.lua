---@class Init
local Init = ECSLoader:CreateModule("Init")
local _Init = {}

---@type Migration
local Migration = ECSLoader:ImportModule("Migration")
---@type i18n
local i18n = ECSLoader:ImportModule("i18n")
---@type EventHandler
local EventHandler = ECSLoader:ImportModule("EventHandler")
---@type Stats
local Stats = ECSLoader:ImportModule("Stats")
---@type GearInfos
local GearInfos = ECSLoader:ImportModule("GearInfos")
---@type Profile
local Profile = ECSLoader:ImportModule("Profile")



function Init:OnAddonLoaded()
    if (not ExtendedCharacterStats) then
        ExtendedCharacterStats = {}
    end

    _Init:LoadProfile()
    i18n:SetLanguage(ExtendedCharacterStats.general.language)
end

function Init:OnPlayerLogin()
    -- Initialize the AddOn GUI once everything has loaded
    Stats.CreateWindow()

    GearInfos.Init()

    local eventFrame = CreateFrame("Frame", nil, UIParent)
    _Init.RegisterEvents(eventFrame)
    eventFrame:SetScript("OnEvent", EventHandler.HandleOnEvent)

    -- Update whenever the CharacterFrame is shown
    PaperDollItemsFrame:HookScript("OnShow", function ()
        GearInfos.UpdateGearColorFrames()
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
    local targetProfileVersion = Profile.GetProfileVersion()

    local isProfileVersionDifferent = ecs.general and (currentProfileVersion == nil or currentProfileVersion ~= targetProfileVersion)

    if isProfileVersionDifferent then
        ECS:Print("Migrating ECS profile from version " .. currentProfileVersion .. " to " .. targetProfileVersion)
        Migration:ToLatestProfileVersion(currentProfileVersion)
        ExtendedCharacterStats.general.profileVersion = targetProfileVersion
    end
end


---Subscribes to events that will trigger an update
function _Init.RegisterEvents(eventFrame)
    eventFrame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
    eventFrame:RegisterEvent("CHARACTER_POINTS_CHANGED") -- Triggered whenever a player spends talent points
    eventFrame:RegisterEvent("COMBAT_RATING_UPDATE")
    eventFrame:RegisterEvent("INSPECT_READY") -- Triggers whenever the player inspects someone else and the inspect frame is ready
    eventFrame:RegisterUnitEvent("PLAYER_DAMAGE_DONE_MODS", "player")
    eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")  -- Triggers whenever the player log in, zone in to a new zone or reloads the UI
    eventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED") -- Triggers whenever the player changes gear
    eventFrame:RegisterEvent("PLAYER_LEVEL_UP") -- Triggers whenever the player levels up
    eventFrame:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED") -- Triggers whenever the player mounts or dismounts
    eventFrame:RegisterEvent("PLAYER_TALENT_UPDATE")
    eventFrame:RegisterEvent("SKILL_LINES_CHANGED")
    eventFrame:RegisterEvent("SPELL_POWER_CHANGED")
    eventFrame:RegisterUnitEvent("UNIT_ATTACK_SPEED", "player")
    eventFrame:RegisterUnitEvent("UNIT_ATTACK", "player")
    eventFrame:RegisterUnitEvent("UNIT_ATTACK_POWER", "player")
    eventFrame:RegisterUnitEvent("UNIT_AURA", "player") -- Triggers whenever the player gains or loses a buff/debuff
    eventFrame:RegisterUnitEvent("UNIT_DAMAGE", "player")
    eventFrame:RegisterUnitEvent("UNIT_MAXPOWER", "player")
    eventFrame:RegisterUnitEvent("UNIT_SPELL_HASTE", "player")
    eventFrame:RegisterUnitEvent("UNIT_STATS", "player")
    eventFrame:RegisterUnitEvent("UNIT_RANGED_ATTACK_POWER", "player")
    eventFrame:RegisterUnitEvent("UNIT_RANGEDDAMAGE", "player")
    eventFrame:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
   if ECS.IsTbc or ECS.IsWotlk then
        eventFrame:RegisterEvent("SOCKET_INFO_SUCCESS") -- Triggers whenever the player successfully sockets an item

        GearManagerDialog:HookScript("OnShow", function()
            Stats:HideWindow()
        end)
        GearManagerDialog:HookScript("OnHide", function()
            Stats:ShowWindow()
        end)
    end
    if ECS.IsSoD then
        eventFrame:RegisterEvent("RUNE_UPDATED") -- Triggers whenever the player changed a rune
    end
end
