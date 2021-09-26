------------------------------------------------------------------
-- Modules
------------------------------------------------------------------

---@class Profile
local Profile = ECSLoader:CreateModule("Profile")

function Profile:GetProfileVersion()
    return 11
end

---@return ECSProfile
local function GetDefaultStatsProfile()
    return {
        ---@type Category
        general = {
            display = true,
            refName = "GeneralHeader",
            text = "General",

            movementSpeed = {display = true, refName = "MovementSpeed", text = "Movement Speed: "},
        },

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

                rating = {display = true, isTbcOnly = true, refName = "MeleeHitRating", text = "Rating: "},
                bonus = {display = true, refName = "MeleeHitBonus", text = "Bonus: "},
                sameLevel = {display = true, refName = "MeleeHitSameLevel", text = "Miss: "},
                bossLevel = {display = true, refName = "MeleeHitBossLevel", text = "Miss (Lvl + 3): "},
            },
            attackPower = {display = true, refName = "MeleeAttackPower", text = "Attack Power: "},
            crit = {display = true, refName = "MeleeCritChance", text = "Crit Chance: "},
            expertise = {display = true, isTbcOnly = true, refName = "Expertise", text = "Expertise: "},
            attackSpeed = {
                display = true,
                isSubGroup = true,
                refName = "MeleeAttackSpeedHeader",
                text = "Attack Speed",

                mainHand = {display = true, refName = "MeleeAttackSpeedMainHand", text = "Main Hand: "},
                offHand = {display = true, refName = "MeleeAttackSpeedOffHand", text = "Off Hand: "},
            },
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

                rating = {display = true, isTbcOnly = true, refName = "RangedHitRating", text = "Rating: "},
                bonus = {display = true, refName = "RangedHitBonus", text = "Bonus: "},
                sameLevel = {display = true, refName = "RangedHitSameLevel", text = "Miss: "},
                bossLevel = {display = true, refName = "RangedHitBossLevel", text = "Miss (Lvl + 3): "},
            },
            attackPower = {display = true, refName = "RangeAttackpower", text = "Attack Power: "},
            crit = {display = true, refName = "RangedCritChance", text = "Crit Chance: "},
            attackSpeed = {display = true, refName = "RangedAttackSpeed", text = "Attack Speed: "},
        },

        ---@type Category
        defense = {
            display = true,
            refName = "DefenseHeader",
            text = "Defense",

            armor = {display = true, refName = "Armor", text = "Armor: "},
            critImmunity = {display = true, refName = "CritImmunity", text = "Crit Immune: "},
            critReduction = {display = true, refName = "CritReduction", text = "Crit Reduction: "},
            defenseRating = {display = true, refName = "DefenseRating", text = "Defense Rating: "},
            defense = {display = true, refName = "DefenseValue", text = "Defense: "},
            blockChance = {display = true, refName = "BlockChance", text = "Block Chance: "},
            blockValue = {display = true, refName = "BlockValue", text = "Block Value: "},
            parry = {display = true, refName = "ParryChance", text = "Parry Chance: "},
            dodge = {display = true, refName = "DodgeChance", text = "Dodge Chance: "},
            resilience = {display = true, isTbcOnly = true, refName = "ResilienceValue", text = "Resilience: "},
        },

        ---@type Category
        regen = {
            display = true,
            refName = "ManaHeader",
            text = "Mana",

            mp5Items = {display = true, refName = "MP5Items", text = "MP5 (Items): "},
            mp5Spirit = {display = true, refName = "MP5Spirit", text = "MP5 (Spirit): "},
            mp5Buffs = {display = true, refName = "MP5Buffs", text = "MP5 (Buffs): "},
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

                rating = {display = true, isTbcOnly = true, refName = "SpellHitRating", text = "Rating: "},
                bonus = {display = true, refName = "SpellHitBonus", text = "Bonus: "},
                sameLevel = {display = true, refName = "SpellHitSameLevel", text = "Miss: "},
                bossLevel = {display = true, refName = "SpellHitBossLevel", text = "Miss (Lvl + 3): "},
            },
            crit = {display = true, refName = "SpellCritChance", text = "Crit Chance: "},
            penetration = {display = true, refName = "SpellPenetration", text = "Penetration: "},
        },

        ---@type Category
        spellBonus = {
            display = true,
            refName = "SpellBonusHeader",
            text = "Spell Power",

            bonusHealing = {display = true, refName = "BonusHealing", text = "Healing Power: "},
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
        statsWindowClosedOnOpen = false,
        addColorsToStatTexts = true,
        statColorSelection = "full",
        showQualityColors = true,
        headerFontSize = 11,
        statFontSize = 10,
        profileVersion = 0,
        window = {
            height = 422,
            width = 180,
            xOffset = -30,
            yOffset = 30
        }
    }
end

---@return ECSProfile
function Profile:GetDefaultProfile()
    return {
        general = GetDefaultGeneralSettings(),
        profile = GetDefaultStatsProfile(),
    }
end
