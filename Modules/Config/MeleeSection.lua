---@type Config
local Config = ECSLoader:ImportModule("Config")
local _Config = Config.private

---@type Stats
local Stats = ECSLoader:ImportModule("Stats")
---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

function _Config:LoadMeleeSection()
    return {
        type = "group",
        order = 2,
        inline = false,
        width = 2,
        name = function() return i18n("Melee") end,
        args = {
            showMeleeStats = {
                type = "toggle",
                order = 0,
                name = function() return i18n("Show Melee Stats") end,
                desc = function() return i18n("Shows/Hides all melee stats.") end,
                width = 1.5,
                get = function () return ExtendedCharacterStats.profile.melee.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.melee.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            meleeAttackPower = {
                type = "toggle",
                order = 1,
                name = function() return i18n("Melee Attack Power") end,
                desc = function() return i18n("Shows/Hides the melee attack power value.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.melee.display); end,
                get = function () return ExtendedCharacterStats.profile.melee.attackPower.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.melee.attackPower.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            meleeCrit = {
                type = "toggle",
                order = 2,
                name = function() return i18n("Melee Crit") end,
                desc = function() return i18n("Shows/Hides the melee crit chance.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.melee.display); end,
                get = function () return ExtendedCharacterStats.profile.melee.crit.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.melee.crit.display = value
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
                disabled = function() return (not ExtendedCharacterStats.profile.melee.display); end,
                get = function () return ExtendedCharacterStats.profile.melee.penetration.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.melee.penetration.display = value
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
                disabled = function() return (not ExtendedCharacterStats.profile.melee.display); end,
                get = function () return ExtendedCharacterStats.profile.melee.penetrationRating.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.melee.penetrationRating.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            expertise = {
                type = "toggle",
                order = 2.5,
                name = function() return i18n("Expertise") end,
                desc = function() return i18n("Shows/Hides the expertise value.") end,
                width = 1.5,
                hidden = function()
                    return (not ECS.IsWotlk)
                end,
                disabled = function() return (not ExtendedCharacterStats.profile.melee.display); end,
                get = function () return ExtendedCharacterStats.profile.melee.expertise.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.melee.expertise.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            expertiseRating = {
                type = "toggle",
                order = 2.6,
                name = function() return i18n("Expertise Rating") end,
                desc = function() return i18n("Shows/Hides the expertise rating.") end,
                width = 1.5,
                hidden = function()
                    return (not ECS.IsWotlk)
                end,
                disabled = function() return (not ExtendedCharacterStats.profile.melee.display); end,
                get = function () return ExtendedCharacterStats.profile.melee.expertiseRating.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.melee.expertiseRating.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            hasteRating = {
                type = "toggle",
                order = 2.6,
                name = function() return i18n("Haste Rating") end,
                desc = function() return i18n("Shows/Hides the melee haste rating.") end,
                width = 1.5,
                hidden = function()
                    return (not ECS.IsWotlk)
                end,
                disabled = function() return (not ExtendedCharacterStats.profile.melee.display); end,
                get = function () return ExtendedCharacterStats.profile.melee.hasteRating.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.melee.hasteRating.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            hasteBonus = {
                type = "toggle",
                order = 2.7,
                name = function() return i18n("Haste Bonus") end,
                desc = function() return i18n("Shows/Hides the melee haste bonus value.") end,
                width = 1.5,
                hidden = function()
                    return (not ECS.IsWotlk)
                end,
                disabled = function() return (not ExtendedCharacterStats.profile.melee.display); end,
                get = function () return ExtendedCharacterStats.profile.melee.hasteBonus.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.melee.hasteBonus.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            meleeHit = {
                type = "toggle",
                order = 3,
                name = function() return i18n("Melee Hit") end,
                desc = function() return i18n("Shows/Hides all melee hit chance.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.melee.display); end,
                get = function () return ExtendedCharacterStats.profile.melee.hit.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.melee.hit.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            meleeHitGroup = {
                type = "group",
                order = 4,
                inline = true,
                name = function() return i18n("Melee Hit Values") end,
                args = {
                    meleeHitRating = {
                        type = "toggle",
                        order = 1,
                        name = function() return i18n("Hit Rating") end,
                        desc = function() return i18n("Shows/Hides the melee hit rating.") end,
                        width = 1.5,
                        hidden = function()
                            return (not ECS.IsWotlk)
                        end,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.melee.display) or
                                    (not ExtendedCharacterStats.profile.melee.hit.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.melee.hit.rating.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.melee.hit.rating.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    meleeHitBonus = {
                        type = "toggle",
                        order = 2,
                        name = function() return i18n("Hit Bonus") end,
                        desc = function() return i18n("Shows/Hides the melee hit bonus.") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.melee.display) or
                                    (not ExtendedCharacterStats.profile.melee.hit.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.melee.hit.bonus.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.melee.hit.bonus.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    meleeMiss = {
                        type = "toggle",
                        order = 3,
                        name = function() return i18n("Miss Chance") end,
                        desc = function() return i18n("Shows/Hides the melee miss chance against enemies on the same level.") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.melee.display) or
                                    (not ExtendedCharacterStats.profile.melee.hit.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.melee.hit.sameLevel.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.melee.hit.sameLevel.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    meleeMissBoss = {
                        type = "toggle",
                        order = 4,
                        name = function() return i18n("Miss Chance Boss") end,
                        desc = function() return i18n("Shows/Hides the melee miss chance against boss enemies (+3 Level).") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.melee.display) or
                                    (not ExtendedCharacterStats.profile.melee.hit.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.melee.hit.bossLevel.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.melee.hit.bossLevel.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                },
            },
            glancingBlow = {
                type = "toggle",
                order = 5,
                name = function() return i18n("Glancing Blow") end,
                desc = function() return i18n("Shows/Hides all glancing blow stats") end,
                width = 1.5,
                hidden = function()
                    return (not ECS.IsClassic)
                end,
                disabled = function() return (not ExtendedCharacterStats.profile.melee.display); end,
                get = function () return ExtendedCharacterStats.profile.melee.glance.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.melee.glance.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            meleeGlanceGroup = {
                type = "group",
                order = 6,
                inline = true,
                name = function() return i18n("Melee Glance Values") end,
                hidden = function()
                    return (not ECS.IsClassic)
                end,
                args = {
                    meleeGlance = {
                        type = "toggle",
                        order = 1,
                        name = function() return i18n("Glancing Blow Chance") end,
                        desc = function() return i18n("Shows/Hides the glancing chance against enemies on same level.") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.melee.display) or
                                    (not ExtendedCharacterStats.profile.melee.glance.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.melee.glance.sameLevel.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.melee.glance.sameLevel.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    meleeGlanceBoss = {
                        type = "toggle",
                        order = 2,
                        name = function() return i18n("Glancing Blow Chance Boss") end,
                        desc = function() return i18n("Shows/Hides the glancing chance against boss enemies (+3 Level).") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.melee.display) or
                                    (not ExtendedCharacterStats.profile.melee.glance.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.melee.glance.bossLevel.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.melee.glance.bossLevel.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    meleeGlanceDamage = {
                        type = "toggle",
                        order = 3,
                        name = function() return i18n("Glancing Blow Damage") end,
                        desc = function() return i18n("Shows/Hides the damage reduction against enemies on the same level.") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.melee.display) or
                                    (not ExtendedCharacterStats.profile.melee.glance.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.melee.glance.damageSameLevel.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.melee.glance.damageSameLevel.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    meleeGlanceDamageBoss = {
                        type = "toggle",
                        order = 4,
                        name = function() return i18n("Glancing Blow Damage Boss") end,
                        desc = function() return i18n("Shows/Hides the damage reduction against boss enemies (+3 Level).") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.melee.display) or
                                    (not ExtendedCharacterStats.profile.melee.glance.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.melee.glance.damageBossLevel.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.melee.glance.damageSameLevel.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                }
            },
            meleeAttackSpeed = {
                type = "toggle",
                order = 7,
                name = function() return i18n("Attack Speed") end,
                desc = function() return i18n("Shows/Hides the melee attack speed.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.melee.display); end,
                get = function () return ExtendedCharacterStats.profile.melee.attackSpeed.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.melee.attackSpeed.display = value
                    Stats.RebuildStatInfos()
                end,
            },
            meleeAttackSpeedGroup = {
                type = "group",
                order = 8,
                inline = true,
                name = function() return i18n("Attack Speed") end,
                args = {
                    mainHand = {
                        type = "toggle",
                        order = 1,
                        name = function() return i18n("Main Hand") end,
                        desc = function() return i18n("Shows/Hides the attack speed of the main hand.") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.melee.display) or
                                    (not ExtendedCharacterStats.profile.melee.attackSpeed.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.melee.attackSpeed.mainHand.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.melee.attackSpeed.mainHand.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                    offHand = {
                        type = "toggle",
                        order = 2,
                        name = function() return i18n("Off Hand") end,
                        desc = function() return i18n("Shows/Hides the attack speed of the off hand.") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.melee.display) or
                                    (not ExtendedCharacterStats.profile.melee.attackSpeed.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.melee.attackSpeed.offHand.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.melee.attackSpeed.offHand.display = value
                            Stats.RebuildStatInfos()
                        end,
                    },
                }
            },
        },
    }
end