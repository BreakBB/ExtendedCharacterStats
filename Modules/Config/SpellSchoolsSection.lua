---@type Config
local Config = ECSLoader:ImportModule("Config")
local _Config = Config.private

---@type Stats
local Stats = ECSLoader:ImportModule("Stats")
---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

function _Config:SpellSchoolsSection()
    return {
        type = "group",
        order = 6,
        inline = false,
        width = 2,
        name = function() return i18n("Spell Schools") end,
        args = {
            arcane = {
                type = "toggle",
                order = 1,
                name = function() return i18n("Arcane") end,
                desc = function() return i18n("Shows/Hides all arcane values.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.spellBonus.display); end,
                get = function () return ExtendedCharacterStats.profile.spellBonus.arcaneDmg.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.spellBonus.arcaneDmg.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            fire = {
                type = "toggle",
                order = 2,
                name = function() return i18n("Fire") end,
                desc = function() return i18n("Shows/Hides all fire values.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.spellBonus.display); end,
                get = function () return ExtendedCharacterStats.profile.spellBonus.fireDmg.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.spellBonus.fireDmg.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            frost = {
                type = "toggle",
                order = 3,
                name = function() return i18n("Frost") end,
                desc = function() return i18n("Shows/Hides all frost values.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.spellBonus.display); end,
                get = function () return ExtendedCharacterStats.profile.spellBonus.frostDmg.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.spellBonus.frostDmg.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            holy = {
                type = "toggle",
                order = 4,
                name = function() return i18n("Holy") end,
                desc = function() return i18n("Shows/Hides all holy values.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.spellBonus.display); end,
                get = function () return ExtendedCharacterStats.profile.spellBonus.holyDmg.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.spellBonus.holyDmg.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            nature = {
                type = "toggle",
                order = 5,
                name = function() return i18n("Nature") end,
                desc = function() return i18n("Shows/Hides all nature values.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.spellBonus.display); end,
                get = function () return ExtendedCharacterStats.profile.spellBonus.natureDmg.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.spellBonus.natureDmg.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            physical = {
                type = "toggle",
                order = 6,
                name = function() return i18n("Physical") end,
                desc = function() return i18n("Shows/Hides all physical values.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.spellBonus.display); end,
                get = function () return ExtendedCharacterStats.profile.spellBonus.physicalDmg.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.spellBonus.physicalDmg.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            shadow = {
                type = "toggle",
                order = 7,
                name = function() return i18n("Shadow") end,
                desc = function() return i18n("Shows/Hides all shadow values.") end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.spellBonus.display); end,
                get = function () return ExtendedCharacterStats.profile.spellBonus.shadowDmg.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.spellBonus.shadowDmg.display = value
                    Stats:RebuildStatInfos()
                end,
            },
        },
    }
end
