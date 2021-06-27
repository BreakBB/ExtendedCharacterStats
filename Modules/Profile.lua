------------------------------------------------------------------
-- Modules
------------------------------------------------------------------

---@class Profile
local Profile = ECSLoader:CreateModule("Profile")

function Profile:GetProfileVersion()
    return 10
end

---@return ECSProfile
local function GetDefaultStatsProfile()
    return {
        ---@type Category
        general = {
            display = true,
            refName = "GeneralHeader",
            text = "GENERAL",

            movementSpeed = {display = true, refName = "MovementSpeed", text = "MOVEMENT_SPEED"},
        },

        ---@class Category
        melee = {
            display = true,
            refName = "MeleeHeader",
            text = "MELEE",

            ---@class SubCategory
            hit = {
                display = true,
                isSubGroup = true,
                refName = "MeleeHitHeader",
                text = "HIT",

                rating = {display = true, isTbcOnly = true, refName = "MeleeHitRating", text = "RATING"},
                bonus = {display = true, refName = "MeleeHitBonus", text = "BONUS"},
                sameLevel = {display = true, refName = "MeleeHitSameLevel", text = "MISS"},
                bossLevel = {display = true, refName = "MeleeHitBossLevel", text = "MISS_BOSS"},
            },
            attackPower = {display = true, refName = "MeleeAttackPower", text = "ATTACK_POWER"},
            crit = {display = true, refName = "MeleeCritChance", text = "CRIT_CHANCE"},
            expertise = {display = true, isTbcOnly = true, refName = "Expertise", text = "EXPERTISE"},
            attackSpeed = {
                display = true,
                isSubGroup = true,
                refName = "MeleeAttackSpeedHeader",
                text = "ATTACK_SPEED_HEADER",

                mainHand = {display = true, refName = "MeleeAttackSpeedMainHand", text = "ATTACK_SPEED_MAIN_HAND"},
                offHand = {display = true, refName = "MeleeAttackSpeedOffHand", text = "ATTACK_SPEED_OFF_HAND"},
            },
        },

        ---@type Category
        ranged = {
            display = true,
            refName = "RangedHeader",
            text = "RANGED",

            ---@type SubCategory
            hit = {
                display = true,
                isSubGroup = true,
                refName = "RangedHitHeader",
                text = "HIT",

                rating = {display = true, isTbcOnly = true, refName = "RangedHitRating", text = "RATING"},
                bonus = {display = true, refName = "RangedHitBonus", text = "BONUS"},
                sameLevel = {display = true, refName = "RangedHitSameLevel", text = "MISS"},
                bossLevel = {display = true, refName = "RangedHitBossLevel", text = "MISS_BOSS"},
            },
            attackPower = {display = true, refName = "RangeAttackpower", text = "ATTACK_POWER"},
            crit = {display = true, refName = "RangedCritChance", text = "CRIT_CHANCE"},
            attackSpeed = {display = true, refName = "RangedAttackSpeed", text = "ATTACK_SPEED"},
        },

        ---@type Category
        defense = {
            display = true,
            refName = "DefenseHeader",
            text = "DEFENSE",

            armor = {display = true, refName = "Armor", text = "ARMOR"},
            defense = {display = true, refName = "DefenseValue", text = "DEFENSE_VALUE"},
            blockChance = {display = true, refName = "BlockChance", text = "BLOCK_CHANCE"},
            blockValue = {display = true, refName = "BlockValue", text = "BLOCK_VALUE"},
            parry = {display = true, refName = "ParryChance", text = "PARRY_CHANCE"},
            dodge = {display = true, refName = "DodgeChance", text = "DODGE_CHANCE"},
            resilience = {display = true, isTbcOnly = true, refName = "ResilienceValue", text = "RESILIENCE_VALUE"},
        },

        ---@type Category
        regen = {
            display = true,
            refName = "ManaHeader",
            text = "MANA",

            mp5Items = {display = true, refName = "MP5Items", text = "MP5_ITEMS"},
            mp5Spirit = {display = true, refName = "MP5Spirit", text = "MP5_SPIRIT"},
            mp5Buffs = {display = true, refName = "MP5Buffs", text = "MP5_BUFFS"},
            mp5Casting = {display = true, refName = "MP5Casting", text = "MP5_CASTING"},
        },

        ---@type Category
        spell = {
            display = true,
            refName = "SpellHeader",
            text = "SPELL",

            ---@type SubCategory
            hit = {
                display = true,
                isSubGroup = true,
                refName = "SpellHitHeader",
                text = "HIT",

                rating = {display = true, isTbcOnly = true, refName = "SpellHitRating", text = "RATING"},
                bonus = {display = true, refName = "SpellHitBonus", text = "BONUS"},
                sameLevel = {display = true, refName = "SpellHitSameLevel", text = "MISS"},
                bossLevel = {display = true, refName = "SpellHitBossLevel", text = "MISS_BOSS"},
            },
            crit = {display = true, refName = "SpellCritChance", text = "CRIT_CHANCE"},
            penetration = {display = true, refName = "SpellPenetration", text = "SPELL_PENETRATION"},
        },

        ---@type Category
        spellBonus = {
            display = true,
            refName = "SpellBonusHeader",
            text = "SPELL_POWER",

            bonusHealing = {display = true, refName = "BonusHealing", text = "HEALING_POWER"},
            arcaneDmg = {display = true, refName = "ArcaneDmg", text = "ARCANCE_DMG"},
            arcaneCrit = {display = true, refName = "ArcaneCritChance", text = "ARCANCE_CRIT"},
            fireDmg = {display = true, refName = "FireDmg", text = "FIRE_DMG"},
            fireCrit = {display = true, refName = "FireCritChance", text = "FIRE_CRIT"},
            frostDmg = {display = true, refName = "FrostDmg", text = "FROST_DMG"},
            frostCrit = {display = true, refName = "FrostCritChance", text = "FROST_CRIT"},
            holyDmg = {display = true, refName = "HolyDmg", text = "HOLY_DMG"},
            holyCrit = {display = true, refName = "HolyCritChance", text = "HOLY_CRIT"},
            natureDmg = {display = true, refName = "NatureDmg", text = "NATURE_DMG"},
            natureCrit = {display = true, refName = "NatureCritChance", text = "NATURE_CRIT"},
            physicalDmg = {display = true, refName = "PhysicalDmg", text = "PHYSICAL_DMG"},
            physicalCrit = {display = true, refName = "PhysicalCritChance", text = "PHYSICAL_CRIT"},
            shadowDmg = {display = true, refName = "ShadowDmg", text = "SHADOW_DMG"},
            shadowCrit = {display = true, refName = "ShadowCritChance", text = "SHADOW_CRIT"},
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
