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

Data.setNames = {
    BATTLEGEAR_OF_MIGHT = "Battlegear of Might",
    STORMRAGE_RAIMENT = "Stormrage Raiment",
    VESTMENTS_OF_TRANSCENDENCE = "Vestments of Transcendence",
    TEN_STORMS = "The Ten Storms",
    THE_EARTHSHATTERER = "The Earthshatterer",
    HARUSPEXS_GARB = "Haruspex's Garb",
    AUGURS_REGALIA = "Augur's Regalia",
    FREETHINKERS_ARMOR = "Freethinker's Armor"
}

Data.enchantIds = {
    BIZNICK_SCOPE = "2523", -- 3% Hit from Biznicks 247x128 Accurascope
    BRACER_MANA_REGENERATION = "2565", -- 4 MP5 on bracer
    PROPHETIC_AURA = "2590", -- 4 MP5 for priest ZG Enchant
    RESILIENCE_OF_THE_SCOURGE = "2715", -- 4 MP5 for priest ZG Enchant
    INSCRIPTION_OF_FAITH = "2980", -- 4 MP5 from aldor enchant
    GLYPH_OF_RENEWAL = "3001", -- 7 MP5 from Honor Hold/Thrallmar enchant
    RESTORE_MANA_PRIME = "3150", -- 6 MP5 on chest
    BRILLIANT_MANA_OIL = "2629", -- 12 MP5
    LESSER_MANA_OIL = "2625", -- 8 MP5
    MINOR_MANA_OIL = "2624", -- 4 MP5
}

Data.gemIds = {
    FOUR_MP5_GEMS = {"32202"},
    THREE_MP5_GEMS = {"24037"},
    TWO_MP5_GEMS = {"30589", "32225", "24065", "30594", "31865", "32214", "30606", "23121", "24057", "32216", "30603", "30560", "30550"},
    ONE_MP5_GEMS = {"23106", "31864", "28465", "23109"}
}
