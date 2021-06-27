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
        name = function() return i18n("RANGED") end,
        args = {
            showRangeStats = {
                type = "toggle",
                order = 0,
                name = function() return i18n("RANGED_SETTINGS") end,
                desc = function() return i18n("RANGED_SETTINGS_DESC") end,
                width = 1.5,
                get = function () return ExtendedCharacterStats.profile.ranged.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.ranged.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            rangedAttackPower = {
                type = "toggle",
                order = 1,
                name = function() return i18n("RANGED_ATTACK_POWER_SETTING") end,
                desc = function() return i18n("RANGED_ATTACK_POWER_SETTING_DESC") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.ranged.display); end,
                get = function () return ExtendedCharacterStats.profile.ranged.attackPower.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.ranged.attackPower.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            rangeCrit = {
                type = "toggle",
                order = 2,
                name = function() return i18n("RANGED_CRIT_SETTING") end,
                desc = function() return i18n("RANGED_CRIT_SETTING_DESC") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.ranged.display); end,
                get = function () return ExtendedCharacterStats.profile.ranged.crit.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.ranged.crit.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            rangedAttackSpeed = {
                type = "toggle",
                order = 3,
                name = function() return i18n("RANGED_ATTACK_SPEED_SETTING") end,
                desc = function() return i18n("RANGED_ATTACK_SPEED_SETTING_DESC") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.ranged.display); end,
                get = function () return ExtendedCharacterStats.profile.ranged.attackSpeed.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.ranged.attackSpeed.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            rangeHit = {
                type = "toggle",
                order = 4,
                name = function() return i18n("RANGED_HIT_SETTING") end,
                desc = function() return i18n("RANGED_HIT_SETTING_DESC") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.ranged.display); end,
                get = function () return ExtendedCharacterStats.profile.ranged.hit.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.ranged.hit.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            rangeHitGroup = {
                type = "group",
                order = 5,
                inline = true,
                name = function() return i18n("RANGED_HIT_VALUES_SETTING") end,
                args = {
                    rangeHitRating = {
                        type = "toggle",
                        order = 1,
                        name = function() return i18n("HIT_RATING_SETTING") end,
                        desc = function() return i18n("RANGED_HIT_RATING_SETTING_DESC") end,
                        width = 1.5,
                        hidden = function()
                            return (not ECS.IsTBC)
                        end,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.ranged.display) or
                                    (not ExtendedCharacterStats.profile.ranged.hit.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.ranged.hit.rating.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.ranged.hit.rating.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    rangeHitBonus = {
                        type = "toggle",
                        order = 2,
                        name = function() return i18n("HIT_BONUS_SETTING") end,
                        desc = function() return i18n("RANGED_HIT_BONUS_SETTING_DESC") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.ranged.display) or
                                    (not ExtendedCharacterStats.profile.ranged.hit.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.ranged.hit.bonus.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.ranged.hit.bonus.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    rangeMiss = {
                        type = "toggle",
                        order = 3,
                        name = function() return i18n("MISS_CHANCE_SETTING") end,
                        desc = function() return i18n("RANGED_MISS_CHANCE_SETTING_DESC") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.ranged.display) or
                                    (not ExtendedCharacterStats.profile.ranged.hit.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.ranged.hit.sameLevel.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.ranged.hit.sameLevel.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    rangeMissBoss = {
                        type = "toggle",
                        order = 4,
                        name = function() return i18n("MISS_CHANCE_BOSS_SETTING") end,
                        desc = function() return i18n("RANGED_MISS_CHANCE_BOSS_SETTING_DESC") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.ranged.display) or
                                    (not ExtendedCharacterStats.profile.ranged.hit.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.ranged.hit.bossLevel.display; end,
                        set = function (_, value)
                            ExtendedCharacterStats.profile.ranged.hit.bossLevel.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                }
            },
        },
    }
end
