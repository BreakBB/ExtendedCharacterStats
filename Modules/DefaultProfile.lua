------------------------------------------------------------------
-- Modules
------------------------------------------------------------------

---@class Profile
local Profile = ECSLoader:CreateModule("Profile")

---@return ECSProfile
local function GetDefaultStatsProfile()
    return {

        ---@class Category
        melee = {
            display = true,
            refName = "MeleeHeader",
            text = "Melee",

            ---@class SubCategory
            hit = {
                display = true,
                isSubGroup = true,
                refName = "MeleeHitHeader",
                text = "Hit",

                bonus = {display = true, refName = "MeleeHitBonus", text = "Bonus: "},
                sameLevel = {display = true, refName = "MeleeHitSameLevel", text = "Miss: "},
                bossLevel = {display = true, refName = "MeleeHitBossLevel", text = "Miss (Lvl + 3): "},
            },
            crit = {display = true, refName = "MeleeCritChance", text = "Crit: "}
        },

        ---@type Category
        ranged = {
            display = true,
            refName = "RangedHeader",
            text = "Ranged",

            ---@type SubCategory
            hit = {
                display = true,
                isSubGroup = true,
                refName = "RangedHitHeader",
                text = "Hit",

                bonus = {display = true, refName = "RangedHitBonus", text = "Bonus: "},
                sameLevel = {display = true, refName = "RangedHitSameLevel", text = "Miss: "},
                bossLevel = {display = true, refName = "RangedHitBossLevel", text = "Miss (Lvl + 3): "},
            },
            crit = {display = true, refName = "RangedCritChance", text = "Crit: "}
        },

        ---@type Category
        defense = {
            display = true,
            refName = "DefenseHeader",
            text = "Defense",

            armor = {display = true, refName = "Armor", text = "Armor: "},
            defense = {display = true, refName = "DefenseValue", text = "Defense: "},
            block = {display = true, refName = "BlockChance", text = "Block: "},
            parry = {display = true, refName = "ParryChance", text = "Parry: "},
            dodge = {display = true, refName = "DodgeChance", text = "Dodge: "}
        },

        ---@type Category
        regen = {
            display = true,
            refName = "ManaHeader",
            text = "Mana",

            mp5Items = {display = true, refName = "MP5Items", text = "MP5 (Items): "},
            mp5Spirit = {display = true, refName = "MP5Spirit", text = "MP5 (Spirit): "},
            mp5Casting = {display = true, refName = "MP5Casting", text = "MP5 (Casting): "},
        },

        ---@type Category
        spell = {
            display = true,
            refName = "SpellHeader",
            text = "Spell",

            ---@type SubCategory
            hit = {
                display = true,
                isSubGroup = true,
                refName = "SpellHitHeader",
                text = "Hit",

                bonus = {display = true, refName = "SpellHitBonus", text = "Bonus: "},
                sameLevel = {display = true, refName = "SpellHitSameLevel", text = "Miss: "},
                bossLevel = {display = true, refName = "SpellHitBossLevel", text = "Miss (Lvl + 3): "},
            },
            crit = {display = true, refName = "SpellCritChance", text = "Crit: "}
        },

        ---@type Category
        spellBonus = {
            display = true,
            refName = "SpellBonusHeader",
            text = "Spell Bonus",

            bonusHealing = {display = true, refName = "BonusHealing", text = "Bonus Healing: "},
            arcaneDmg = {display = true, refName = "ArcaneDmg", text = "Arcane Damage: "},
            arcaneCrit = {display = true, refName = "ArcaneCritChance", text = "Arcane Crit: "},
            fireDmg = {display = true, refName = "FireDmg", text = "Fire Damage: "},
            fireCrit = {display = true, refName = "FireCritChance", text = "Fire Crit: "},
            frostDmg = {display = true, refName = "FrostDmg", text = "Frost Damage: "},
            frostCrit = {display = true, refName = "FrostCritChance", text = "Frost Crit: "},
            holyDmg = {display = true, refName = "HolyDmg", text = "Holy Damage: "},
            holyCrit = {display = true, refName = "HolyCritChance", text = "Holy Crit: "},
            natureDmg = {display = true, refName = "NatureDmg", text = "Nature Damage: "},
            natureCrit = {display = true, refName = "NatureCritChance", text = "Nature Crit: "},
            physicalDmg = {display = true, refName = "PhysicalDmg", text = "Physical Damage: "},
            physicalCrit = {display = true, refName = "PhysicalCritChance", text = "Physical Crit: "},
            shadowDmg = {display = true, refName = "ShadowDmg", text = "Shadow Damage: "},
            shadowCrit = {display = true, refName = "ShadowCritChance", text = "Shadow Crit: "},
        }
    }
end

local function GetDefaultGeneralSettings()
    return {
        showQualityColors = true,
    }
end

---@return ECSProfile
function Profile:GetProfileData()
    return {
        general = ExtendedCharacterStats.general or GetDefaultGeneralSettings(),
        profile = ExtendedCharacterStats.profile or GetDefaultStatsProfile(),
    }
    -- local default = {}
    -- default.general = ExtendedCharacterStats.general or GetDefaultGeneralSettings()
    -- default.profile = ExtendedCharacterStats.profile or GetDefaultStatsProfile()
    -- return default
end
