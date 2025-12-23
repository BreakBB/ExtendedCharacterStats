---@class ECS
ECS = {...}

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
ECS.IsSoD = ECS.IsClassic and C_Seasons.HasActiveSeason() and (C_Seasons.GetActiveSeason() == Enum.SeasonID.SeasonOfDiscovery)

---@type Init
local Init = ECSLoader:ImportModule("Init")


local loadingFrame = CreateFrame("Frame")
ECS.loadingFrame = loadingFrame

loadingFrame:RegisterEvent("ADDON_LOADED") -- Triggers whenever all non-lod addons has been loaded, this will initialize the addon

loadingFrame:SetScript("OnEvent", function(self, event, arg1, ...)
    if event == "ADDON_LOADED" and arg1 == "ExtendedCharacterStats" then
        Init:OnAddonLoaded()
        self:RegisterEvent("PLAYER_LOGIN") -- Triggers whenever the player has logged in and all addons are loaded
    end

    if event == "PLAYER_LOGIN" then
        Init:OnPlayerLogin()
    end
end)

---@param message string
function ECS:Error(message)
    ECS:Print("|cffff0000ERROR|r " .. message)
end

---@param message string
function ECS:Print(message)
    print("|cFF1de9b6[ECS]|r " .. message)
end
