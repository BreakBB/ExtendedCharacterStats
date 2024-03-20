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
---@type Settings
local Settings = ECSLoader:ImportModule("Settings")



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

    EventHandler.Init()
    ECS.eventFrame = eventFrame
end

function _Init:LoadProfile()
    local ecs = ExtendedCharacterStats
    local defaultProfile = Settings:GetDefaults()

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
    local targetProfileVersion = Settings:GetProfileVersion()

    local isProfileVersionDifferent = ecs.general and (currentProfileVersion == nil or currentProfileVersion ~= targetProfileVersion)

    if isProfileVersionDifferent then
        ECS:Print("Migrating ECS profile from version " .. currentProfileVersion .. " to " .. targetProfileVersion)
        Migration:ToLatestProfileVersion(currentProfileVersion)
        ExtendedCharacterStats.general.profileVersion = targetProfileVersion
    end
end


---Subscribes to events that will trigger an update
function _Init.RegisterEvents(eventFrame)
    eventFrame:RegisterEvent("UNIT_AURA") -- Triggers whenever the player gains or loses a buff/debuff
    eventFrame:RegisterEvent("PLAYER_LEVEL_UP") -- Triggers whenever the player levels up
    eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")  -- Triggers whenever the player log in, zone in to a new zone or reloads the UI
    eventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED") -- Triggers whenever the player changes gear
    eventFrame:RegisterEvent("UPDATE_SHAPESHIFT_FORM") -- Triggers whenever someone (not only the player) changes shape
    eventFrame:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED") -- Triggers whenever the player mounts or dismounts
    eventFrame:RegisterEvent("INSPECT_READY") -- Triggers whenever the player inspects someone else and the inspect frame is ready
    eventFrame:RegisterEvent("CHARACTER_POINTS_CHANGED") -- Triggered whenever a player spends talent points
    eventFrame:RegisterEvent("GROUP_ROSTER_UPDATE") -- Triggered whenever someone joins or leaves the group (party and raid)
    if ECS.IsWotlk then
        eventFrame:RegisterEvent("SOCKET_INFO_SUCCESS") -- Triggers whenever the player successfully sockets an item

        GearManagerDialog:HookScript("OnShow", function()
            Stats:HideWindow()
        end)
        GearManagerDialog:HookScript("OnHide", function()
            Stats:ShowWindow()
        end)
    end
end
