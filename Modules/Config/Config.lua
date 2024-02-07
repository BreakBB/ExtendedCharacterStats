------------------------------------------------------------------
-- Modules
------------------------------------------------------------------

---@class Config
local Config = ECSLoader:CreateModule("Config")
local _Config = Config.private

---@type GearInfos
local GearInfos = ECSLoader:ImportModule("GearInfos")
---@type Stats
local Stats = ECSLoader:ImportModule("Stats")
---@type i18n
local i18n = ECSLoader:ImportModule("i18n")
---@type Profile
local Profile = ECSLoader:ImportModule("Profile")

------------------------------------------------------------------
-- Configuration Frame
------------------------------------------------------------------

local AceGUI = LibStub("AceGUI-3.0")

-- Forward declaration
local _CreateGUI, _GeneralTab, _StatsTab

function Config.CreateWindow()
    local optionsGUI = _CreateGUI()
    LibStub("AceConfig-3.0"):RegisterOptionsTable("ECS", optionsGUI)
    ECS.configFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("ECS", "Extended Character Stats");

    local configFrame = AceGUI:Create("Frame");
    LibStub("AceConfigDialog-3.0"):SetDefaultSize("ECS", 440, 590)
    LibStub("AceConfigDialog-3.0"):Open("ECS", configFrame)
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
            general_tab = _GeneralTab(),
            stats_tab = _StatsTab(),
        }
    }
end

_GeneralTab = function()
    return {
        name = function() return i18n("General") end,
        type = "group",
        order = 1,
        args = {
            generalHeader = {
                type = "header",
                order = 1,
                name = function() return i18n("General Settings") end,
            },
            statsWindowClosedOnOpen = {
                type = "toggle",
                order = 1.1,
                name = function() return i18n("Hide ECS when opening character tab") end,
                desc = function() return i18n("Hides the stats windows when opening the character tab.") end,
                width = "full",
                get = function () return ExtendedCharacterStats.general.statsWindowClosedOnOpen; end,
                set = function (_, value)
                    ExtendedCharacterStats.general.statsWindowClosedOnOpen = value
                end,
            },
            addColorsToStatTexts = {
                type = "toggle",
                order = 2,
                name = function() return i18n("Colorize Stats") end,
                desc = function() return i18n("Adds colors to the stats overview.") end,
                width = "full",
                get = function () return ExtendedCharacterStats.general.addColorsToStatTexts; end,
                set = function (_, value)
                    ExtendedCharacterStats.general.addColorsToStatTexts = value
                    Stats:RebuildStatInfos()
                end,
            },
            statColorSelection = {
                type = "select",
                order = 2.1,
                values = {
                    ["full"] = i18n("Full"),
                    ["texts"] = i18n("Stat texts"),
                    ["values"] = i18n("Stat values"),
                },
                style = "dropdown",
                disabled = function() return (not ExtendedCharacterStats.general.addColorsToStatTexts) end,
                name = function() return i18n("Stats colorization") end,
                get = function()
                    if (not ExtendedCharacterStats.general.statColorSelection) then
                        return "full"
                    else
                        return ExtendedCharacterStats.general.statColorSelection;
                    end
                end,
                set = function(_, selection)
                    ExtendedCharacterStats.general.statColorSelection = selection
                    Stats:RebuildStatInfos()
                end,
            },
            showQualityColors = {
                type = "toggle",
                order = 3,
                name = function() return i18n("Show Item Quality Colors") end,
                desc = function() return i18n("Shows/Hides the colored frames around equipped items.") end,
                width = "full",
                get = function () return ExtendedCharacterStats.general.showQualityColors; end,
                set = function (_, value)
                    GearInfos:ToggleColorFrames(value)
                    ExtendedCharacterStats.general.showQualityColors = value
                end,
            },
            headerFontSize = {
                type = "range",
                order = 4,
                name = function() return i18n("Header Font Size") end,
                desc = function() return i18n("Changes the font size of the headers (e.g. Melee)") end,
                width = "double",
                min = 8,
                max = 18,
                step = 1,
                get = function() return ExtendedCharacterStats.general.headerFontSize; end,
                set = function (_, value)
                    ExtendedCharacterStats.general.headerFontSize = value
                    Stats:RebuildStatInfos()
                end,
            },
            statFontSize = {
                type = "range",
                order = 5,
                name = function() return i18n("Stat Font Size") end,
                desc = function() return i18n("Changes the font size of the stat lines (e.g. Crit)") end,
                width = "double",
                min = 8,
                max = 18,
                step = 1,
                get = function() return ExtendedCharacterStats.general.statFontSize; end,
                set = function (_, value)
                    ExtendedCharacterStats.general.statFontSize = value
                    Stats:RebuildStatInfos()
                end,
            },
            windowWidth = {
                type = "range",
                order = 6,
                name = function() return i18n("Window Width") end,
                desc = function() return i18n("Changes the width of the stats window") end,
                width = "double",
                min = 12,
                max = 25,
                step = 0.5,
                get = function() return ExtendedCharacterStats.general.window.width / 10; end,
                set = function (_, value)
                    ExtendedCharacterStats.general.window.width = value * 10
                    Stats:UpdateWindowSize()
                end,
            },
            language = {
                type = "select",
                order = 7,
                values = {
                    ["auto"] = "Auto",
                    ["enUS"] = "English",
                    ["esES"] = "Español",
                    ["esMX"] = "Español (América Latina)",
                    -- ["ptBR"] = "Português",
                    ["frFR"] = "Français",
                    ["deDE"] = "Deutsch",
                    ["ruRU"] = "Русский",
                    ["zhCN"] = "简体中文",
                    -- ["zhTW"] = "正體中文",
                    -- ["koKR"] = "한국어",
                },
                style = "dropdown",
                name = function() return i18n("Language") end,
                get = function()
                    if (not ExtendedCharacterStats.general.language) then
                        return "auto"
                    else
                        return ExtendedCharacterStats.general.language;
                    end
                end,
                set = function(_, lang)
                    i18n:SetLanguage(lang)

                    Stats:RebuildStatInfos()
                    Stats:UpdateSettingsButtonText()
                end,
            },
            resetSpacer = {
                type = "description",
                order = 8,
                name = " ",
                width = "full"
            },
            reset = {
                type = "execute",
                order = 8.1,
                name = function() return i18n("Reset ECS") end,
                desc = function() return i18n("Restores all default values of ECS."); end,
                func = function(_, _)
                    Profile:Reset()
                    ReloadUI()
                end
            }
        }
    }
end

_StatsTab = function ()
    return {
        name = function() return i18n("Stats") end,
        type = "group",
        order = 2,
        args = {
            statsHeader = {
                type = "header",
                order = 1,
                name = function() return i18n("Stats Settings") end,
            },
            generalGroup = _Config:LoadGeneralSection(),
            meleeGroup = _Config:LoadMeleeSection(),
            rangeGroup = _Config:LoadRangeSection(),
            defenseGroup = _Config:LoadDefenseSection(),
            mp5Group = _Config:LoadManaSection(),
            spellGroup = _Config:LoadSpellSection(),
            spellBonusGroup = _Config:SpellBonusSection(),
        }
    }
end

-- Open the configuration window
function Config:ToggleWindow()
    if (not ECSConfigFrame:IsShown()) then
        ECSConfigFrame:Show()
    else
        ECSConfigFrame:Hide()
    end
end
