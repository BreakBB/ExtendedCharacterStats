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
        name = function() return i18n("MELEE") end,
        args = {
            showMeleeStats = {
                type = "toggle",
                order = 0,
                name = function() return i18n("MELEE_SETTINGS") end,
                desc = function() return i18n("MELEE_SETTINGS_DESC") end,
                width = 1.5,
                get = function () return ExtendedCharacterStats.profile.melee.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.melee.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            meleeAttackPower = {
                type = "toggle",
                order = 1,
                name = function() return i18n("MELEE_ATTACK_POWER_SETTING") end,
                desc = function() return i18n("MELEE_ATTACK_POWER_SETTING_DESC") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.melee.display); end,
                get = function () return ExtendedCharacterStats.profile.melee.attackPower.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.melee.attackPower.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            meleeCrit = {
                type = "toggle",
                order = 2,
                name = function() return i18n("MELEE_CRIT_SETTING") end,
                desc = function() return i18n("MELEE_CRIT_SETTING_DESC") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.melee.display); end,
                get = function () return ExtendedCharacterStats.profile.melee.crit.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.melee.crit.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            expertise = {
                type = "toggle",
                order = 2.5,
                name = function() return i18n("MELEE_EXPERTISE_SETTING") end,
                desc = function() return i18n("MELEE_EXPERTISE_SETTING_DESC") end,
                width = 1.5,
                hidden = function()
                    return (not ECS.IsTBC)
                end,
                disabled = function() return (not ExtendedCharacterStats.profile.melee.display); end,
                get = function () return ExtendedCharacterStats.profile.melee.expertise.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.melee.expertise.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            meleeHit = {
                type = "toggle",
                order = 3,
                name = function() return i18n("MELEE_HIT_SETTING") end,
                desc = function() return i18n("MELEE_HIT_SETTING_DESC") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.melee.display); end,
                get = function () return ExtendedCharacterStats.profile.melee.hit.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.melee.hit.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            meleeHitGroup = {
                type = "group",
                order = 4,
                inline = true,
                name = function() return i18n("MELEE_HIT_VALUES_SETTING") end,
                args = {
                    meleeHitRating = {
                        type = "toggle",
                        order = 1,
                        name = function() return i18n("HIT_RATING_SETTING") end,
                        desc = function() return i18n("MELEE_HIT_RATING_SETTING_DESC") end,
                        width = 1.5,
                        hidden = function()
                            return (not ECS.IsTBC)
                        end,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.melee.display) or
                                    (not ExtendedCharacterStats.profile.melee.hit.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.melee.hit.rating.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.melee.hit.rating.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    meleeHitBonus = {
                        type = "toggle",
                        order = 2,
                        name = function() return i18n("HIT_BONUS_SETTING") end,
                        desc = function() return i18n("MELEE_HIT_BONUS_SETTING_DESC") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.melee.display) or
                                    (not ExtendedCharacterStats.profile.melee.hit.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.melee.hit.bonus.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.melee.hit.bonus.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    meleeMiss = {
                        type = "toggle",
                        order = 3,
                        name = function() return i18n("MISS_CHANCE_SETTING") end,
                        desc = function() return i18n("MELEE_MISS_CHANCE_SETTING_DESC") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.melee.display) or
                                    (not ExtendedCharacterStats.profile.melee.hit.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.melee.hit.sameLevel.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.melee.hit.sameLevel.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    meleeMissBoss = {
                        type = "toggle",
                        order = 4,
                        name = function() return i18n("MISS_CHANCE_BOSS_SETTING") end,
                        desc = function() return i18n("MELEE_MISS_CHANCE_BOSS_SETTING_DESC") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.melee.display) or
                                    (not ExtendedCharacterStats.profile.melee.hit.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.melee.hit.bossLevel.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.melee.hit.bossLevel.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                }
            },
            meleeAttackSpeed = {
                type = "toggle",
                order = 5,
                name = function() return i18n("MELEE_ATTACK_SPEED_SETTING") end,
                desc = function() return i18n("MELEE_ATTACK_SPEED_SETTING_DESC") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.melee.display); end,
                get = function () return ExtendedCharacterStats.profile.melee.attackSpeed.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.melee.attackSpeed.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            meleeAttackSpeedGroup = {
                type = "group",
                order = 6,
                inline = true,
                name = function() return i18n("MELEE_ATTACK_SPEED_SETTING") end,
                args = {
                    mainHand = {
                        type = "toggle",
                        order = 1,
                        name = function() return i18n("MELEE_ATTACK_SPEED_MAIN_HAND_SETTING") end,
                        desc = function() return i18n("MELEE_ATTACK_SPEED_MAIN_HAND_SETTING_DESC") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.melee.display) or
                                    (not ExtendedCharacterStats.profile.melee.attackSpeed.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.melee.attackSpeed.mainHand.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.melee.attackSpeed.mainHand.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    offHand = {
                        type = "toggle",
                        order = 2,
                        name = function() return i18n("MELEE_ATTACK_SPEED_OFF_HAND_SETTING") end,
                        desc = function() return i18n("MELEE_ATTACK_SPEED_OFF_HAND_SETTING_DESC") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.melee.display) or
                                    (not ExtendedCharacterStats.profile.melee.attackSpeed.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.melee.attackSpeed.offHand.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.melee.attackSpeed.offHand.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                }
            },
        },
    }
end