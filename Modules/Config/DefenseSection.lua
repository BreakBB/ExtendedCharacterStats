---@class Config
local Config = ECSLoader:ImportModule("Config")
local _Config = Config.private

---@type Stats
local Stats = ECSLoader:ImportModule("Stats")
---@type i18n
local i18n = ECSLoader:ImportModule("i18n")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

function _Config:LoadDefenseSection()
    return {
        type = "group",
        order = 4,
        inline = false,
        width = 2,
        name = function() return i18n("Defense") end,
        args = {
            showDefenseStats = {
                type = "toggle",
                order = 0,
                name = function() return i18n("Show defense stats") end,
                desc = function() return i18n("Shows/Hides all defense stats.") end,
                width = 1.5,
                get = function () return ExtendedCharacterStats.profile.defense.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.defense.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            armor = {
                type = "toggle",
                order = 1,
                name = function() return i18n("Armor") end,
                desc = function() return i18n("Shows/Hides the armor value.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.armor.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.defense.armor.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            resilienceRating = {
                type = "toggle",
                order = 2,
                name = function() return i18n("Resilience rating") end,
                desc = function() return i18n("Shows/Hides the resilience rating.") end,
                width = 1.5,
                hidden = function() return ECS.IsClassic end,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.resilienceRating.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.defense.resilienceRating.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            resilience = {
                type = "toggle",
                order = 2.1,
                name = function() return i18n("Resilience") end,
                desc = function() return i18n("Shows/Hides the resilience damage reduction.") end,
                width = 1.5,
                hidden = function() return ECS.IsClassic end,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.resilience.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.defense.resilience.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            defenseRating = {
                type = "toggle",
                order = 3,
                name = function() return i18n("Defense rating") end,
                desc = function() return i18n("Shows/Hides the defense rating.") end,
                width = 1.5,
                hidden = function() return ECS.IsClassic end,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.defenseRating.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.defense.defenseRating.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            defense = {
                type = "toggle",
                order = 3.1,
                name = function() return i18n("Defense") end,
                desc = function() return i18n("Shows/Hides the defense value.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.defense.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.defense.defense.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            avoidance = {
                type = "toggle",
                order = 4,
                name = function() return i18n("Avoidance") end,
                desc = function() return i18n("Shows/Hides the total avoidance.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.avoidance.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.defense.avoidance.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            avoidanceBoss = {
                type = "toggle",
                order = 4.1,
                name = function() return i18n("Avoidance (Lvl +3)") end,
                desc = function() return i18n("Shows/Hides the total avoidance (Lvl +3).") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.avoidanceBoss.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.defense.avoidanceBoss.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            dodgeRating = {
                type = "toggle",
                order = 5,
                name = function() return i18n("Dodge rating") end,
                desc = function() return i18n("Shows/Hides the dodge rating.") end,
                width = 1.5,
                hidden = function() return ECS.IsClassic end,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.dodgeRating.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.defense.dodgeRating.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            dodge = {
                type = "toggle",
                order = 5.1,
                name = function() return i18n("Dodge chance") end,
                desc = function() return i18n("Shows/Hides the dodge chance.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.dodge.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.defense.dodge.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            parryRating = {
                type = "toggle",
                order = 6,
                name = function() return i18n("Parry rating") end,
                desc = function() return i18n("Shows/Hides the parry rating.") end,
                width = 1.5,
                hidden = function() return ECS.IsClassic end,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.parryRating.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.defense.parryRating.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            parry = {
                type = "toggle",
                order = 6.1,
                name = function() return i18n("Parry chance") end,
                desc = function() return i18n("Shows/Hides the parry chance.") end,
                width = 1.5,
                hidden = function() return not DataUtils:CanParry() end,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.parry.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.defense.parry.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            blockGroup = {
                type = "group",
                order = 7,
                inline = true,
                name = function() return i18n("Block values") end,
                hidden = function() return not DataUtils:CanBlock() end,
                args = {
                    rating = {
                        type = "toggle",
                        order = 1,
                        name = function() return i18n("Block rating") end,
                        desc = function() return i18n("Shows/Hides the block rating.") end,
                        width = 1.5,
                        hidden = function() return ECS.IsClassic end,
                        disabled = function()
                            return  (not ExtendedCharacterStats.profile.defense.display) or
                                    (not ExtendedCharacterStats.profile.block.display)
                        end,
                        get = function () return ExtendedCharacterStats.profile.defense.block.rating.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.defense.block.rating.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    chance = {
                        type = "toggle",
                        order = 1.1,
                        name = function() return i18n("Block chance") end,
                        desc = function() return i18n("Shows/Hides the block chance.") end,
                        width = 1.5,
                        disabled = function()
                            return  (not ExtendedCharacterStats.profile.defense.display) or
                                    (not ExtendedCharacterStats.profile.block.display)
                        end,
                        get = function () return ExtendedCharacterStats.profile.defense.block.chance.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.defense.block.chance.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    amount = {
                        type = "toggle",
                        order = 1.2,
                        name = function() return i18n("Blocked amount") end,
                        desc = function() return i18n("Shows/Hides the blocked amount.") end,
                        width = 1.5,
                        disabled = function()
                            return  (not ExtendedCharacterStats.profile.defense.display) or
                                    (not ExtendedCharacterStats.profile.block.display)
                        end,
                        get = function () return ExtendedCharacterStats.profile.defense.block.amount.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.defense.block.amount.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                }
            },
            critReductionGroup = {
                type = "group",
                order = 8,
                inline = true,
                name = function() return i18n("Crit. reduction values") end,
                args = {
                    melee = {
                        type = "toggle",
                        order = 1,
                        name = function() return i18n("Melee crit. reduction") end,
                        desc = function() return i18n("Shows/Hides the reduction percentage of being critically hit by melee attacks.") end,
                        width = 1.5,
                        disabled = function()
                            return  (not ExtendedCharacterStats.profile.defense.display) or
                                    (not ExtendedCharacterStats.profile.critReduction.display)
                        end,
                        get = function () return ExtendedCharacterStats.profile.defense.critReduction.melee.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.defense.critReduction.melee.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    ranged = {
                        type = "toggle",
                        order = 1.1,
                        name = function() return i18n("Ranged crit. reduction") end,
                        desc = function() return i18n("Shows/Hides the reduction percentage of being critically hit by ranged attacks.") end,
                        width = 1.5,
                        disabled = function()
                            return  (not ExtendedCharacterStats.profile.defense.display) or
                                    (not ExtendedCharacterStats.profile.critReduction.display)
                        end,
                        get = function () return ExtendedCharacterStats.profile.defense.critReduction.ranged.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.defense.critReduction.ranged.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    spell = {
                        type = "toggle",
                        order = 1.2,
                        name = function() return i18n("Spell crit. reduction") end,
                        desc = function() return i18n("Shows/Hides the reduction percentage of being critically hit by spells.") end,
                        width = 1.5,
                        disabled = function()
                            return  (not ExtendedCharacterStats.profile.defense.display) or
                                    (not ExtendedCharacterStats.profile.critReduction.display)
                        end,
                        get = function () return ExtendedCharacterStats.profile.defense.critReduction.spell.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.defense.critReduction.spell.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                }
            },
        },
    }
end
