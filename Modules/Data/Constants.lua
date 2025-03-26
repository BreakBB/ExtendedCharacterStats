---@type Data
local Data = ECSLoader:ImportModule("Data")

Data.PHYSICAL_SCHOOL = 1
Data.HOLY_SCHOOL = 2
Data.FIRE_SCHOOL = 3
Data.NATURE_SCHOOL = 4
Data.FROST_SCHOOL = 5
Data.SHADOW_SCHOOL = 6
Data.ARCANE_SCHOOL = 7

Data.WARRIOR = 1
Data.PALADIN = 2
Data.HUNTER = 3
Data.ROGUE = 4
Data.PRIEST = 5
Data.DEATHKNIGHT = 6
Data.SHAMAN = 7
Data.MAGE = 8
Data.WARLOCK = 9
Data.DRUID = 11

Data.BEAST = 1
Data.DRAGONKIN = 2
Data.DEMON = 3
Data.ELEMENTAL = 4
Data.GIANT = 5
Data.UNDEAD = 6
Data.HUMANOID = 7
Data.MECHANICAL = 9
Data.UNCATEGORIZED = 10

Data.setNames = {
    AUGURS_REGALIA = "Augur's Regalia",
    BATTLEGEAR_OF_MIGHT = "Battlegear of Might",
    CHAIN_OF_THE_SCARLET_CRUSADE = "Chain of the Scarlet Crusade",
    FREETHINKERS_ARMOR = "Freethinker's Armor",
    HARUSPEXS_GARB = "Haruspex's Garb",
    STORMRAGE_RAIMENT = "Stormrage Raiment",
    TEN_STORMS = "The Ten Storms",
    THE_EARTHSHATTERER = "The Earthshatterer",
    THE_TWIN_BLADES_OF_AZZINOTH = "The Twin Blades of Azzinoth",
    VESTMENTS_OF_TRANSCENDENCE = "Vestments of Transcendence",
}

Data.enchantIds = {
    BEASTSLAYER = "249", -- +2 physical/spell damage vs beasts
    BIZNICK_SCOPE = "2523", -- 3% Hit from Biznicks 247x128 Accurascope
    BRACER_MANA_REGENERATION = "2565", -- 4 MP5 on bracer
    BRILLIANT_MANA_OIL = "2629", -- 12 MP5
    GLYPH_OF_RENEWAL = "3001", -- 7 MP5 from Honor Hold/Thrallmar enchant
    INCREASED_DAMAGE_BEAST_10 = "192", -- +10 physical/spell vs beasts
    INCREASED_DAMAGE_BEAST_12 = "193", -- +12 physical/spell vs beasts
    INCREASED_DAMAGE_BEAST_14 = "194", -- +14 physical/spell vs beasts
    INCREASED_DAMAGE_BEAST_2 = "188", -- +2 physical/spell vs beasts
    INCREASED_DAMAGE_BEAST_4 = "189", -- +4 physical/spell vs beasts
    INCREASED_DAMAGE_BEAST_6 = "190", -- +6 physical/spell vs beasts
    INCREASED_DAMAGE_BEAST_8 = "191", -- +8 physical/spell vs beasts
    INCREASE_SPELL_DAM_UNDEAD_100 = "3592", -- 100 spellpower vs undead (wotlk)
    INCREASE_SPELL_DAM_UNDEAD_60 = "2685", -- 60 spell power vs undead
    INSCRIPTION_OF_FAITH = "2980", -- 4 MP5 from aldor enchant
    LESSER_BEAST_SLAYER = "853", -- +6 physical/spell vs beasts
    LESSER_ELEMENTAL_SLAYER = "854", -- +6 physical/spell vs elementals
    LESSER_MANA_OIL = "2625", -- 8 MP5
    MINOR_BEAST_SLAYER = "31", -- +2 physical/spell vs beasts
    MINOR_MANA_OIL = "2624", -- 4 MP5
    PROPHETIC_AURA = "2590", -- 4 MP5 for priest ZG Enchant
    RESILIENCE_OF_THE_SCOURGE = "2715", -- 4 MP5 for priest ZG Enchant
    RESTORE_MANA_PRIME = "3150", -- 6 MP5 on chest
    UNDEAD_DEMON_SLAYER_150 = "3093", -- +150 melee/ranged attack power vs undead and demons (tbc)
    UNDEAD_SLAYER = "3247", -- 140 melee/ranged attack power vs undead (wotlk)
    UNDEAD_SLAYER_100 = "2684", -- +100 melee/ranged Attack Power vs Undead
    UNDEAD_SLAYER_170 = "3593", -- 170 melee/ranged attack power vs undead (wotlk)
    UNDEAD_SLAYER_200 = "7896", -- 200 melee/ranged attack power vs undead (SoD)
}

Data.gemIds = {
    FOUR_MP5_GEMS = {"32202"},
    THREE_MP5_GEMS = {"24037"},
    TWO_MP5_GEMS = {"30589", "32225", "24065", "30594", "31865", "32214", "30606", "23121", "24057", "32216", "30603", "30560", "30550"},
    ONE_MP5_GEMS = {"23106", "31864", "28465", "23109"}
}

Data.itemIds = {
    BEAST_SLAYING_24 = {11628, 11629},
    BEAST_SLAYING_30 = {11906, 7756, 3566},
    BEAST_SLAYING_33 = {15783, 15782},
    BEAST_SLAYING_60 = {7710, 19946},
    BEAST_SLAYING_99 = {231272, 231849}, -- sod
    DEMON_SLAYING_33 = {10697, 10696},
    DEMON_SLAYING_45 = {18715, 20487},
    DEMON_SLAYING_141 = {231277, 231864}, -- sod
    DRAGON_SLAYING_60 = {231274, 231847}, -- sod
    DRAGON_SLAYING_141 = {231273, 231846}, -- sod
    INCREASE_SPELL_DAM_UNDEAD_26 = {236722, 236739, 236723, 236738, 236724, 236737},
    INCREASE_SPELL_DAM_UNDEAD_35 = {23084, 18346},
    INCREASE_SPELL_DAM_UNDEAD_35_SOD = {236716, 236734, 236725},
    INCREASE_SPELL_DAM_UNDEAD_48 = {23085, 24198},
    INCREASE_SPELL_DAM_UNDEAD_48_SOD = {236717, 236735, 236726},
    INCREASE_SPELL_DAM_UNDEAD_62 = {236736, 236718, 236727},
    UNDEAD_SLAYER_30 = {867, 10805},
    UNDEAD_SLAYER_45_SOD = {236746, 236748, 236747, 236732, 236733, 236731},
    UNDEAD_SLAYER_45 = {23090, 23092, 23093}, -- without specter's blade
    UNDEAD_SLAYER_60_SOD = {236712, 236710, 236711},
    UNDEAD_SLAYER_60 = {23078, 23082, 23081},
    UNDEAD_SLAYER_81_SOD = {236714, 236715, 236713},
    UNDEAD_SLAYER_81 = {23087, 23088, 23089},
    UNDEAD_SLAYER_108 = {236708, 236709, 236707}, -- sod
}
