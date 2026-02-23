---@class Profile
local Profile = ECSLoader:CreateModule("Profile")

---@type Utils
local Utils = ECSLoader:ImportModule("Utils")

---@return number
function Profile.GetProfileVersion()
    return 24
end

---@return ECSProfile
local function GetDefaultStatsProfile()
    local colors = Utils.colors

    return {
        general = {
            display = true,
            refName = "GeneralHeader",
            text = "General",

            movementSpeed = {
                display = true,
                refName = "MovementSpeed",
                text = "Movement speed"
            },
        },

        melee = {
            display = true,
            refName = "MeleeHeader",
            text = "Melee",

            hit = {
                display = true,
                isSubGroup = true,
                refName = "MeleeHitHeader",
                text = "Hit",

                rating = {
                    display = true,
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
            glance = {
                display = true,
                isSubGroup = true,
                refName = "GlanceChanceHeader",
                text = "Glancing blow",
                sameLevel = {
                    display = true,
                    refName = "GlanceHitChanceSameLevel",
                    text = "Chance",
                    textColor = colors.GRAY,
                    statColor = colors.WHITE
                },
                bossLevel = {
                    display = true,
                    refName = "GlanceHitChanceBossLevel",
                    text = "Chance (Lvl + 3)",
                    textColor = colors.GRAY,
                    statColor = colors.WHITE
                },
                damageSameLevel = {
                    display = true,
                    refName = "GlanceDamageSameLevel",
                    text = "Damage",
                    textColor = colors.GRAY,
                    statColor = colors.WHITE
                },
                damageBossLevel = {
                    display = true,
                    refName = "GlanceDamageBossLevel",
                    text = "Damage (Lvl + 3)",
                    textColor = colors.GRAY,
                    statColor = colors.WHITE
                },
            },
            attackPower = {
                display = true,
                refName = "MeleeAttackPower",
                text = "Attack power",
                textColor = colors.ATTACK_POWER_SECONDARY,
                statColor = colors.ATTACK_POWER_PRIMARY
            },
            crit = {
                display = true,
                refName = "MeleeCritChance",
                text = "Crit. chance",
                textColor = colors.CRIT_SECONDARY,
                statColor = colors.CRIT_PRIMARY
            },
            penetration = {
                display = true,
                refName = "MeleeArmorPenetration",
                text = "Armor pen.",
                textColor = colors.ATTACK_SPEED_SECONDARY,
                statColor = colors.ATTACK_SPEED_PRIMARY,
            },
            penetrationRating = {
                display = true,
                refName = "MeleeArmorPenetrationRating",
                text = "Armor pen. rating",
                textColor = colors.ATTACK_SPEED_SECONDARY,
                statColor = colors.ATTACK_SPEED_PRIMARY,
            },
            expertise = {
                display = true,
                refName = "Expertise",
                text = "Expertise"
            },
            expertiseRating = {
                display = true,
                refName = "ExpertiseRating",
                text = "Expertise rating"
            },
            hasteRating = {
                display = true,
                refName = "MeleeHasteRating",
                text = "Haste rating",
                textColor = colors.HASTE_RATING_SECONDARY,
                statColor = colors.HASTE_RATING_PRIMARY
            },
            hasteBonus = {
                display = true,
                refName = "MeleeHasteBonus",
                text = "Haste bonus",
                textColor = colors.HASTE_RATING_SECONDARY,
                statColor = colors.HASTE_RATING_PRIMARY
            },
            attackSpeed = {
                display = true,
                isSubGroup = true,
                refName = "MeleeAttackSpeedHeader",
                text = "Attack speed",

                mainHand = {
                    display = true,
                    refName = "MeleeAttackSpeedMainHand",
                    text = "Main hand",
                    textColor = colors.ATTACK_SPEED_SECONDARY,
                    statColor = colors.ATTACK_SPEED_PRIMARY
                },
                offHand = {
                    display = true,
                    refName = "MeleeAttackSpeedOffHand",
                    text = "Off hand",
                    textColor = colors.ATTACK_SPEED_SECONDARY,
                    statColor = colors.ATTACK_SPEED_PRIMARY
                },
            },
        },

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
                text = "Attack power",
                textColor = colors.ATTACK_POWER_SECONDARY,
                statColor = colors.ATTACK_POWER_PRIMARY
            },
            crit = {
                display = true,
                refName = "RangedCritChance",
                text = "Crit. chance",
                textColor = colors.CRIT_SECONDARY,
                statColor = colors.CRIT_PRIMARY
            },
            penetration = {
                display = true,
                refName = "RangedArmorPenetration",
                text = "Armor pen.",
                textColor = colors.ATTACK_SPEED_SECONDARY,
                statColor = colors.ATTACK_SPEED_PRIMARY,
            },
            penetrationRating = {
                display = true,
                refName = "RangedArmorPenetrationRating",
                text = "Armor pen. rating",
                textColor = colors.ATTACK_SPEED_SECONDARY,
                statColor = colors.ATTACK_SPEED_PRIMARY,
            },
            hasteRating = {
                display = true,
                refName = "RangedHasteRating",
                text = "Haste rating",
                textColor = colors.HASTE_RATING_SECONDARY,
                statColor = colors.HASTE_RATING_PRIMARY
            },
            hasteBonus = {
                display = true,
                refName = "RangedHasteBonus",
                text = "Haste bonus",
                textColor = colors.HASTE_RATING_SECONDARY,
                statColor = colors.HASTE_RATING_PRIMARY
            },
            attackSpeed = {
                display = true,
                refName = "RangedAttackSpeed",
                text = "Attack speed",
                textColor = colors.ATTACK_SPEED_SECONDARY,
                statColor = colors.ATTACK_SPEED_PRIMARY
            },
        },

        defense = {
            display = true,
            refName = "DefenseHeader",
            text = "Defense",

            armor = {display = true, refName = "Armor", text = "Armor"},
            meleeCritReduction = {
                display = true,
                refName = "MeleeCritReduction",
                text = "Melee crit. reduction"
            },
            rangedCritReduction = {
                display = true,
                refName = "RangedCritReduction",
                text = "Ranged crit. reduction"
            },
            spellCritReduction = {
                display = true,
                refName = "SpellCritReduction",
                text = "Spell crit. reduction"
            },
            avoidance = {
                display = true,
                refName = "Avoidance",
                text = "Avoidance"
            },
            avoidanceBoss = {
                display = true,
                refName = "AvoidanceBoss",
                text = "Avoidance (Lvl +3)"
            },
            defenseRating = {
                display = true,
                refName = "DefenseRating",
                text = "Defense rating"
            },
            defense = {
                display = true,
                refName = "DefenseValue",
                text = "Defense"
            },
            blockChance = {
                display = true,
                refName = "BlockChance",
                text = "Block chance"
            },
            blockValue = {
                display = true,
                refName = "BlockValue",
                text = "Block value"
            },
            parry = {
                display = true,
                refName = "ParryChance",
                text = "Parry chance"
            },
            dodge = {
                display = true,
                refName = "DodgeChance",
                text = "Dodge chance"
            },
            resilienceRating = {
                display = true,
                refName = "ResilienceValue",
                text = "Resilience"
            },
        },

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

        spell = {
            display = true,
            refName = "SpellHeader",
            text = "Spell",

            arcane = {
                display = true,
            },
            fire = {
                display = true,
            },
            frost = {
                display = true,
            },
            holy = {
                display = true,
            },
            nature = {
                display = true,
            },
            physical = {
                display = true,
            },
            shadow = {
                display = true,
            },

            ---@type SubCategory
            hit = {
                display = true,
                isSubGroup = true,
                refName = "SpellHitHeader",
                text = "Hit",

                rating = {
                    display = true,
                    refName = "SpellHitRating",
                    text = "Hit rating",
                    textColor = colors.HIT_SECONDARY,
                    statColor = colors.HIT_PRIMARY
                },
                bonus = {
                    display = true,
                    refName = "SpellHitBonus",
                    text = "Hit bonus",
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
                arcaneHitBonus = {
                    display = true,
                    refName = "ArcaneHitBonus",
                    text = "Arcane hit bonus",
                    textColor = colors.ARCANE_SECONDARY,
                    statColor = colors.ARCANE_PRIMARY
                },
                arcaneMissChance = {
                    display = true,
                    refName = "ArcaneMissChance",
                    text = "Arcane miss",
                    textColor = colors.ARCANE_SECONDARY,
                    statColor = colors.ARCANE_PRIMARY
                },
                arcaneMissChanceBoss = {
                    display = true,
                    refName = "ArcaneMissChanceBoss",
                    text = "Arcane miss (Lvl + 3)",
                    textColor = colors.ARCANE_SECONDARY,
                    statColor = colors.ARCANE_PRIMARY
                },
                fireHitBonus = {
                    display = true,
                    refName = "FireHitBonus",
                    text = "Fire hit bonus",
                    textColor = colors.FIRE_SECONDARY,
                    statColor = colors.FIRE_PRIMARY
                },
                fireMissChance = {
                    display = true,
                    refName = "FireMissChance",
                    text = "Fire miss",
                    textColor = colors.FIRE_SECONDARY,
                    statColor = colors.FIRE_PRIMARY
                },
                fireMissChanceBoss = {
                    display = true,
                    refName = "FireMissChanceBoss",
                    text = "Fire miss (Lvl + 3)",
                    textColor = colors.FIRE_SECONDARY,
                    statColor = colors.FIRE_PRIMARY
                },
                frostHitBonus = {
                    display = true,
                    refName = "FrostHitBonus",
                    text = "Frost hit bonus",
                    textColor = colors.FROST_SECONDARY,
                    statColor = colors.FROST_PRIMARY
                },
                frostMissChance = {
                    display = true,
                    refName = "FrostMissChance",
                    text = "Frost miss",
                    textColor = colors.FROST_SECONDARY,
                    statColor = colors.FROST_PRIMARY
                },
                frostMissChanceBoss = {
                    display = true,
                    refName = "FrostMissChanceBoss",
                    text = "Frost miss (Lvl + 3)",
                    textColor = colors.FROST_SECONDARY,
                    statColor = colors.FROST_PRIMARY
                },
                holyHitBonus = {
                    display = true,
                    refName = "HolyHitBonus",
                    text = "Holy hit bonus",
                    textColor = colors.HOLY_SECONDARY,
                    statColor = colors.HOLY_PRIMARY
                },
                holyMissChance = {
                    display = true,
                    refName = "HolyMissChance",
                    text = "Holy miss",
                    textColor = colors.HOLY_SECONDARY,
                    statColor = colors.HOLY_PRIMARY
                },
                holyMissChanceBoss = {
                    display = true,
                    refName = "HolyMissChanceBoss",
                    text = "Holy miss (Lvl + 3)",
                    textColor = colors.HOLY_SECONDARY,
                    statColor = colors.HOLY_PRIMARY
                },
                natureHitBonus = {
                    display = true,
                    refName = "NatureHitBonus",
                    text = "Nature hit bonus",
                    textColor = colors.NATURE_SECONDARY,
                    statColor = colors.NATURE_PRIMARY
                },
                natureMissChance = {
                    display = true,
                    refName = "NatureMissChance",
                    text = "Nature miss",
                    textColor = colors.NATURE_SECONDARY,
                    statColor = colors.NATURE_PRIMARY
                },
                natureMissChanceBoss = {
                    display = true,
                    refName = "NatureMissChanceBoss",
                    text = "Nature miss (Lvl + 3)",
                    textColor = colors.NATURE_SECONDARY,
                    statColor = colors.NATURE_PRIMARY
                },
                physicalHitBonus = {
                    display = true,
                    refName = "PhysicalHitBonus",
                    text = "Physical hit bonus",
                    textColor = colors.PHYSICAL_SECONDARY,
                    statColor = colors.PHYSICAL_PRIMARY
                },
                physicalMissChance = {
                    display = true,
                    refName = "PhysicalMissChance",
                    text = "Physical miss",
                    textColor = colors.PHYSICAL_SECONDARY,
                    statColor = colors.PHYSICAL_PRIMARY
                },
                physicalMissChanceBoss = {
                    display = true,
                    refName = "PhysicalMissChanceBoss",
                    text = "Physical miss (Lvl + 3)",
                    textColor = colors.PHYSICAL_SECONDARY,
                    statColor = colors.PHYSICAL_PRIMARY
                },
                shadowHitBonus = {
                    display = true,
                    refName = "ShadowHitBonus",
                    text = "Shadow hit bonus",
                    textColor = colors.SHADOW_SECONDARY,
                    statColor = colors.SHADOW_PRIMARY
                },
                shadowMissChance = {
                    display = true,
                    refName = "ShadowMissChance",
                    text = "Shadow miss",
                    textColor = colors.SHADOW_SECONDARY,
                    statColor = colors.SHADOW_PRIMARY
                },
                shadowMissChanceBoss = {
                    display = true,
                    refName = "ShadowMissChanceBoss",
                    text = "Shadow miss (Lvl + 3)",
                    textColor = colors.SHADOW_SECONDARY,
                    statColor = colors.SHADOW_PRIMARY
                },
            },
            hasteRating = {
                display = true,
                refName = "SpellHasteRating",
                text = "Haste rating",
                textColor = colors.HASTE_RATING_SECONDARY,
                statColor = colors.HASTE_RATING_PRIMARY
            },
            hasteBonus = {
                display = true,
                refName = "SpellHasteBonus",
                text = "Haste bonus",
                textColor = colors.HASTE_RATING_SECONDARY,
                statColor = colors.HASTE_RATING_PRIMARY
            },
            penetration = {display = true, refName = "SpellPenetration", text = "Penetration"},

            crit = {
                display = true,
                arcane = {
                    display = true,
                    refName = "ArcaneCritChance",
                    text = "Arcane crit.",
                    textColor = colors.ARCANE_SECONDARY,
                    statColor = colors.ARCANE_PRIMARY
                },
                fire = {
                    display = true,
                    refName = "FireCritChance",
                    text = "Fire crit.",
                    textColor = colors.FIRE_SECONDARY,
                    statColor = colors.FIRE_PRIMARY
                },
                frost = {
                    display = true,
                    refName = "FrostCritChance",
                    text = "Frost crit.",
                    textColor = colors.FROST_SECONDARY,
                    statColor = colors.FROST_PRIMARY
                },
                holy = {
                    display = true,
                    refName = "HolyCritChance",
                    text = "Holy crit.",
                    textColor = colors.HOLY_SECONDARY,
                    statColor = colors.HOLY_PRIMARY
                },
                nature = {
                    display = true,
                    refName = "NatureCritChance",
                    text = "Nature crit.",
                    textColor = colors.NATURE_SECONDARY,
                    statColor = colors.NATURE_PRIMARY
                },
                physical = {
                    display = true,
                    refName = "PhysicalCritChance",
                    text = "Physical crit.",
                    textColor = colors.PHYSICAL_SECONDARY,
                    statColor = colors.PHYSICAL_PRIMARY
                },
                shadow = {
                    display = true,
                    refName = "ShadowCritChance",
                    text = "Shadow crit.",
                    textColor = colors.SHADOW_SECONDARY,
                    statColor = colors.SHADOW_PRIMARY
                },
            }
        },

        spellBonus = {
            display = true,
            refName = "SpellBonusHeader",

            bonusHealing = {
                display = true,
                refName = "BonusHealing",
                text = "Healing power",
                textColor = colors.HEALING_SECONDARY,
                statColor = colors.HEALING_PRIMARY
            },
            arcaneDmg = {
                display = true,
                refName = "ArcaneDmg",
                text = "Arcane damage",
                textColor = colors.ARCANE_SECONDARY,
                statColor = colors.ARCANE_PRIMARY
            },
            fireDmg = {
                display = true,
                refName = "FireDmg",
                text = "Fire damage",
                textColor = colors.FIRE_SECONDARY,
                statColor = colors.FIRE_PRIMARY
            },
            frostDmg = {
                display = true,
                refName = "FrostDmg",
                text = "Frost damage",
                textColor = colors.FROST_SECONDARY,
                statColor = colors.FROST_PRIMARY
            },
            holyDmg = {
                display = true,
                refName = "HolyDmg",
                text = "Holy damage",
                textColor = colors.HOLY_SECONDARY,
                statColor = colors.HOLY_PRIMARY
            },
            natureDmg = {
                display = true,
                refName = "NatureDmg",
                text = "Nature damage",
                textColor = colors.NATURE_SECONDARY,
                statColor = colors.NATURE_PRIMARY
            },
            physicalDmg = {
                display = true,
                refName = "PhysicalDmg",
                text = "Physical damage",
                textColor = colors.PHYSICAL_SECONDARY,
                statColor = colors.PHYSICAL_PRIMARY
            },
            shadowDmg = {
                display = true,
                refName = "ShadowDmg",
                text = "Shadow damage",
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
        qualityColorsIntensity = 0.75,
        headerFontSize = 11,
        statFontSize = 10,
        profileVersion = 0,
        window = {
            height = 422,
            width = 195,
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
