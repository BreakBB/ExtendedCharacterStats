---@type Config
local Config = ECSLoader:ImportModule("Config")
local _Config = Config.private

---@type Stats
local Stats = ECSLoader:ImportModule("Stats")
---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

function _Config:LoadDefenseSection()
    return {
        type = "group",
        order = 4,
        inline = false,
        width = 2,
        name = function() return i18n("DEFENSE") end,
        args = {
            showDefenseStats = {
                type = "toggle",
                order = 0,
                name = function() return i18n("DEFENSE_SETTINGS") end,
                desc = function() return i18n("DEFENSE_SETTINGS_DESC") end,
                width = 1.5,
                get = function () return ExtendedCharacterStats.profile.defense.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.defense.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            armor = {
                type = "toggle",
                order = 1,
                name = function() return i18n("ARMOR_SETTING") end,
                desc = function() return i18n("ARMOR_SETTING_DESC") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.armor.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.defense.armor.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            defense = {
                type = "toggle",
                order = 2,
                name = function() return i18n("DEFENSE") end,
                desc = function() return i18n("DEFENSE_VALUE_SETTING_DESC") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.defense.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.defense.defense.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            blockChance = {
                type = "toggle",
                order = 3,
                name = function() return i18n("BLOCK_CHANCE_SETTING") end,
                desc = function() return i18n("BLOCK_CHANCE_SETTING_DESC") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.blockChance.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.defense.blockChance.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            blockValue = {
                type = "toggle",
                order = 4,
                name = function() return i18n("BLOCK_VALUE_SETTING") end,
                desc = function() return i18n("BLOCK_VALUE_SETTING_DESC") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.blockValue.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.defense.blockValue.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            parry = {
                type = "toggle",
                order = 5,
                name = function() return i18n("PARRY_CHANCE_SETTING") end,
                desc = function() return i18n("PARRY_CHANCE_SETTING_DESC") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.parry.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.defense.parry.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            dodge = {
                type = "toggle",
                order = 6,
                name = function() return i18n("DODGE_CHANCE_SETTING") end,
                desc = function() return i18n("DODGE_CHANCE_SETTING_DESC") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.dodge.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.defense.dodge.display = value
                    Stats:RebuildStatInfos()
                end,
            },
        },
    }
end
