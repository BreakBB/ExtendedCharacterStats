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
        name = function() return i18n("General") end,
        args = {
            showGeneralStats = {
                type = "toggle",
                order = 0,
                name = function() return i18n("Show General Stats") end,
                desc = function() return i18n("Shows/Hides all general stats.") end,
                width = 1.5,
                get = function () return ExtendedCharacterStats.profile.general.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.general.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            movementSpeed = {
                type = "toggle",
                order = 1,
                name = function() return i18n("Show Movement Speed") end,
                desc = function() return i18n("Shows/Hides the movement speed value.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.general.display); end,
                get = function () return ExtendedCharacterStats.profile.general.movementSpeed.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.general.movementSpeed.display = value
                    Stats.RebuildStatInfos()
                end,
            },
        },
    }
end