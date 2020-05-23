---@type Config
local Config = ECSLoader:ImportModule("Config")
local _Config = Config.private

---@type Stats
local Stats = ECSLoader:ImportModule("Stats")
---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

function _Config:LoadManaSection()
    return {
        type = "group",
        order = 5,
        inline = false,
        width = 2,
        name = function() return i18n("MANA") end,
        args = {
            showManaStats = {
                type = "toggle",
                order = 0,
                name = function() return i18n("MANA_SETTINGS") end,
                desc = function() return i18n("MANA_SETTINGS_DESC") end,
                width = 1.5,
                get = function () return ExtendedCharacterStats.profile.regen.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.regen.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            mp5Items = {
                type = "toggle",
                order = 1,
                name = function() return i18n("MP5_ITEMS_SETTING") end,
                desc = function() return i18n("MP5_ITEMS_SETTING_DESC") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.regen.display); end,
                get = function () return ExtendedCharacterStats.profile.regen.mp5Items.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.regen.mp5Items.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            mp5Spirit = {
                type = "toggle",
                order = 2,
                name = function() return i18n("MP5_SPIRIT_SETTING") end,
                desc = function() return i18n("MP5_SPIRIT_SETTING_DESC") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.regen.display); end,
                get = function () return ExtendedCharacterStats.profile.regen.mp5Spirit.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.regen.mp5Spirit.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            mp5Casting = {
                type = "toggle",
                order = 3,
                name = function() return i18n("MP5_CASTING_SETTING") end,
                desc = function() return i18n("MP5_CASTING_SETTING_DESC") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.regen.display); end,
                get = function () return ExtendedCharacterStats.profile.regen.mp5Casting.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.regen.mp5Casting.display = value
                    Stats:RebuildStatInfos()
                end,
            },
        },
    }
end
