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
                get = function () return ExtendedCharacterStats.profile.spell.arcane.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.spell.arcane.display = value
                    ExtendedCharacterStats.profile.spellBonus.arcaneDmg.display = value
                    ExtendedCharacterStats.profile.spell.hit.arcaneHitBonus.display = value
                    ExtendedCharacterStats.profile.spell.hit.arcaneMissChance.display = value
                    ExtendedCharacterStats.profile.spell.hit.arcaneMissChanceBoss.display = value
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
                    ExtendedCharacterStats.profile.spell.fire.display = value
                    ExtendedCharacterStats.profile.spellBonus.fireDmg.display = value
                    ExtendedCharacterStats.profile.spell.hit.fireHitBonus.display = value
                    ExtendedCharacterStats.profile.spell.hit.fireMissChance.display = value
                    ExtendedCharacterStats.profile.spell.hit.fireMissChanceBoss.display = value
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
                get = function () return ExtendedCharacterStats.profile.spell.frost.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.spell.frost.display = value
                    ExtendedCharacterStats.profile.spellBonus.frostDmg.display = value
                    ExtendedCharacterStats.profile.spell.hit.frostHitBonus.display = value
                    ExtendedCharacterStats.profile.spell.hit.frostMissChance.display = value
                    ExtendedCharacterStats.profile.spell.hit.frostMissChanceBoss.display = value
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
                get = function () return ExtendedCharacterStats.profile.spell.holy.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.spell.holy.display = value
                    ExtendedCharacterStats.profile.spellBonus.holyDmg.display = value
                    ExtendedCharacterStats.profile.spell.hit.holyHitBonus.display = value
                    ExtendedCharacterStats.profile.spell.hit.holyMissChance.display = value
                    ExtendedCharacterStats.profile.spell.hit.holyMissChanceBoss.display = value
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
                get = function () return ExtendedCharacterStats.profile.spell.nature.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.spell.nature.display = value
                    ExtendedCharacterStats.profile.spellBonus.natureDmg.display = value
                    ExtendedCharacterStats.profile.spell.hit.natureHitBonus.display = value
                    ExtendedCharacterStats.profile.spell.hit.natureMissChance.display = value
                    ExtendedCharacterStats.profile.spell.hit.natureMissChanceBoss.display = value
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
                get = function () return ExtendedCharacterStats.profile.spell.physical.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.spell.physical.display = value
                    ExtendedCharacterStats.profile.spellBonus.physicalDmg.display = value
                    ExtendedCharacterStats.profile.spell.hit.physicalHitBonus.display = value
                    ExtendedCharacterStats.profile.spell.hit.physicalMissChance.display = value
                    ExtendedCharacterStats.profile.spell.hit.physicalMissChanceBoss.display = value
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
                get = function () return ExtendedCharacterStats.profile.spell.shadow.display; end,
                set = function (_, value)
                    ExtendedCharacterStats.profile.spell.shadow.display = value
                    ExtendedCharacterStats.profile.spellBonus.shadowDmg.display = value
                    ExtendedCharacterStats.profile.spell.hit.shadowHitBonus.display = value
                    ExtendedCharacterStats.profile.spell.hit.shadowMissChance.display = value
                    ExtendedCharacterStats.profile.spell.hit.shadowMissChanceBoss.display = value
                    Stats:RebuildStatInfos()
                end,
            },
        },
    }
end
