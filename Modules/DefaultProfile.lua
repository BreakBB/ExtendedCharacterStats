------------------------------------------------------------------
-- Namespaces
------------------------------------------------------------------
local _, core = ...
local ECSConfig = core.ECSConfig

local function GetDefaultProfile()
    return {

        melee = {
            display = true,
            refName = "MeleeHeader",
            text = "Melee",

            hit = {display = true, refName = "MeleeHit", text = "Hit Modifier: "},
            crit = {display = true, refName = "MeleeCritChance", text = "Crit: "}
        },

        ranged = {
            display = true,
            refName = "RangedHeader",
            text = "Ranged",

            hit = {display = true, refName = "RangedHit", text = "Hit Modifier: "},
            crit = {display = true, refName = "RangedCritChance", text = "Crit: "}
        },

        defense = {
            display = true,
            refName = "DefenseHeader",
            text = "Defense",

            block = {display = true, refName = "BlockChance", text = "Block: "},
            parry = {display = true, refName = "ParryChance", text = "Parry: "},
            dodge = {display = true, refName = "DodgeChance", text = "Dodge: "}
        },

        regen = {
            display = true,
            refName = "ManaHeader",
            text = "Mana",

            -- mp5Casting = {display = true, refName = "MP5Casting", text = "MP5 (Casting): "},
            mp5NotCasting = {display = true, refName = "MP5NotCasting", text = "MP5 through Spirit: "},
            -- mp5Current = {display = true, refName = "MP5Current", text = "MP5: "}
        },

        spell = {
            display = true,
            refName = "SpellHeader",
            text = "Spell",

            hit = {display = true, refName = "SpellHit", text = "Hit Modifier: "},
            crit = {display = true, refName = "SpellCritChance", text = "Crit: "}
        },

        spellBonus = {
            display = true,
            refName = "SpellBonusHeader",
            text = "Spell Bonus",

            bonusHealing = {display = true, refName = "BonusHealing", text = "Bonus Healing: "},
            shadowDmg = {display = true, refName = "ShadowDmg", text = "Shadow Damage: "},
            shadowCrit = {display = true, refName = "ShadowCritChance", text = "Shadow Crit: "},
            holyDmg = {display = true, refName = "HolyDmg", text = "Holy Damage: "},
            holyCrit = {display = true, refName = "HolyCritChance", text = "Holy Crit: "},
            fireDmg = {display = true, refName = "FireDmg", text = "Fire Damage: "},
            fireCrit = {display = true, refName = "FireCritChance", text = "Fire Crit: "},
            frostDmg = {display = true, refName = "FrostDmg", text = "Frost Damage: "},
            frostCrit = {display = true, refName = "FrostCritChance", text = "Frost Crit: "},
            arcaneDmg = {display = true, refName = "ArcaneDmg", text = "Arcane Damage: "},
            arcaneCrit = {display = true, refName = "ArcaneCritChance", text = "Arcane Crit: "},
            natureDmg = {display = true, refName = "NatureDmg", text = "Nature Damage: "},
            natureCrit = {display = true, refName = "NatureCritChance", text = "Nature Crit: "},
            physicalDmg = {display = true, refName = "PhysicalDmg", text = "Physical Damage: "},
            physicalCrit = {display = true, refName = "PhysicalCritChance", text = "Physical Crit: "}
        }
    }
end

function ECSConfig:GetProfileData()
    -- core.ECSConfig.currentProfile = GetDefaultProfile();
    return ExtendedCharacterStats.profile or GetDefaultProfile()
end
