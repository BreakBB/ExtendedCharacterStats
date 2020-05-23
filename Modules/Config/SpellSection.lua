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
        name = function() return i18n("SPELL") end,
        args = {
            showSpellStats = {
                type = "toggle",
                order = 0,
                name = function() return i18n("SPELL_SETTINGS") end,
                desc = function() return i18n("SPELL_SETTINGS_DESC") end,
                width = 1.5,
                get = function () return ExtendedCharacterStats.profile.spell.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.spell.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            spellCrit = {
                type = "toggle",
                order = 1,
                name = function() return i18n("SPELL_CRIT_SETTING") end,
                desc = function() return i18n("SPELL_CRIT_SETTING_DESC") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                get = function () return ExtendedCharacterStats.profile.spell.crit.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.spell.crit.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            spellHit = {
                type = "toggle",
                order = 2,
                name = function() return i18n("SPELL_HIT_SETTING") end,
                desc = function() return i18n("SPELL_HIT_SETTING_DESC") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.spell.display); end,
                get = function () return ExtendedCharacterStats.profile.spell.hit.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.spell.hit.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            spellHitGroup = {
                type = "group",
                order = 3,
                inline = true,
                name = function() return "Spell Hit Values" end,
                args = {
                    spellHitBonus = {
                        type = "toggle",
                        order = 1,
                        name = function() return i18n("HIT_BONUS_SETTING") end,
                        desc = function() return i18n("SPELL_HIT_BONUS_SETTING_DESC") end,
                        width = 1.5,
                        disabled = function() return ((not ExtendedCharacterStats.profile.spell.display) or (not ExtendedCharacterStats.profile.spell.hit.display)); end,
                        get = function () return ExtendedCharacterStats.profile.spell.hit.bonus.display; end,
                        set = function (info, value)
                            ExtendedCharacterStats.profile.spell.hit.bonus.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    spellMiss = {
                        type = "toggle",
                        order = 2,
                        name = function() return i18n("MISS_CHANCE_SETTING") end,
                        desc = function() return i18n("SPELL_MISS_CHANCE_SETTING_DESC") end,
                        width = 1.5,
                        disabled = function() return ((not ExtendedCharacterStats.profile.spell.display) or (not ExtendedCharacterStats.profile.spell.hit.display)); end,
                        get = function () return ExtendedCharacterStats.profile.spell.hit.sameLevel.display; end,
                        set = function (info, value)
                            ExtendedCharacterStats.profile.spell.hit.sameLevel.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                    spellMissBoss = {
                        type = "toggle",
                        order = 3,
                        name = function() return i18n("MISS_CHANCE_BOSS_SETTING") end,
                        desc = function() return i18n("SPELL_MISS_CHANCE_BOSS_SETTING_DESC") end,
                        width = 1.5,
                        disabled = function() return ((not ExtendedCharacterStats.profile.spell.display) or (not ExtendedCharacterStats.profile.spell.hit.display)); end,
                        get = function () return ExtendedCharacterStats.profile.spell.hit.bossLevel.display; end,
                        set = function (info, value)
                            ExtendedCharacterStats.profile.spell.hit.bossLevel.display = value
                            Stats:RebuildStatInfos()
                        end,
                    },
                }
            },
        },
    }
end
