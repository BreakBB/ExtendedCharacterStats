------------------------------------------------------------------
-- Modules
------------------------------------------------------------------

---@class Config
local Config = ECSLoader:CreateModule("Config")
local _Config = Config.private

---@type GearInfos
local GearInfos = ECSLoader:ImportModule("GearInfos")

------------------------------------------------------------------
-- Configuration Frame
------------------------------------------------------------------

local AceGUI = LibStub("AceGUI-3.0")

-- Forward declaration
local _CreateGUI, _GeneralTab, _StatsTab

function Config:CreateWindow()
    local optionsGUI = _CreateGUI()
    LibStub("AceConfigECS-3.0"):RegisterOptionsTable("ECS", optionsGUI)
    ECS.configFrame = LibStub("AceConfigDialogECS-3.0"):AddToBlizOptions("ECS", "Extended Character Stats");

    local configFrame = AceGUI:Create("Frame");
    LibStub("AceConfigDialogECS-3.0"):SetDefaultSize("ECS", 440, 590)
    LibStub("AceConfigDialogECS-3.0"):Open("ECS", configFrame)
    configFrame:Hide();

    ECSConfigFrame = configFrame.frame;
    table.insert(UISpecialFrames, "ECSConfigFrame");
end

_CreateGUI = function()
    return {
        name = "Extended Character Stats",
        handler = ECS,
        type = "group",
        childGroups = "tab",
        args = {
            stats_tab = _StatsTab(),
            general_tab = _GeneralTab(),
        }
    }
end

_StatsTab = function ()
    return {
        name = function() return "Stats" end,
        type = "group",
        order = 1,
        args = {
            statsHeader = {
                type = "header",
                order = 1,
                name = function() return "Stats Settings" end,
            },
            meleeGroup = _Config:LoadMeleeSection(),
            rangeGroup = _Config:LoadRangeSection(),
            defenseGroup = _Config:LoadDefenseSection(),
            mp5Group = _Config:LoadManaSection(),
            spellGroup = _Config:LoadSpellSection(),
            spellBonusGroup = _Config:SpellBonusSection(),
        }
    }
end

_GeneralTab = function()
    return {
        name = function() return "General" end,
        type = "group",
        order = 2,
        args = {
            generalHeader = {
                type = "header",
                order = 1,
                name = function() return "General Settings" end,
            },
            showQualityColors = {
                type = "toggle",
                order = 1.1,
                name = function() return "Show Item Quaility Colors" end,
                desc = function() return "Shows/Hides the colored frames around equiped items." end,
                width = "full",
                get = function () return ExtendedCharacterStats.general.showQualityColors; end,
                set = function (info, value)
                    GearInfos:ToggleColorFrames(value)
                    ExtendedCharacterStats.general.showQualityColors = value
                end,
            },
        }
    }
end
