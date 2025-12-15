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
    BIZNICK_SCOPE = "2523", -- 3% Hit from Biznicks 247x128 Accurascope
    BRACER_MANA_REGENERATION = "2565", -- 4 MP5 on bracer
    BRILLIANT_MANA_OIL = "2629", -- 12 MP5
    GLYPH_OF_RENEWAL = "3001", -- 7 MP5 from Honor Hold/Thrallmar enchant
    INSCRIPTION_OF_FAITH = "2980", -- 4 MP5 from aldor enchant
    LESSER_ELEMENTAL_SLAYER = "854", -- +6 physical/spell vs elementals
    LESSER_MANA_OIL = "2625", -- 8 MP5
    MINOR_MANA_OIL = "2624", -- 4 MP5
    PROPHETIC_AURA = "2590", -- 4 MP5 for priest ZG Enchant
    RESILIENCE_OF_THE_SCOURGE = "2715", -- 4 MP5 for priest ZG Enchant
    RESTORE_MANA_PRIME = "3150", -- 6 MP5 on chest
    UNDEAD_DEMON_SLAYER_150 = "3093", -- +150 melee/ranged attack power vs undead and demons (tbc)
}
Data.enchantsIncreaseSpellDamageUndead = { -- spell
    ["2685"] = 60, -- 60 spell power vs undead
    ["3592"] = 100, -- 100 spellpower vs undead (wotlk)
}
Data.enchantsBeastSlayer = { -- physical/spell
    ["31"] = 2, -- +2 physical/spell vs beasts
    ["188"] = 2, -- +2 physical/spell vs beasts
    ["189"] = 4, -- +4 physical/spell vs beasts
    ["190"] = 6, -- +6 physical/spell vs beasts
    ["191"] = 8, -- +8 physical/spell vs beasts
    ["192"] = 10, -- +10 physical/spell vs beasts
    ["193"] = 12, -- +12 physical/spell vs beasts
    ["194"] = 14, -- +14 physical/spell vs beasts
    ["249"] = 2, -- +2 physical/spell damage vs beasts
    ["853"] = 6, -- +6 physical/spell vs beasts
}
Data.enchantsUndeadSlayer = { -- melee/ranged
    ["2684"] = 100, -- +100 melee/ranged Attack Power vs Undead
    ["3247"] = 140, -- 140 melee/ranged attack power vs undead (wotlk)
    ["3593"] = 170, -- 170 melee/ranged attack power vs undead (wotlk)
    ["7896"] = 200, -- 200 melee/ranged attack power vs undead (SoD)
}

Data.gemIds = {
    FOUR_MP5_GEMS = {"32202"},
    THREE_MP5_GEMS = {"24037"},
    TWO_MP5_GEMS = {"30589", "32225", "24065", "30594", "31865", "32214", "30606", "23121", "24057", "32216", "30603", "30560", "30550"},
    ONE_MP5_GEMS = {"23106", "31864", "28465", "23109"}
}

Data.itemsBeastSlaying = { -- ranged/melee
    [1465] = 18, -- tigerbane
    [3566] = 30, -- Raptorbane Armor
    [7710] = 60, -- Loksey's Training Stick
    [7756] = 30, -- Dog Training Gloves
    [11628] = 24, -- Houndmaster's Bow
    [11629] = 24, -- Houndmaster's Rifle
    [11906] = 30, -- Beastsmasher
    [11907] = 72, -- Beastslayer
    [12709] = 45, -- pip's skinner
    [13212] = 48, -- Halycon's Spiked Collar
    [15782] = 33, -- Beaststalker Blade
    [15783] = 33, -- Beasthunter Dagger
    [16658] = 18, -- Wildhunter Cloak
    [19946] = 60, -- Tigule's Harpoon
    [37018] = -40, -- G.E.H.T.A.
    [231272] = 99, -- Tigule's Harpoon
    [231849] = 99, -- Tigule's Harpoon
}
Data.itemsDemonSlaying = { -- ranged/melee
    [10696] = 33, -- Enchanted Azsharite Felbane Sword
    [10697] = 33, -- Enchanted Azsharite Felbane Dagger
    [10698] = 78, -- Enchanted Azsharite Felbane Staff
    [13044] = 99, -- Demonslayer
    [18715] = 45, -- Lok'delar, Stave of the Ancient Keepers
    [19963] = 117, -- Pitchfork of Madness
    [20487] = 45, -- Lok'delar, Stave of the Ancient Keepers DEP
    [29398] = 39, -- Circle of Banishing
    [30788] = 93, -- Illidari-Bane Dagger
    [31745] = 93, -- Illidari-Bane Broadsword
    [220575] = 39 -- Eater of the Damned
    [228332] = 45, -- Lok'delar, Stave of the Ancient Keepers
    [231277] = 141, -- Pitchfork of Madness
    [231864] = 141, -- Pitchfork of Madness
}
Data.itemsUndeadDemonSlaying = { -- ranged/melee
    [23207] = 150, -- Champion of the Dawn
    [236352] = 157, -- Champion of the Dawn
}
Data.itemsDragonSlaying = { -- ranged/melee
    [19961] = 48, -- Gri'lek's Grinder
    [19962] = 117, -- Gri'lek's Carver
    [220965] = 117, -- Scalebane Greataxe
    [221457] = 36, -- Libram of Draconic Destruction
    [231273] = 141, -- Gri'lek's Carver
    [231274] = 60, -- Gri'lek's Grinder
    [231846] = 141, -- Gri'lek's Carver
    [231847] = 60, -- Gri'lek's Grinder
}
Data.itemsElementalSlaying = { -- ranged/melee
    [18310] = 36, -- Fiendish Machete
    [228056] = 36, -- Fiendish Machete
    [228486] = 75, -- Treant's Bane
}
Data.itemsIncreaseSpellDamageUndeadDemon = { -- spell
    [23207] = 85, -- Champion of the Dawn
    [236351] = 89, -- Champion of the Dawn
}
Data.itemsIncreaseSpellDamageUndead = { -- spell
    [18346] = 35, -- Threadbare Trousers
    [19812] = 48, -- Rune of the Dawn
    [23084] = 35, -- Gloves of Undead Cleansing
    [23085] = 48, -- Robe of Undead Cleansing
    [23091] = 26, -- Bracers of Undead Cleansing
    [236716] = 35, -- Bracers of Undead Cleansing
    [236717] = 48, -- Gloves of Undead Cleansing
    [236718] = 65, -- Robe of Undead Cleansing
    [236722] = 26, -- Bracers of Undead Warding
    [236723] = 26, -- Gloves of Undead Warding
    [236724] = 26, -- Robe of Undead Warding
    [236725] = 35, -- Wristwraps of Undead Cleansing
    [236726] = 48, -- Handwraps of Undead Cleansing
    [236727] = 65, -- Tunic of Undead Cleansing
    [236734] = 35, -- Wristguards of Undead Cleansing
    [236735] = 48, -- Handguards of Undead Cleansing
    [236736] = 65, -- Chestguard of Undead Cleansing
    [236737] = 26, -- Wristguards of Undead Warding
    [236738] = 26, -- Handguards of Undead Warding
    [236739] = 26, -- Chestguard of Undead Warding
}
Data.itemsUndeadSlaying = { -- ranged/melee
    [867] = 30, -- Gloves of Holy Might
    [10805] = 30, -- Eater of the Dead
    [13017] = 66, -- Hellslayer Battle Axe
    [13209] = 81, -- Seal of the Dawn
    [18758] = 45, -- Specter's Blade
    [23078] = 60, -- Gauntlets of Undead Slaying
    [23081] = 60, -- Handwraps of Undead Slaying
    [23082] = 60, -- Handguards of Undead Slaying
    [23087] = 81, -- Breastplate of Undead Slaying
    [23088] = 81, -- Chestguard of Undead Slaying
    [23089] = 81, -- Tunic of Undead Slaying
    [23090] = 45, -- Bracers of Undead Slaying
    [23092] = 45, -- Wristguards of Undead Slaying
    [23093] = 45, -- Wristwraps of Undead Slaying
    [209574] = 15, -- Discarded Tenets of the Silver Hand
    [220575] = 39, -- Eater of the Damned
    [228030] = 30, -- Malicious Axe
    [236707] = 108, -- Tunic of Undead Slaying
    [236708] = 108, -- Breastplate of Undead Slaying
    [236709] = 108, -- Chestguard of Undead Slaying
    [236710] = 60, -- Wristguards of Undead Slaying
    [236711] = 60, -- Wristwraps of Undead Slaying
    [236712] = 60, -- Bracers of Undead Slaying
    [236713] = 81, -- Handwraps of Undead Slaying
    [236714] = 81, -- Gauntlets of Undead Slaying
    [236715] = 81, -- Handguards of Undead Slaying
    [236731] = 45, -- Wristwraps of Undead Warding
    [236732] = 45, -- Handwraps of Undead Warding
    [236733] = 45, -- Tunic of Undead Warding
    [236746] = 45, -- Bracers of Undead Warding
    [236747] = 45, -- Gauntlets of Undead Warding
    [236748] = 45, -- Breastplate of Undead Warding
}
Data.buffsUndeadAttackPower = { -- melee
    [17352] = 200, -- Argent Avenger
    [24833] = 300, -- holy mightstone
    [28486] = 30, -- Scourgebane Draught
}
Data.buffsUndeadSpellPower = { -- spell
    [24833] = 400, -- holy mightstone
    [28488] = 15, -- Scourgebane Infusion
    [60597] = 12000, -- Blessing of the Crusade
}
