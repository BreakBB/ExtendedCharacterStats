---@class ECS
ECS = LibStub("AceAddon-3.0"):NewAddon("Questie")

--- Addon is running on Classic "Vanilla" client: Means Classic Era and its seasons like SoM
---@type boolean
ECS.IsClassic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC

--- Addon is running on Classic TBC client
---@type boolean
ECS.IsTBC = WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC

--- Addon is running on Classic Wotlk client
---@type boolean
ECS.IsWotlk = WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC

--- Addon is running on Classic Season of Discovery client
---@type boolean
ECS.IsSoD = ECS.IsClassic and C_Seasons.HasActiveSeason() and (C_Seasons.GetActiveSeason() ~= Enum.SeasonID.Hardcore)

---@type Init
local Init = ECSLoader:ImportModule("Init")
---@type Settings
local Settings = ECSLoader:ImportModule("Settings")

function ECS:OnInitialize()
    -- This has to happen OnInitialize to be available asap
    self.db = LibStub("AceDB-3.0"):New("ECSSettings", Settings:GetDefaults(), true)

    -- These events basically all mean the same: The active profile changed.
    self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
    self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
    self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
end

function ECS:OnAddonLoaded()
    Init:OnAddonLoaded()
end

---@param message string
function ECS:Error(message)
    ECS:Print("|cffff0000ERROR|r " .. message)
end

---@param message string
function ECS:Print(message)
    print("|cFF1de9b6[ECS]|r " .. message)
end
