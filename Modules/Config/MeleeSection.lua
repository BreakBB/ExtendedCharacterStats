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
                set = function (info, value)
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
                set = function (info, value)
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
                set = function (info, value)
                    ExtendedCharacterStats.profile.melee.crit.display = value
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
                set = function (info, value)
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
                    meleeHitBonus = {
                        type = "toggle",
                        order = 1,
                        name = function() return i18n("HIT_BONUS_SETTING") end,
                        desc = function() return i18n("MELEE_HIT_BONUS_SETTING_DESC") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.melee.display) or
                                    (not ExtendedCharacterStats.profile.melee.hit.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.melee.hit.bonus.display; end,
                        set = function (info, value)
                            ExtendedCharacterStats.profile.melee.hit.bonus.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    meleeMiss = {
                        type = "toggle",
                        order = 2,
                        name = function() return i18n("MISS_CHANCE_SETTING") end,
                        desc = function() return i18n("MELEE_MISS_CHANCE_SETTING_DESC") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.melee.display) or
                                    (not ExtendedCharacterStats.profile.melee.hit.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.melee.hit.sameLevel.display; end,
                        set = function (info, value)
                            ExtendedCharacterStats.profile.melee.hit.sameLevel.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    meleeMissBoss = {
                        type = "toggle",
                        order = 3,
                        name = function() return i18n("MISS_CHANCE_BOSS_SETTING") end,
                        desc = function() return i18n("MELEE_MISS_CHANCE_BOSS_SETTING_DESC") end,
                        width = 1.5,
                        disabled = function()
                            return ((not ExtendedCharacterStats.profile.melee.display) or
                                    (not ExtendedCharacterStats.profile.melee.hit.display))
                        end,
                        get = function () return ExtendedCharacterStats.profile.melee.hit.bossLevel.display; end,
                        set = function (info, value)
                            ExtendedCharacterStats.profile.melee.hit.bossLevel.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                }
            },
        },
    }
end