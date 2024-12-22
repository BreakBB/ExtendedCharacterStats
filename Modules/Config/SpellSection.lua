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
            spellSchoolsGroup = {
                type = "group",
                order = 7,
                inline = true,
                name = function() return i18n("Spell Schools") end,
                args = {
                    bonusHealing = {
                        type = "toggle",
                        order = 1,
                        name = function() return i18n("Healing Power") end,
                        desc = function() return i18n("Shows/Hides the healing power value.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spellBonus.display); end,
                        get = function () return ExtendedCharacterStats.profile.spellBonus.bonusHealing.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spellBonus.bonusHealing.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    arcaneDmg = {
                        type = "toggle",
                        order = 2,
                        name = function() return i18n("Arcane Damage") end,
                        desc = function() return i18n("Shows/Hides the arcane damage value.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spellBonus.display); end,
                        get = function () return ExtendedCharacterStats.profile.spellBonus.arcaneDmg.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spellBonus.arcaneDmg.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    fireDmg = {
                        type = "toggle",
                        order = 3,
                        name = function() return i18n("Fire Damage") end,
                        desc = function() return i18n("Shows/Hides the fire damage value.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spellBonus.display); end,
                        get = function () return ExtendedCharacterStats.profile.spellBonus.fireDmg.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spellBonus.fireDmg.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    frostDmg = {
                        type = "toggle",
                        order = 4,
                        name = function() return i18n("Frost Damage") end,
                        desc = function() return i18n("Shows/Hides the frost damage value.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spellBonus.display); end,
                        get = function () return ExtendedCharacterStats.profile.spellBonus.frostDmg.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spellBonus.frostDmg.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    holyDmg = {
                        type = "toggle",
                        order = 5,
                        name = function() return i18n("Holy Damage") end,
                        desc = function() return i18n("Shows/Hides the holy damage value.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spellBonus.display); end,
                        get = function () return ExtendedCharacterStats.profile.spellBonus.holyDmg.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spellBonus.holyDmg.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    natureDmg = {
                        type = "toggle",
                        order = 6,
                        name = function() return i18n("Nature Damage") end,
                        desc = function() return i18n("Shows/Hides the nature damage value.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spellBonus.display); end,
                        get = function () return ExtendedCharacterStats.profile.spellBonus.natureDmg.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spellBonus.natureDmg.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    physicalDmg = {
                        type = "toggle",
                        order = 7,
                        name = function() return i18n("Physical Damage") end,
                        desc = function() return i18n("Shows/Hides the physical damage value.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spellBonus.display); end,
                        get = function () return ExtendedCharacterStats.profile.spellBonus.physicalDmg.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spellBonus.physicalDmg.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    shadowDmg = {
                        type = "toggle",
                        order = 8,
                        name = function() return i18n("Shadow Damage") end,
                        desc = function() return i18n("Shows/Hides the shadow damage value.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spellBonus.display); end,
                        get = function () return ExtendedCharacterStats.profile.spellBonus.shadowDmg.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spellBonus.shadowDmg.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                }
            }
        },
    }
end
