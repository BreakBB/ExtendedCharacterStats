---@type Config
local Config = ECSLoader:ImportModule("Config")
local _Config = Config.private

---@type Stats
local Stats = ECSLoader:ImportModule("Stats")

function _Config:LoadMeleeSection()
    return {
        type = "group",
        width = "half",
        order = 2,
        inline = false,
        name = function() return "Melee" end,
        args = {
            showMeleeStats = {
                type = "toggle",
                order = 0,
                name = function() return "Show Melee Stats" end,
                desc = function() return "Shows/Hides all melee stats." end,
                width = 1,
                get = function () return ExtendedCharacterStats.profile.melee.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.melee.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            meleeCrit = {
                type = "toggle",
                order = 1,
                name = function() return "Melee Crit" end,
                desc = function() return "Shows/Hides the melee crit value." end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.melee.display); end,
                get = function () return ExtendedCharacterStats.profile.melee.crit.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.melee.crit.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            meleeHit = {
                type = "toggle",
                order = 2,
                name = function() return "Melee Hit" end,
                desc = function() return "Shows/Hides all melee hit values." end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.melee.display); end,
                get = function () return ExtendedCharacterStats.profile.melee.hit.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.melee.hit.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            meleeHitGroup = {
                type = "group",
                order = 3,
                inline = true,
                name = function() return "Melee Hit Values" end,
                args = {
                    meleeHitBonus = {
                        type = "toggle",
                        order = 1,
                        name = function() return "Hit Bonus" end,
                        desc = function() return "Shows/Hides the melee hit bonus." end,
                        width = 1,
                        disabled = function() return ((not ExtendedCharacterStats.profile.melee.display) or (not ExtendedCharacterStats.profile.melee.hit.display)); end,
                        get = function () return ExtendedCharacterStats.profile.melee.hit.bonus.display; end,
                        set = function (info, value)
                            ExtendedCharacterStats.profile.melee.hit.bonus.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    meleeMiss = {
                        type = "toggle",
                        order = 2,
                        name = function() return "Miss-Chance" end,
                        desc = function() return "Shows/Hides the melee miss chance again enemies on the same level." end,
                        width = 1,
                        disabled = function() return ((not ExtendedCharacterStats.profile.melee.display) or (not ExtendedCharacterStats.profile.melee.hit.display)); end,
                        get = function () return ExtendedCharacterStats.profile.melee.hit.sameLevel.display; end,
                        set = function (info, value)
                            ExtendedCharacterStats.profile.melee.hit.sameLevel.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    meleeMissBoss = {
                        type = "toggle",
                        order = 3,
                        name = function() return "Miss-Chance Boss" end,
                        desc = function() return "Shows/Hides the melee miss chance again boss enemies (+3 Level)." end,
                        width = 1,
                        disabled = function() return ((not ExtendedCharacterStats.profile.melee.display) or (not ExtendedCharacterStats.profile.melee.hit.display)); end,
                        get = function () return ExtendedCharacterStats.profile.melee.hit.bossLevel.display; end,
                        set = function (info, value)
                            ExtendedCharacterStats.profile.melee.hit.bossLevel.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                }
            },
        },
    }
end