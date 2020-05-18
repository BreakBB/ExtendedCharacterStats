---@type Config
local Config = ECSLoader:ImportModule("Config")
local _Config = Config.private

---@type Stats
local Stats = ECSLoader:ImportModule("Stats")

function _Config:LoadRangeSection()
    return {
        type = "group",
        order = 3,
        inline = false,
        name = function() return "Range" end,
        args = {
            showRangeStats = {
                type = "toggle",
                order = 0,
                name = function() return "Show Range Stats" end,
                desc = function() return "Shows/Hides all range stats." end,
                width = 1,
                get = function () return ExtendedCharacterStats.profile.ranged.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.ranged.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            rangeCrit = {
                type = "toggle",
                order = 1,
                name = function() return "Range Crit" end,
                desc = function() return "Shows/Hides the range crit value." end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.ranged.display); end,
                get = function () return ExtendedCharacterStats.profile.ranged.crit.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.ranged.crit.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            rangeHit = {
                type = "toggle",
                order = 2,
                name = function() return "Range Hit" end,
                desc = function() return "Shows/Hides all range hit values." end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.ranged.display); end,
                get = function () return ExtendedCharacterStats.profile.ranged.hit.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.ranged.hit.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            rangeHitGroup = {
                type = "group",
                order = 3,
                inline = true,
                name = function() return "Range Hit Values" end,
                args = {
                    rangeHitBonus = {
                        type = "toggle",
                        order = 1,
                        name = function() return "Hit Bonus" end,
                        desc = function() return "Shows/Hides the range hit bonus." end,
                        width = 1,
                        disabled = function() return ((not ExtendedCharacterStats.profile.ranged.display) or (not ExtendedCharacterStats.profile.ranged.hit.display)); end,
                        get = function () return ExtendedCharacterStats.profile.ranged.hit.bonus.display; end,
                        set = function (info, value)
                            ExtendedCharacterStats.profile.ranged.hit.bonus.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    rangeMiss = {
                        type = "toggle",
                        order = 2,
                        name = function() return "Miss-Chance" end,
                        desc = function() return "Shows/Hides the range miss chance again enemies on the same level." end,
                        width = 1,
                        disabled = function() return ((not ExtendedCharacterStats.profile.ranged.display) or (not ExtendedCharacterStats.profile.ranged.hit.display)); end,
                        get = function () return ExtendedCharacterStats.profile.ranged.hit.sameLevel.display; end,
                        set = function (info, value)
                            ExtendedCharacterStats.profile.ranged.hit.sameLevel.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    rangeMissBoss = {
                        type = "toggle",
                        order = 3,
                        name = function() return "Miss-Chance Boss" end,
                        desc = function() return "Shows/Hides the range miss chance again boss enemies (+3 Level)." end,
                        width = 1,
                        disabled = function() return ((not ExtendedCharacterStats.profile.ranged.display) or (not ExtendedCharacterStats.profile.ranged.hit.display)); end,
                        get = function () return ExtendedCharacterStats.profile.ranged.hit.bossLevel.display; end,
                        set = function (info, value)
                            ExtendedCharacterStats.profile.ranged.hit.bossLevel.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                }
            },
        },
    }
end
