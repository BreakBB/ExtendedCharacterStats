---@class Profile
local Profile = ECSLoader:CreateModule("Profile")

---@type Utils
local Utils = ECSLoader:ImportModule("Utils")

function Profile:GetProfileVersion()
    return 16
end

---@return ECSProfile
local function GetDefaultStatsProfile()
    local colors = Utils.colors

    return {
        ---@type Category
        general = {
            display = true,
            refName = "GeneralHeader",
            text = "General",

            movementSpeed = {display = true, refName = "MovementSpeed", text = "Movement Speed"},
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

                rating = {
                    display = true,
                    isTbcOnly = true,
                    refName = "MeleeHitRating",
                    text = "Rating",
                    textColor = colors.HIT_SECONDARY,
                    statColor = colors.HIT_PRIMARY
                },
                bonus = {
                    display = true,
                    refName = "MeleeHitBonus",
                    text = "Bonus",
                    textColor = colors.HIT_SECONDARY,
                    statColor = colors.HIT_PRIMARY
                },
                sameLevel = {
                    display = true,
                    refName = "MeleeHitSameLevel",
                    text = "Miss",
                    textColor = colors.HIT_SECONDARY,
                    statColor = colors.HIT_PRIMARY
                },
                bossLevel = {
                    display = true,
                    refName = "MeleeHitBossLevel",
                    text = "Miss (Lvl + 3)",
                    textColor = colors.HIT_SECONDARY,
                    statColor = colors.HIT_PRIMARY
                },
            },
            attackPower = {
                display = true,
                refName = "MeleeAttackPower",
                text = "Attack Power",
                textColor = colors.ATTACK_POWER_SECONDARY,
                statColor = colors.ATTACK_POWER_PRIMARY
            },
            crit = {
                display = true,
                refName = "MeleeCritChance",
                text = "Crit Chance",
                textColor = colors.CRIT_SECONDARY,
                statColor = colors.CRIT_PRIMARY
            },
            penetration = {
                display = true,
                isTbcOnly = true,
                refName = "MeleeArmorPenetration",
                text = "Armor Penetration",
                textColor = colors.ATTACK_SPEED_SECONDARY,
                statColor = colors.ATTACK_SPEED_PRIMARY,
            },
            expertise = {display = true, isTbcOnly = true, refName = "Expertise", text = "Expertise"},
            expertiseRating = {display = true, isTbcOnly = true, refName = "ExpertiseRating", text = "Expertise Rating"},
            hasteRating = {
                display = true,
                isTbcOnly = true,
                refName = "MeleeHasteRating",
                text = "Haste Rating",
                textColor = colors.HASTE_RATING_SECONDARY,
                statColor = colors.HASTE_RATING_PRIMARY
            },
            hasteBonus = {
                display = true,
                isTbcOnly = true,
                refName = "MeleeHasteBonus",
                text = "Haste Bonus",
                textColor = colors.HASTE_RATING_SECONDARY,
                statColor = colors.HASTE_RATING_PRIMARY
            },
            attackSpeed = {
                display = true,
                isSubGroup = true,
                refName = "MeleeAttackSpeedHeader",
                text = "Attack Speed",

                mainHand = {
                    display = true,
                    refName = "MeleeAttackSpeedMainHand",
                    text = "Main Hand",
                    textColor = colors.ATTACK_SPEED_SECONDARY,
                    statColor = colors.ATTACK_SPEED_PRIMARY
                },
                offHand = {
                    display = true,
                    refName = "MeleeAttackSpeedOffHand",
                    text = "Off Hand",
                    textColor = colors.ATTACK_SPEED_SECONDARY,
                    statColor = colors.ATTACK_SPEED_PRIMARY
                },
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

                rating = {
                    display = true,
                    isTbcOnly = true,
                    refName = "RangedHitRating",
                    text = "Rating",
                    textColor = colors.HIT_SECONDARY,
                    statColor = colors.HIT_PRIMARY
                },
                bonus = {
                    display = true,
                    refName = "RangedHitBonus",
                    text = "Bonus",
                    textColor = colors.HIT_SECONDARY,
                    statColor = colors.HIT_PRIMARY
                },
                sameLevel = {
                    display = true,
                    refName = "RangedHitSameLevel",
                    text = "Miss",
                    textColor = colors.HIT_SECONDARY,
                    statColor = colors.HIT_PRIMARY
                },
                bossLevel = {
                    display = true,
                    refName = "RangedHitBossLevel",
                    text = "Miss (Lvl + 3)",
                    textColor = colors.HIT_SECONDARY,
                    statColor = colors.HIT_PRIMARY
                },
            },
            attackPower = {
                display = true,
                refName = "RangeAttackpower",
                text = "Attack Power",
                textColor = colors.ATTACK_POWER_SECONDARY,
                statColor = colors.ATTACK_POWER_PRIMARY
            },
            crit = {
                display = true,
                refName = "RangedCritChance",
                text = "Crit Chance",
                textColor = colors.CRIT_SECONDARY,
                statColor = colors.CRIT_PRIMARY
            },
            penetration = {
                display = true,
                isTbcOnly = true,
                refName = "RangedArmorPenetration",
                text = "Armor Penetration",
                textColor = colors.ATTACK_SPEED_SECONDARY,
                statColor = colors.ATTACK_SPEED_PRIMARY,
            },
            hasteRating = {
                display = true,
                isTbcOnly = true,
                refName = "RangedHasteRating",
                text = "Haste Rating",
                textColor = colors.HASTE_RATING_SECONDARY,
                statColor = colors.HASTE_RATING_PRIMARY
            },
            hasteBonus = {
                display = true,
                isTbcOnly = true,
                refName = "RangedHasteBonus",
                text = "Haste Bonus",
                textColor = colors.HASTE_RATING_SECONDARY,
                statColor = colors.HASTE_RATING_PRIMARY
            },
            attackSpeed = {
                display = true,
                refName = "RangedAttackSpeed",
                text = "Attack Speed",
                textColor = colors.ATTACK_SPEED_SECONDARY,
                statColor = colors.ATTACK_SPEED_PRIMARY
            },
        },

        ---@type Category
        defense = {
            display = true,
            refName = "DefenseHeader",
            text = "Defense",

            armor = {display = true, refName = "Armor", text = "Armor"},
            critImmunity = {display = true, isTbcOnly = true, refName = "CritImmunity", text = "Crit Immune"},
            critReduction = {display = true, isTbcOnly = true, refName = "CritReduction", text = "Crit Reduction"},
            avoidance = {display = true, refName = "Avoidance", text = "Avoidance"},
            defenseRating = {display = true, refName = "DefenseRating", text = "Defense Rating"},
            defense = {display = true, refName = "DefenseValue", text = "Defense"},
            blockChance = {display = true, refName = "BlockChance", text = "Block Chance"},
            blockValue = {display = true, refName = "BlockValue", text = "Block Value"},
            parry = {display = true, refName = "ParryChance", text = "Parry Chance"},
            dodge = {display = true, refName = "DodgeChance", text = "Dodge Chance"},
            resilience = {display = true, isTbcOnly = true, refName = "ResilienceValue", text = "Resilience"},
        },

        ---@type Category
        regen = {
            display = true,
            refName = "ManaHeader",
            text = "Mana",

            mp5Items = {
                display = true,
                refName = "MP5Items",
                text = "MP5 (Items)",
                textColor = colors.MP5_SECONDARY,
                statColor = colors.MP5_PRIMARY
            },
            mp5Spirit = {
                display = true,
                refName = "MP5Spirit",
                text = "MP5 (Spirit)",
                textColor = colors.MP5_SECONDARY,
                statColor = colors.MP5_PRIMARY
            },
            mp5Buffs = {
                display = true,
                refName = "MP5Buffs",
                text = "MP5 (Buffs)",
                textColor = colors.MP5_SECONDARY,
                statColor = colors.MP5_PRIMARY
            },
            mp5Casting = {
                display = true,
                refName = "MP5Casting",
                text = "MP5 (Casting)",
                textColor = colors.MP5_SECONDARY,
                statColor = colors.MP5_PRIMARY
            },
            mp5NotCasting = {
                display = true,
                refName = "MP5NotCasting",
                text = "MP5 (Not casting)",
                textColor = colors.MP5_SECONDARY,
                statColor = colors.MP5_PRIMARY
            },
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

                rating = {
                    display = true,
                    isTbcOnly = true,
                    refName = "SpellHitRating",
                    text = "Rating",
                    textColor = colors.HIT_SECONDARY,
                    statColor = colors.HIT_PRIMARY
                },
                bonus = {
                    display = true,
                    refName = "SpellHitBonus",
                    text = "Bonus",
                    textColor = colors.HIT_SECONDARY,
                    statColor = colors.HIT_PRIMARY
                },
                sameLevel = {
                    display = true,
                    refName = "SpellHitSameLevel",
                    text = "Miss",
                    textColor = colors.HIT_SECONDARY,
                    statColor = colors.HIT_PRIMARY
                },
                bossLevel = {
                    display = true,
                    refName = "SpellHitBossLevel",
                    text = "Miss (Lvl + 3)",
                    textColor = colors.HIT_SECONDARY,
                    statColor = colors.HIT_PRIMARY
                },
            },
            crit = {
                display = true,
                refName = "SpellCritChance",
                text = "Crit Chance",
                textColor = colors.CRIT_SECONDARY,
                statColor = colors.CRIT_PRIMARY
            },
            hasteRating = {
                display = true,
                isTbcOnly = true,
                refName = "SpellHasteRating",
                text = "Haste Rating",
                textColor = colors.HASTE_RATING_SECONDARY,
                statColor = colors.HASTE_RATING_PRIMARY
            },
            hasteBonus = {
                display = true,
                isTbcOnly = true,
                refName = "SpellHasteBonus",
                text = "Haste Bonus",
                textColor = colors.HASTE_RATING_SECONDARY,
                statColor = colors.HASTE_RATING_PRIMARY
            },
            penetration = {display = true, refName = "SpellPenetration", text = "Penetration"},
        },

        ---@type Category
        spellBonus = {
            display = true,
            refName = "SpellBonusHeader",
            text = "Spell Power",

            bonusHealing = {
                display = true,
                refName = "BonusHealing",
                text = "Healing Power",
                textColor = colors.HEALING_SECONDARY,
                statColor = colors.HEALING_PRIMARY
            },
            arcaneDmg = {
                display = true,
                refName = "ArcaneDmg",
                text = "Arcane Damage",
                textColor = colors.ARCANE_SECONDARY,
                statColor = colors.ARCANE_PRIMARY
            },
            arcaneCrit = {
                display = true,
                refName = "ArcaneCritChance",
                text = "Arcane Crit",
                textColor = colors.ARCANE_SECONDARY,
                statColor = colors.ARCANE_PRIMARY
            },
            fireDmg = {
                display = true,
                refName = "FireDmg",
                text = "Fire Damage",
                textColor = colors.FIRE_SECONDARY,
                statColor = colors.FIRE_PRIMARY
            },
            fireCrit = {
                display = true,
                refName = "FireCritChance",
                text = "Fire Crit",
                textColor = colors.FIRE_SECONDARY,
                statColor = colors.FIRE_PRIMARY
            },
            frostDmg = {
                display = true,
                refName = "FrostDmg",
                text = "Frost Damage",
                textColor = colors.FROST_SECONDARY,
                statColor = colors.FROST_PRIMARY
            },
            frostCrit = {
                display = true,
                refName = "FrostCritChance",
                text = "Frost Crit",
                textColor = colors.FROST_SECONDARY,
                statColor = colors.FROST_PRIMARY
            },
            holyDmg = {
                display = true,
                refName = "HolyDmg",
                text = "Holy Damage",
                textColor = colors.HOLY_SECONDARY,
                statColor = colors.HOLY_PRIMARY
            },
            holyCrit = {
                display = true,
                refName = "HolyCritChance",
                text = "Holy Crit",
                textColor = colors.HOLY_SECONDARY,
                statColor = colors.HOLY_PRIMARY
            },
            natureDmg = {
                display = true,
                refName = "NatureDmg",
                text = "Nature Damage",
                textColor = colors.NATURE_SECONDARY,
                statColor = colors.NATURE_PRIMARY
            },
            natureCrit = {
                display = true,
                refName = "NatureCritChance",
                text = "Nature Crit",
                textColor = colors.NATURE_SECONDARY,
                statColor = colors.NATURE_PRIMARY
            },
            physicalDmg = {
                display = true,
                refName = "PhysicalDmg",
                text = "Physical Damage",
                textColor = colors.PHYSICAL_SECONDARY,
                statColor = colors.PHYSICAL_PRIMARY
            },
            physicalCrit = {
                display = true,
                refName = "PhysicalCritChance",
                text = "Physical Crit",
                textColor = colors.PHYSICAL_SECONDARY,
                statColor = colors.PHYSICAL_PRIMARY
            },
            shadowDmg = {
                display = true,
                refName = "ShadowDmg",
                text = "Shadow Damage",
                textColor = colors.SHADOW_SECONDARY,
                statColor = colors.SHADOW_PRIMARY
            },
            shadowCrit = {
                display = true,
                refName = "ShadowCritChance",
                text = "Shadow Crit",
                textColor = colors.SHADOW_SECONDARY,
                statColor = colors.SHADOW_PRIMARY
            },
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

function Profile:Reset()
    local defaultProfile = Profile:GetDefaultProfile()
    ExtendedCharacterStats.profile = defaultProfile.profile
    ExtendedCharacterStats.general = defaultProfile.general
end
