---@type Config
local Config = ECSLoader:ImportModule("Config")
local _Config = Config.private

---@type Stats
local Stats = ECSLoader:ImportModule("Stats")
---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

function _Config:LoadRangeSection()
    return {
        type = "group",
        order = 3,
        inline = false,
        width = 2,
        name = function() return i18n("Ranged") end,
        args = {
            showRangeStats = {
                type = "toggle",
                order = 0,
                name = function() return i18n("Show Ranged Stats") end,
                desc = function() return i18n("Shows/Hides all ranged stats.") end,
                width = 1.5,
                get = function () return ExtendedCharacterStats.profile.ranged.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.ranged.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            rangedAttackPower = {
                type = "toggle",
                order = 1,
                name = function() return i18n("Ranged Attack Power") end,
                desc = function() return i18n("Shows/Hides the ranged attack power value.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.ranged.display); end,
                get = function () return ExtendedCharacterStats.profile.ranged.attackPower.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.ranged.attackPower.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            rangeCrit = {
                type = "toggle",
                order = 2,
                name = function() return i18n("Ranged Crit") end,
                desc = function() return i18n("Shows/Hides the ranged crit chance.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.ranged.display); end,
                get = function () return ExtendedCharacterStats.profile.ranged.crit.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.ranged.crit.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            penetration = {
                type = "toggle",
                order = 2.3,
                name = function() return i18n("Armor Pen.") end,
                desc = function() return i18n("Shows/Hides the armor penetration value.") end,
                width = 1.5,
                hidden = function()
                    return (not ECS.IsWotlk)
                end,
                disabled = function() return (not ExtendedCharacterStats.profile.ranged.display); end,
                get = function () return ExtendedCharacterStats.profile.ranged.penetration.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.ranged.penetration.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            penetrationRating = {
                type = "toggle",
                order = 2.4,
                name = function() return i18n("Armor Pen. Rating") end,
                desc = function() return i18n("Shows/Hides the armor penetration rating value.") end,
                width = 1.5,
                hidden = function()
                    return (not ECS.IsWotlk)
                end,
                disabled = function() return (not ExtendedCharacterStats.profile.ranged.display); end,
                get = function () return ExtendedCharacterStats.profile.ranged.penetrationRating.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.ranged.penetrationRating.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            hasteRating = {
                type = "toggle",
                order = 2.6,
                name = function() return i18n("Haste Rating") end,
                desc = function() return i18n("Shows/Hides the ranged haste rating.") end,
                width = 1.5,
                hidden = function()
                    return (not ECS.IsWotlk)
                end,
                disabled = function() return (not ExtendedCharacterStats.profile.ranged.display); end,
                get = function () return ExtendedCharacterStats.profile.ranged.hasteRating.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.ranged.hasteRating.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            hasteBonus = {
                type = "toggle",
                order = 2.7,
                name = function() return i18n("Haste Bonus") end,
                desc = function() return i18n("Shows/Hides the ranged haste bonus value.") end,
                width = 1.5,
                hidden = function()
                    return (not ECS.IsWotlk)
                end,
                disabled = function() return (not ExtendedCharacterStats.profile.ranged.display); end,
                get = function () return ExtendedCharacterStats.profile.ranged.hasteBonus.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.ranged.hasteBonus.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            rangedAttackSpeed = {
                type = "toggle",
                order = 3,
                name = function() return i18n("Attack Speed") end,
                desc = function() return i18n("Shows/Hides the ranged attack speed.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.ranged.display); end,
                get = function () return ExtendedCharacterStats.profile.ranged.attackSpeed.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.ranged.attackSpeed.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            rangeHit = {
                type = "toggle",
                order = 4,
                name = function() return i18n("Ranged Hit") end,
                desc = function() return i18n("Shows/Hides all ranged hit chance.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.ranged.display); end,
                get = function () return ExtendedCharacterStats.profile.ranged.hit.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.ranged.hit.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            rangeHitGroup = {
                type = "group",
                order = 5,
                inline = true,
                name = function() return i18n("Ranged Hit Values") end,
                args = {
                    rangeHitRating = {
                        type = "toggle",
                        order = 1,
                        name = function() return i18n("Hit Rating") end,
                        desc = function() return i18n("Shows/Hides the ranged hit rating.") end,
                        width = 1.5,
                        hidden = function()
                            return (not ECS.IsWotlk)
                        end,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.ranged.display) or
                                    (not ExtendedCharacterStats.profile.ranged.hit.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.ranged.hit.rating.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.ranged.hit.rating.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    rangeHitBonus = {
                        type = "toggle",
                        order = 2,
                        name = function() return i18n("Hit Bonus") end,
                        desc = function() return i18n("Shows/Hides the ranged hit bonus.") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.ranged.display) or
                                    (not ExtendedCharacterStats.profile.ranged.hit.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.ranged.hit.bonus.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.ranged.hit.bonus.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    rangeMiss = {
                        type = "toggle",
                        order = 3,
                        name = function() return i18n("Miss Chance") end,
                        desc = function() return i18n("Shows/Hides the ranged miss chance against enemies on the same level.") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.ranged.display) or
                                    (not ExtendedCharacterStats.profile.ranged.hit.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.ranged.hit.sameLevel.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.ranged.hit.sameLevel.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    rangeMissBoss = {
                        type = "toggle",
                        order = 4,
                        name = function() return i18n("Miss Chance Boss") end,
                        desc = function() return i18n("Shows/Hides the ranged miss chance against boss enemies (+3 Level).") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.ranged.display) or
                                    (not ExtendedCharacterStats.profile.ranged.hit.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.ranged.hit.bossLevel.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.ranged.hit.bossLevel.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                }
            },
        },
    }
end
