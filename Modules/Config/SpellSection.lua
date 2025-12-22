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
        order = 7,
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
                    Stats.RebuildStatInfos()
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
                    Stats.RebuildStatInfos()
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
                    Stats.RebuildStatInfos()
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
                    Stats.RebuildStatInfos()
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
                    Stats.RebuildStatInfos()
                end,
            },
            spellHitGroup = {
                type = "group",
                order = 5,
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
                            Stats.RebuildStatInfos()
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
                            Stats.RebuildStatInfos()
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
                            Stats.RebuildStatInfos()
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
                            Stats.RebuildStatInfos()
                        end,
                    },
                }
            },
            spellPower = {
                type = "group",
                order = 6,
                inline = true,
                name = function() return i18n("Spell Power") end,
                args = {
                    bonusHealing = {
                        type = "toggle",
                        order = 1,
                        name = function() return i18n("Healing Power") end,
                        desc = function() return i18n("Shows/Hides the healing power value.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                        get = function () return ExtendedCharacterStats.profile.spellBonus.bonusHealing.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spellBonus.bonusHealing.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    arcaneDmg = {
                        type = "toggle",
                        order = 2,
                        name = function() return i18n("Arcane Spell Damage") end,
                        desc = function() return i18n("Shows/Hides the arcane spell damage value.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                        get = function () return ExtendedCharacterStats.profile.spellBonus.arcaneDmg.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spellBonus.arcaneDmg.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    fireDmg = {
                        type = "toggle",
                        order = 3,
                        name = function() return i18n("Fire Spell Damage") end,
                        desc = function() return i18n("Shows/Hides the fire spell damage value.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                        get = function () return ExtendedCharacterStats.profile.spellBonus.fireDmg.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spellBonus.fireDmg.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    frostDmg = {
                        type = "toggle",
                        order = 4,
                        name = function() return i18n("Frost Spell Damage") end,
                        desc = function() return i18n("Shows/Hides the frost spell damage value.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                        get = function () return ExtendedCharacterStats.profile.spellBonus.frostDmg.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spellBonus.frostDmg.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    holyDmg = {
                        type = "toggle",
                        order = 5,
                        name = function() return i18n("Holy Spell Damage") end,
                        desc = function() return i18n("Shows/Hides the holy spell damage value.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                        get = function () return ExtendedCharacterStats.profile.spellBonus.holyDmg.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spellBonus.holyDmg.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    natureDmg = {
                        type = "toggle",
                        order = 6,
                        name = function() return i18n("Nature Spell Damage") end,
                        desc = function() return i18n("Shows/Hides the nature spell damage value.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                        get = function () return ExtendedCharacterStats.profile.spellBonus.natureDmg.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spellBonus.natureDmg.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    physicalDmg = {
                        type = "toggle",
                        order = 7,
                        name = function() return i18n("Physical Spell Damage") end,
                        desc = function() return i18n("Shows/Hides the physical spell damage value.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                        get = function () return ExtendedCharacterStats.profile.spellBonus.physicalDmg.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spellBonus.physicalDmg.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    shadowDmg = {
                        type = "toggle",
                        order = 8,
                        name = function() return i18n("Shadow Spell Damage") end,
                        desc = function() return i18n("Shows/Hides the shadow spell spell damage value.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                        get = function () return ExtendedCharacterStats.profile.spellBonus.shadowDmg.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spellBonus.shadowDmg.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                }
            }
        },
    }
end
