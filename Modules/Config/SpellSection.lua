---@type Config
local Config = ECSLoader:ImportModule("Config")
local _Config = Config.private

---@type Stats
local Stats = ECSLoader:ImportModule("Stats")
---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

function _Config:LoadSpellSection()
    return {
        type = "group",
        order = 6,
        inline = false,
        width = 2,
        name = function() return i18n("Spell") end,
        args = {
            showSpellStats = {
                type = "toggle",
                order = 0,
                name = function() return i18n("Show Spell Stats") end,
                desc = function() return i18n("Shows/Hides all spell stats.") end,
                width = 1.5,
                get = function () return ExtendedCharacterStats.profile.spell.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.spell.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            spellCrit = {
                type = "toggle",
                order = 1,
                name = function() return i18n("Spell Crit") end,
                desc = function() return i18n("Shows/Hides the spell crit chance.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                get = function () return ExtendedCharacterStats.profile.spell.crit.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.spell.crit.display = value
                    ExtendedCharacterStats.profile.spell.crit.arcane.display = value
                    ExtendedCharacterStats.profile.spell.crit.fire.display = value
                    ExtendedCharacterStats.profile.spell.crit.frost.display = value
                    ExtendedCharacterStats.profile.spell.crit.holy.display = value
                    ExtendedCharacterStats.profile.spell.crit.nature.display = value
                    ExtendedCharacterStats.profile.spell.crit.physical.display = value
                    ExtendedCharacterStats.profile.spell.crit.shadow.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            hasteRating = {
                type = "toggle",
                order = 2,
                name = function() return i18n("Haste Rating") end,
                desc = function() return i18n("Shows/Hides the spell haste rating value.") end,
                width = 1.5,
                hidden = function()
                    return (not ECS.IsWotlk)
                end,
                disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                get = function () return ExtendedCharacterStats.profile.spell.hasteRating.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.spell.hasteRating.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            hasteBonus = {
                type = "toggle",
                order = 3,
                name = function() return i18n("Haste Bonus") end,
                desc = function() return i18n("Shows/Hides the spell haste bonus value.") end,
                width = 1.5,
                hidden = function()
                    return (not ECS.IsWotlk)
                end,
                disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                get = function () return ExtendedCharacterStats.profile.spell.hasteBonus.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.spell.hasteBonus.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            spellPenetration = {
                type = "toggle",
                order = 4,
                name = function() return i18n("Spell Penetration") end,
                desc = function() return i18n("Shows/Hides the spell penetration value.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                get = function () return ExtendedCharacterStats.profile.spell.penetration.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.spell.penetration.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            spellHit = {
                type = "toggle",
                order = 5,
                name = function() return i18n("Spell Hit") end,
                desc = function() return i18n("Shows/Hides all spell hit chance.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                get = function () return ExtendedCharacterStats.profile.spell.hit.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.spell.hit.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            spellHitGroup = {
                type = "group",
                order = 6,
                inline = true,
                name = function() return i18n("Spell Hit Values") end,
                args = {
                    spellHitRating = {
                        type = "toggle",
                        order = 1,
                        name = function() return i18n("Hit Rating") end,
                        desc = function() return i18n("Shows/Hides the spell hit rating.") end,
                        width = 1.5,
                        hidden = function()
                            return (not ECS.IsWotlk)
                        end,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.spell.display) or
                                    (not ExtendedCharacterStats.profile.spell.hit.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.spell.hit.rating.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spell.hit.rating.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    spellHitBonus = {
                        type = "toggle",
                        order = 2,
                        name = function() return i18n("Hit Bonus") end,
                        desc = function() return i18n("Shows/Hides the spell hit bonus.") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.spell.display) or
                                    (not ExtendedCharacterStats.profile.spell.hit.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.spell.hit.bonus.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spell.hit.bonus.display = value
                            ExtendedCharacterStats.profile.spell.hit.arcaneHitBonus.display = value
                            ExtendedCharacterStats.profile.spell.hit.fireHitBonus.display = value
                            ExtendedCharacterStats.profile.spell.hit.frostHitBonus.display = value
                            ExtendedCharacterStats.profile.spell.hit.holyHitBonus.display = value
                            ExtendedCharacterStats.profile.spell.hit.natureHitBonus.display = value
                            ExtendedCharacterStats.profile.spell.hit.physicalHitBonus.display = value
                            ExtendedCharacterStats.profile.spell.hit.shadowHitBonus.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    spellMiss = {
                        type = "toggle",
                        order = 3,
                        name = function() return i18n("Miss Chance") end,
                        desc = function() return i18n("Shows/Hides the spell miss chance against enemies on the same level.") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.spell.display) or
                                    (not ExtendedCharacterStats.profile.spell.hit.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.spell.hit.sameLevel.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spell.hit.sameLevel.display = value
                            ExtendedCharacterStats.profile.spell.hit.arcaneMissChance.display = value
                            ExtendedCharacterStats.profile.spell.hit.fireMissChance.display = value
                            ExtendedCharacterStats.profile.spell.hit.frostMissChance.display = value
                            ExtendedCharacterStats.profile.spell.hit.holyMissChance.display = value
                            ExtendedCharacterStats.profile.spell.hit.natureMissChance.display = value
                            ExtendedCharacterStats.profile.spell.hit.physicalMissChance.display = value
                            ExtendedCharacterStats.profile.spell.hit.shadowMissChance.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    spellMissBoss = {
                        type = "toggle",
                        order = 4,
                        name = function() return i18n("Miss Chance Boss") end,
                        desc = function() return i18n("Shows/Hides the spell miss chance against boss enemies (+3 Level).") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.spell.display) or
                                    (not ExtendedCharacterStats.profile.spell.hit.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.spell.hit.bossLevel.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spell.hit.bossLevel.display = value
                            ExtendedCharacterStats.profile.spell.hit.arcaneMissChanceBoss.display = value
                            ExtendedCharacterStats.profile.spell.hit.fireMissChanceBoss.display = value
                            ExtendedCharacterStats.profile.spell.hit.frostMissChanceBoss.display = value
                            ExtendedCharacterStats.profile.spell.hit.holyMissChanceBoss.display = value
                            ExtendedCharacterStats.profile.spell.hit.natureMissChanceBoss.display = value
                            ExtendedCharacterStats.profile.spell.hit.physicalMissChanceBoss.display = value
                            ExtendedCharacterStats.profile.spell.hit.shadowMissChanceBoss.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                }
            },
        },
    }
end
