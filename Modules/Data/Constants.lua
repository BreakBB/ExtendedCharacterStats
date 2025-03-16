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
    AUGURS_REGALIA = "Augur's Regalia",
    BATTLEGEAR_OF_MIGHT = "Battlegear of Might",
    BONESCYTHE_LEATHERS = "Bonescythe Leathers",
    DREAMWALKER_GUARDIAN = "Dreamwalker Guardian",
    DREADNOUGHTS_BATTLEGEAR = "Dreadnought's Battlegear",
    FREETHINKERS_ARMOR = "Freethinker's Armor",
    HARUSPEXS_GARB = "Haruspex's Garb",
    PLAGUEHEART_STITCHINGS = "Plagueheart Stitchings",
    REDEMPTION_BULWARK = "Redemption Bulwark",
    STORMRAGE_RAIMENT = "Stormrage Raiment",
    SYMBOLS_OF_UNENDING_LIFE = "Symbols of Unending Life",
    TEN_STORMS = "The Ten Storms",
    THE_EARTHSHATTERER = "The Earthshatterer",
    THE_EARTHSHATTERER_RESOLVE = "The Earthshatterer Resolve",
    VESTMENTS_OF_TRANSCENDENCE = "Vestments of Transcendence",
}

Data.enchantIds = {
    ANIMALISTIC_EXPERTISE = "7875", -- Your melee attacks have 5% less chance to be Dodged or Parried.
    BIZNICK_SCOPE = "2523", -- 3% Hit from Biznicks 247x128 Accurascope
    BRACER_MANA_REGENERATION = "2565", -- 4 MP5 on bracer
    BRILLIANT_MANA_OIL = "2629", -- 12 MP5
    GLYPH_OF_RENEWAL = "3001", -- 7 MP5 from Honor Hold/Thrallmar enchant
    INSCRIPTION_OF_FAITH = "2980", -- 4 MP5 from aldor enchant
    LESSER_MANA_OIL = "2625", -- 8 MP5
    MINOR_MANA_OIL = "2624", -- 4 MP5
    PROPHETIC_AURA = "2590", -- 4 MP5 for priest ZG Enchant
    RESILIENCE_OF_THE_SCOURGE = "2715", -- 5 MP5 Sapphiron shoulder enchant
    RESTORE_MANA_PRIME = "3150", -- 6 MP5 on chest
}

Data.gemIds = {
    FOUR_MP5_GEMS = {"32202"},
    THREE_MP5_GEMS = {"24037"},
    TWO_MP5_GEMS = {"30589", "32225", "24065", "30594", "31865", "32214", "30606", "23121", "24057", "32216", "30603", "30560", "30550"},
    ONE_MP5_GEMS = {"23106", "31864", "28465", "23109"}
}

Data.itemsIds = {
    INCREASED_EXPERTISE_1 = {233585, 234650, 233397, 233693, 233692, 233401, 233689, 236130, 236056, 236022, 233635, 237512, 236034, 236032, 236030, 236023, 236039, 236038, 236036, 236035, 236037,
        236026, 236031, 236033, 236029, 236040, 235888, 233651, 233658, 233376, 236051, 236055, 236052, 236050, 236054, 233634, 234984, 233659, 233662, 233663, 233661, 234748, 236020, 236012, 236005,
        236010, 236019, 236007, 236016, 236006, 236008, 236009, 236011, 236021, 236209, 236201, 236206, 236215, 236205, 236204, 236203, 236208, 236211, 236212, 236218, 236202, 236210, 236171, 236172,
        236175, 236174, 236170, 233637, 233582, 233711, 233412, 233413, 233415, 236222, 236309, 233579, 233618, 236339, 237275, 236260, 236319, 233992, 236139, 236207, 233642, 236304, 236262, 233612,
        236125, 236133, 236141, 236137, 236138, 236129, 236128, 236136, 236135, 236140, 236124, 236134, 236013, 233600, 233442, 235005, 236216, 236176, 236311, 233699, 233700, 233668, 233665, 233666,
        236306, 236341, 236293, 236263, 236255
	},
    INCREASED_EXPERTISE_2 = {233640, 234985, 236300, 233614},
    TIMEWORN = {234146, 234147, 233564, 233561, 233617, 234148, 234149, 233644, 234075, 234150, 233559, 233618, 233645, 233522, 233563, 233567, 233566, 233560, 233619, 233520, 233521, 233523, 233568,
        234098, 234099, 234100, 234102, 233578, 233582, 233579, 235047, 233646, 233574, 233583, 233573, 233575, 233584, 233577, 234090, 234093, 234094, 234095, 234091, 233635, 233631, 233633, 233637,
        233632, 234156, 234157, 233611, 233612, 233614, 233613, 233623, 233622, 233590, 233592, 233593, 233594, 233595, 233591, 234069, 234068, 234070, 234071, 234072, 234064, 234063, 234065, 234066,
        234062, 234161, 234162, 234163, 234164, 234165, 234166, 234078, 234123, 234073, 234081, 234120, 234088, 234082, 234087, 234084, 234077, 234117, 234103, 234105, 234106, 234107, 234108, 234109,
        234110, 234111, 234114, 233625, 233624, 233607, 233610, 233608, 234167, 234168, 234171, 233496, 233506, 233518, 233517, 233514, 233516, 233505, 233604, 233603, 233598, 234174, 234962, 234173,
        234963
    },
    TIMEWORN_EXPERTISE = {234018, 234022, 234027, 234031, 234035}
}
