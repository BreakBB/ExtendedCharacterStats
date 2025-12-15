---@type Config
local Config = ECSLoader:ImportModule("Config")
local _Config = Config.private

---@type Stats
local Stats = ECSLoader:ImportModule("Stats")
---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

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
                name = function() return i18n("Show Defense Stats") end,
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
            meleeCritReduction = {
                type = "toggle",
                order = 1.81,
                name = function() return i18n("Melee Crit Reduction") end,
                desc = function() return i18n("Shows/Hides the reduction percentage of being critically hit by melee attacks.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.meleeCritReduction.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.defense.meleeCritReduction.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            rangedCritReduction = {
                type = "toggle",
                order = 1.82,
                name = function() return i18n("Ranged Crit Reduction") end,
                desc = function() return i18n("Shows/Hides the reduction percentage of being critically hit by ranged attacks.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.rangedCritReduction.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.defense.rangedCritReduction.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            spellCritReduction = {
                type = "toggle",
                order = 1.83,
                name = function() return i18n("Spell Crit Reduction") end,
                desc = function() return i18n("Shows/Hides the reduction percentage of being critically hit by spells.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.spellCritReduction.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.defense.spellCritReduction.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            avoidance = {
                type = "toggle",
                order = 1.85,
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
                order = 1.86,
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
            defenseRating = {
                type = "toggle",
                order = 1.9,
                name = function() return i18n("Defense Rating") end,
                desc = function() return i18n("Shows/Hides the defense rating.") end,
                width = 1.5,
                hidden = function()
                    return (not ECS.IsWotlk)
                end,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.defenseRating.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.defense.defenseRating.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            defense = {
                type = "toggle",
                order = 2,
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
            blockChance = {
                type = "toggle",
                order = 3,
                name = function() return i18n("Block Chance") end,
                desc = function() return i18n("Shows/Hides the block chance.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.blockChance.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.defense.blockChance.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            blockValue = {
                type = "toggle",
                order = 4,
                name = function() return i18n("Block Value") end,
                desc = function() return i18n("Shows/Hides the block value.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.blockValue.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.defense.blockValue.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            parry = {
                type = "toggle",
                order = 5,
                name = function() return i18n("Parry Chance") end,
                desc = function() return i18n("Shows/Hides the parry chance.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.parry.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.defense.parry.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            dodge = {
                type = "toggle",
                order = 6,
                name = function() return i18n("Dodge Chance") end,
                desc = function() return i18n("Shows/Hides the dodge chance.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.dodge.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.defense.dodge.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            resilience = {
                type = "toggle",
                order = 7,
                name = function() return i18n("Resilience") end,
                desc = function() return i18n("Shows/Hides the resilience value.") end,
                width = 1.5,
                hidden = function()
                    return (not ECS.IsWotlk)
                end,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.resilience.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.defense.resilience.display = value
                    Stats.RebuildStatInfos()
                end,
            },
        },
    }
end
