---@type Config
local Config = ECSLoader:ImportModule("Config")
local _Config = Config.private

---@type Stats
local Stats = ECSLoader:ImportModule("Stats")
---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

function _Config:LoadGeneralSection()
    return {
        type = "group",
        order = 1.5,
        inline = false,
        width = 2,
        name = function() return i18n("GENERAL") end,
        args = {
            showGeneralStats = {
                type = "toggle",
                order = 0,
                name = function() return i18n("GENERAL_STATS") end,
                desc = function() return i18n("GENERAL_STATS_DESC") end,
                width = 1.5,
                get = function () return ExtendedCharacterStats.profile.general.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.general.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            armor = {
                type = "toggle",
                order = 1,
                name = function() return i18n("MOVEMENT_SPEED_SETTING") end,
                desc = function() return i18n("MOVEMENT_SPEED_SETTING_DESC") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.general.display); end,
                get = function () return ExtendedCharacterStats.profile.general.movementSpeed.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.general.movementSpeed.display = value
                    Stats:RebuildStatInfos()
                end,
            },
        },
    }
end