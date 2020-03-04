---@type Config
local Config = ECSLoader:ImportModule("Config")
local _Config = Config.private

---@type Stats
local Stats = ECSLoader:ImportModule("Stats")

function _Config:LoadSpellSection()
    return {
        type = "group",
        order = 6,
        inline = false,
        name = function() return "Spell" end,
        args = {
            showSpellStats = {
                type = "toggle",
                order = 0,
                name = function() return "Show Spell Stats" end,
                desc = function() return "Shows/Hides all spell stats." end,
                width = 1,
                get = function () return ExtendedCharacterStats.profile.spell.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.spell.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            spellCrit = {
                type = "toggle",
                order = 1,
                name = function() return "Spell Crit" end,
                desc = function() return "Shows/Hides the spell crit value." end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                get = function () return ExtendedCharacterStats.profile.spell.crit.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.spell.crit.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            spellHit = {
                type = "toggle",
                order = 2,
                name = function() return "Spell Hit" end,
                desc = function() return "Shows/Hides all spell hit values." end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                get = function () return ExtendedCharacterStats.profile.spell.hit.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.spell.hit.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            spellHitGroup = {
                type = "group",
                order = 3,
                inline = true,
                name = function() return "Spell Hit Values" end,
                args = {
                    spellHitBonus = {
                        type = "toggle",
                        order = 1,
                        name = function() return "Hit Bonus" end,
                        desc = function() return "Shows/Hides the spell hit bonus." end,
                        width = 1,
                        disabled = function() return ((not ExtendedCharacterStats.profile.spell.display) or (not ExtendedCharacterStats.profile.spell.hit.display)); end,
                        get = function () return ExtendedCharacterStats.profile.spell.hit.bonus.display; end,
                        set = function (info, value)
                            ExtendedCharacterStats.profile.spell.hit.bonus.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    spellMiss = {
                        type = "toggle",
                        order = 2,
                        name = function() return "Miss-Chance" end,
                        desc = function() return "Shows/Hides the spell miss chance again enemies on the same level." end,
                        width = 1,
                        disabled = function() return ((not ExtendedCharacterStats.profile.spell.display) or (not ExtendedCharacterStats.profile.spell.hit.display)); end,
                        get = function () return ExtendedCharacterStats.profile.spell.hit.sameLevel.display; end,
                        set = function (info, value)
                            ExtendedCharacterStats.profile.spell.hit.sameLevel.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    spellMissBoss = {
                        type = "toggle",
                        order = 3,
                        name = function() return "Miss-Chance Boss" end,
                        desc = function() return "Shows/Hides the spell miss chance again boss enemies (+3 Level)." end,
                        width = 1,
                        disabled = function() return ((not ExtendedCharacterStats.profile.spell.display) or (not ExtendedCharacterStats.profile.spell.hit.display)); end,
                        get = function () return ExtendedCharacterStats.profile.spell.hit.bossLevel.display; end,
                        set = function (info, value)
                            ExtendedCharacterStats.profile.spell.hit.bossLevel.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                }
            },
        },
    }
end
