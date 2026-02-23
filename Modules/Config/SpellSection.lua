---@class Config
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
                name = function() return i18n("Show spell stats") end,
                desc = function() return i18n("Shows/Hides all spell stats.") end,
                width = 1.5,
                get = function () return ExtendedCharacterStats.profile.spell.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.spell.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            hasteRating = {
                type = "toggle",
                order = 2,
                name = function() return i18n("Haste rating") end,
                desc = function() return i18n("Shows/Hides the spell haste rating value.") end,
                width = 1.5,
                hidden = function() return ECS.IsClassic end,
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
                name = function() return i18n("Haste bonus") end,
                desc = function() return i18n("Shows/Hides the spell haste bonus value.") end,
                width = 1.5,
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
                name = function() return i18n("Spell penetration") end,
                desc = function() return i18n("Shows/Hides the spell penetration value.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                get = function () return ExtendedCharacterStats.profile.spell.penetration.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.spell.penetration.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            spellPower = {
                type = "group",
                order = 5,
                inline = true,
                name = function() return i18n("Spell power") end,
                args = {
                    bonusHealing = {
                        type = "toggle",
                        order = 1,
                        name = function() return i18n("Healing power") end,
                        desc = function() return i18n("Shows/Hides the healing power value.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                        get = function () return ExtendedCharacterStats.profile.spellBonus.bonusHealing.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spellBonus.bonusHealing.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    arcane = {
                        type = "toggle",
                        order = 2,
                        name = function() return i18n("Arcane") end,
                        desc = function() return i18n("Shows/Hides the arcane damage value.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                        get = function () return ExtendedCharacterStats.profile.spellBonus.arcane.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spellBonus.arcane.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    fire = {
                        type = "toggle",
                        order = 3,
                        name = function() return i18n("Fire") end,
                        desc = function() return i18n("Shows/Hides the fire damage value.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                        get = function () return ExtendedCharacterStats.profile.spellBonus.fire.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spellBonus.fire.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    frost = {
                        type = "toggle",
                        order = 4,
                        name = function() return i18n("Frost") end,
                        desc = function() return i18n("Shows/Hides the frost damage value.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                        get = function () return ExtendedCharacterStats.profile.spellBonus.frost.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spellBonus.frost.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    holy = {
                        type = "toggle",
                        order = 5,
                        name = function() return i18n("Holy") end,
                        desc = function() return i18n("Shows/Hides the holy damage value.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                        get = function () return ExtendedCharacterStats.profile.spellBonus.holy.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spellBonus.holy.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    nature = {
                        type = "toggle",
                        order = 6,
                        name = function() return i18n("Nature") end,
                        desc = function() return i18n("Shows/Hides the nature damage value.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                        get = function () return ExtendedCharacterStats.profile.spellBonus.nature.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spellBonus.nature.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    physical = {
                        type = "toggle",
                        order = 7,
                        name = function() return i18n("Physical") end,
                        desc = function() return i18n("Shows/Hides the physical damage value.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                        get = function () return ExtendedCharacterStats.profile.spellBonus.physical.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spellBonus.physical.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    shadow = {
                        type = "toggle",
                        order = 8,
                        name = function() return i18n("Shadow") end,
                        desc = function() return i18n("Shows/Hides the shadow damage value.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                        get = function () return ExtendedCharacterStats.profile.spellBonus.shadow.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spellBonus.shadow.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                }
            },
            spellCritGroup = {
                type = "group",
                order = 6,
                inline = true,
                name = function() return i18n("Spell crit. values") end,
                args = {
                    spellCritRating = {
                        type = "toggle",
                        order = 1,
                        name = function() return i18n("Spell crit. rating") end,
                        desc = function() return i18n("Shows/Hides the spell crit. rating.") end,
                        width = 1.5,
                        hidden = function() return ECS.IsClassic end,
                        disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                        get = function () return ExtendedCharacterStats.profile.spell.crit.rating.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spell.crit.rating.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    spellCrit = {
                        type = "toggle",
                        order = 1.1,
                        name = function() return i18n("Spell crit.") end,
                        desc = function() return i18n("Shows/Hides the spell crit. chance.") end,
                        width = 1.5,
                        disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                        get = function () return ExtendedCharacterStats.profile.spell.crit.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spell.crit.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                }
            },
            spellHitGroup = {
                type = "group",
                order = 7,
                inline = true,
                name = function() return i18n("Spell hit values") end,
                args = {
                    spellHitRating = {
                        type = "toggle",
                        order = 1,
                        name = function() return i18n("Hit rating") end,
                        desc = function() return i18n("Shows/Hides the spell hit rating.") end,
                        width = 1.5,
                        hidden = function() return ECS.IsClassic end,
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
                        name = function() return i18n("Hit bonus") end,
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
                        name = function() return i18n("Miss chance") end,
                        desc = function() return i18n("Shows/Hides the spell miss chance against enemies on the same level.") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.spell.display) or
                                    (not ExtendedCharacterStats.profile.spell.miss.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.spell.miss.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spell.miss.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    spellMissBoss = {
                        type = "toggle",
                        order = 4,
                        name = function() return i18n("Miss chance boss") end,
                        desc = function() return i18n("Shows/Hides the spell miss chance against boss enemies (+3 Level).") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.spell.display) or
                                    (not ExtendedCharacterStats.profile.spell.missBoss.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.spell.missBoss.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.spell.missBoss.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                }
            },

        },
    }
end
