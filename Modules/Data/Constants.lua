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
Data.SHAMAN = 7
Data.MAGE = 8
Data.WARLOCK = 9
Data.DRUID = 11

Data.setNames = {}
Data.setNames.BATTLEGEAR_OF_MIGHT = "Battlegear of Might"
Data.setNames.STORMRAGE_RAIMENT = "Stormrage Raiment"
Data.setNames.VESTMENTS_OF_TRANSCENDENCE = "Vestments of Transcendence"
Data.setNames.TEN_STORMS = "The Ten Storms"
Data.setNames.HARUSPEXS_GARB = "Haruspex's Garb"
Data.setNames.AUGURS_REGALIA = "Augur's Regalia"
Data.setNames.FREETHINKERS_ARMOR = "Freethinker's Armor"

Data.enchantIds = {
    BIZNIK_SCOPE = "2523", -- 3% Hit from Biznicks 247x128 Accurascope
    BRACER_MANA_REGENERATION = "2565", -- 4 MP5 on bracer
    PROPHETIC_AURA = "2590", -- 4 MP5 for priest ZG Enchant
    BRILLIANT_MANA_OIL = "2629", -- 12 MP5
    LESSER_MANA_OIL = "2625", -- 8 MP5
    MINOR_MANA_OIL = "2624", -- 4 MP5
}
