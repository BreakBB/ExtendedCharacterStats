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
        name = function() return i18n("Mana") end,
        args = {
            showManaStats = {
                type = "toggle",
                order = 0,
                name = function() return i18n("Show Mana Stats") end,
                desc = function() return i18n("Shows/Hides all mana stats.") end,
                width = 1.5,
                get = function () return ExtendedCharacterStats.profile.regen.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.regen.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            mp5Items = {
                type = "toggle",
                order = 1,
                name = function() return i18n("MP5 Items") end,
                desc = function() return i18n("Shows/Hides the MP5 value from items.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.regen.display); end,
                get = function () return ExtendedCharacterStats.profile.regen.mp5Items.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.regen.mp5Items.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            mp5Spirit = {
                type = "toggle",
                order = 2,
                name = function() return i18n("MP5 Spirit") end,
                desc = function() return i18n("Shows/Hides the MP5 value from spirit.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.regen.display); end,
                get = function () return ExtendedCharacterStats.profile.regen.mp5Spirit.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.regen.mp5Spirit.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            mp5Buffs = {
                type = "toggle",
                order = 3,
                name = function() return i18n("MP5 Buffs") end,
                desc = function() return i18n("Shows/Hides the MP5 value from buffs.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.regen.display); end,
                get = function () return ExtendedCharacterStats.profile.regen.mp5Buffs.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.regen.mp5Buffs.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            mp5Casting = {
                type = "toggle",
                order = 4,
                name = function() return i18n("MP5 Casting") end,
                desc = function() return i18n("Shows/Hides the MP5 while casting value.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.regen.display); end,
                get = function () return ExtendedCharacterStats.profile.regen.mp5Casting.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.regen.mp5Casting.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            mp5NotCasting = {
                type = "toggle",
                order = 5,
                name = function() return i18n("MP5 (Not casting)") end,
                desc = function() return i18n("Shows/Hides the MP5 value when outside of the 5 second rule.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.regen.display); end,
                get = function () return ExtendedCharacterStats.profile.regen.mp5NotCasting.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.regen.mp5NotCasting.display = value
                    Stats.RebuildStatInfos()
                end,
            },
        },
    }
end
