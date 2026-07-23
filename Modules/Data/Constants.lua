---@class Data
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

Data.GemColourBitmask = {
    META = 0x1,
    RED = 0x2,
    YELLOW = 0x4,
    ORANGE = 0x6,
    BLUE = 0x8,
    PURPLE = 0xA,
    GREEN = 0xC,
    PRISMATIC = 0xE,
}

Data.Aura = {
    AllowCastingManaRegeneration = {
        [6117] = (ECS.IsWotlk and 0.5 or 0.3), -- Mage Armor rank 1
        [12051] = 1, -- Evocation
        [15271] = (ECS.IsWotlk and 0.83 or 0.5), -- Spirit Tap
        [18371] = 0.5, -- Soul Siphon
        [22782] = (ECS.IsWotlk and 0.5 or 0.3), -- Mage Armor rank 2
        [22783] = (ECS.IsWotlk and 0.5 or 0.3), -- Mage Armor rank 3
        [23684] = 1, -- Aura of the Blue Dragon
        [27125] = (ECS.IsWotlk and 0.5 or 0.3), -- Mage Armor rank 4
        [29166] = 1, -- Innervate
        [32932] = 1, -- Sun Shield
        [38346] = 0.15, -- Meditation
        [43023] = 0.5, -- Mage Armor rank 5
        [43024] = 0.5, -- Mage Armor rank 6
        [49307] = 1, -- Full Mana Regen
        [49694] = 0.17, -- Improved Spirit Tap 1/2
        [59000] = 0.33, -- Improved Spirit Tap 2/2
        [408261] = 0.5, -- Dreamstate
        [412325] = 0.1, -- Enlightenment
        [425124] = 1, -- Arcane Surge
        [437357] = 1, -- Gneuromantic Meditation
        [456195] = 1, -- Innervate
        [468466] = 1, -- Unmaking the Simulacrum
        [1213422] = 1, -- Aura of the Blue Dragon
    },
    CritReductionAll = {
        [21183] = (ECS.IsWotlk and -1 or nil), -- Hearth of the Crusader
        [30482] = 5, -- Molten Armor
        [30708] = (ECS.IsWotlk and -3 or nil), -- totem of wrath
        [31966] = -3, -- Physical Debuffs 2
        [33143] = 1000, -- Blessed Resilience
        [35915] = 5, -- Molten Armor
        [43045] = 5, -- Molten Armor
        [43046] = 5, -- Molten Armor
        [45985] = 5, -- Flaming Touch
        [51584] = -30, -- Icy Torrent
        [53480] = 10000, -- Roar of Sacrifice
        [54498] = -2, -- Hearth of the Crusader
        [54499] = -3, -- Hearth of the Crusader
        [57524] = -50, -- Metanoia
        [61861] = 11, -- Arena 1 Resil
        [62382] = -50, -- Brittle
        [403816] = 6, -- metamorphosis
        [428741] = 5, -- molten armor
        [430432] = 5, -- battle hardened
    },
    CritReductionMelee = {
        [47241] = 6, -- metamorphosis
        [408680] = 6, -- way of earth
    },
    CritReductionSpell = {
        [17794] = (ECS.IsWotlk and -1 or nil), -- Shadow Mastery 1/5
        [17797] = (ECS.IsWotlk and -3 or nil), -- Shadow Mastery 2/5
        [17798] = (ECS.IsWotlk and -2 or nil), -- Shadow Mastery 3/5
        [17799] = (ECS.IsWotlk and -4 or nil), -- Shadow Mastery 4/5
        [17800] = (ECS.IsWotlk and -5 or nil), -- Shadow Mastery 5/5
        [22959] = (ECS.IsWotlk and -5 or nil), -- Improved Scorch
    },
    IsFeralForm = {
        [768] = true, -- Cat Form
        [5487] = true, -- Bear Form
        [9634] = true, -- Dire Bear Form
    },
    IsLightningShield = {
        [324] = true, -- Lightning Shield rank 1
        [325] = true, -- Lightning Shield rank 2
        [905] = true, -- Lightning Shield rank 3
        [945] = true, -- Lightning Shield rank 4
        [8134] = true, -- Lightning Shield rank 5
        [10431] = true, -- Lightning Shield rank 6
        [10432] = true, -- Lightning Shield rank 7
        [25469] = true, -- Lightning Shield rank 8
        [25472] = true, -- Lightning Shield rank 9
        [26363] = true, -- Lightning Shield
        [26364] = true, -- Lightning Shield
        [26365] = true, -- Lightning Shield
        [26366] = true, -- Lightning Shield
        [26367] = true, -- Lightning Shield
        [26369] = true, -- Lightning Shield
        [26370] = true, -- Lightning Shield
        [26371] = true, -- Lightning Shield
        [26372] = true, -- Lightning Shield
        [27635] = true, -- Lightning Shield
        [32642] = true, -- Spore Cloud
        [34828] = true, -- Water Shield
        [35320] = true, -- Electric Skin
        [49278] = true, -- Lightning Shield
        [49279] = true, -- Lightning Shield
        [49280] = true, -- Lightning Shield rank 10
        [49281] = true, -- Lightning Shield rank 11
    },
    MP5 = ECS.IsClassic and {
        [430] = 42, -- Drink
        [431] = 104, -- drink
        [432] = 174, -- drink
        [833] = 30, -- Green Tea
        [1133] = 249, -- drink
        [1135] = 332, -- drink
        [1137] = 489, -- drink
        [2639] = 70, -- food
        [8384] = 5, -- Pure Water
        [10250] =  800, -- drink
        [16609] = 10, -- Warchief's Blessing
        [18140] = 735, -- Blessed Sunfruit Juice
        [18194] = 8, -- Mana Regeneration
        [21172] = 75, -- Grip of Command
        [21174] = 50, -- Aura of Battle
        [22734] = 700, -- drink
        [23698] = 735, -- Alterac Spring Water
        [24363] = 12, -- Mana Regeneration
        [25696] = 735, -- Drink
        [25697] = 735, -- Old Enriched Manna Biscuit
        [25701] = 75, -- Brain Food
        [25703] = 135, -- Brain Food
        [25887] = 210, -- Brain Food
        [25889] = 300, -- Brain Food
        [26261] = 735, -- Drink
        [26402] = 735, -- Drink
        [26473] = 367, -- drink
        [26475] = 551, -- drink
        [27089] = 240*5, -- Drink
        [28145] = 11, -- Power of the Guardian
        [28509] = 16, -- Greater Mana Regeneration
        [28795] = 28, -- Holy Power
        [28804] = 24, -- Epiphany
        [28820] = 15, -- Lightning Shield
        [28824] = 28, -- Totemic Power
        [29007] = 489, -- Drink
        [29039] = 300, -- Fizzy Energy Drink
        [355366] = 10, -- Warchief's Blessing
        [370548] = 10, -- Skeletal Artifact
        [430948] = 8, -- Arcane Recovery
        [446396] = 12, -- Atal'ai Mojo of Life. This has no effect outside of Sunken Temple.
        [446714] = 1104, -- Drink
        [448084] = 12, -- Restless Dreams. The benefits of this flask only apply in areas under the influence of the nightmare.
        [460939] = 10, -- Might of Stormwind
        [460940] = 10, -- Might of Stormwind
        [461632] = 1104, -- Stratholme Holy Water
        [468767] = 851, -- drink
        [473441] = 10, -- Might of Blackrock
        [1213886] = 13, -- Flask of Unyielding Sorrow
        [1220542] = 28, -- Holy Power
        [1220685] = 28, -- Totemic Power
    } or {},
    MP5Tooltip = {
        [5677] = (ECS.IsWotlk and 5/2 or nil), -- Mana Spring rank 1
        [10491] = (ECS.IsWotlk and 5/2 or nil), -- Mana Spring rank 2
        [10493] = (ECS.IsWotlk and 5/2 or nil), -- Mana Spring rank 3
        [10494] = (ECS.IsWotlk and 5/2 or nil), -- Mana Spring rank 4
        [19742] = ((not ECS.IsClassic) and 1 or nil), -- Blessing of Wisdom rank 1
        [19850] = ((not ECS.IsClassic) and 1 or nil), -- Blessing of Wisdom rank 2
        [19852] = ((not ECS.IsClassic) and 1 or nil), -- Blessing of Wisdom rank 3
        [19853] = ((not ECS.IsClassic) and 1 or nil), -- Blessing of Wisdom rank 4
        [19854] = ((not ECS.IsClassic) and 1 or nil), -- Blessing of Wisdom rank 5
        [25290] = ((not ECS.IsClassic) and 1 or nil), -- Blessing of Wisdom rank 6
        [25569] = (ECS.IsWotlk and 5/2 or nil), -- Mana Spring rank 5
        [25894] = ((not ECS.IsClassic) and 1 or nil), -- Greater Blessing of Wisdom rank 1
        [25918] = ((not ECS.IsClassic) and 1 or nil), -- Greater Blessing of Wisdom rank 2
        [27142] = 1, -- Blessing of Wisdom rank 7
        [27143] = 1, -- Greater Blessing of Wisdom rank 3
        [48935] = 1, -- Blessing of Wisdom rank 8
        [48936] = 1, -- Blessing of Wisdom rank 9
        [48937] = 1, -- Greater Blessing of Wisdom rank 4
        [48938] = 1, -- Greater Blessing of Wisdom rank 5
        [56521] = 1, -- Blessing of Wisdom
        [58775] = 5/2, -- Mana Spring rank 6
        [58776] = 5/2, -- Mana Spring rank 7
        [58777] = 5/2, -- Mana Spring rank 8
    },
    PercentageMp5 = {
        [12051] = ((not ECS.IsClassic) and 0.15/2*5 or nil), -- Evocation
        [18792] = (ECS.IsClassic and 0.02/4 or 0.03/4)*5, -- Fel Energy
        [24355] = 0.02*5, -- Drink
        [24707] = 0.03*5, -- Food
        [25990] = 0.05*5, -- Graccu's Mince Meat Fruitcake
        [26263] = (ECS.IsClassic and 0.04 or 0.03)*5, -- Dim Sum
        [29055] = 0.04*5, -- Refreshing Red Apple
        [30024] = 0.2*5, -- Drink
        [30254] = 0.05*5, -- Evocation
        [30874] = 0.05*5, -- Gift of the Water Spirit
        [34074] = 0.04/3*5, -- Aspect of the Viper
        [35701] = 0.02/4*5, -- Touch of Shadow
        [38549] = 0.03*5, -- Empowerment
        [38730] = 0.09/2*5, -- Refreshing Mist
        [52067] = 0.02/2*5, -- Aura of Regeneration
        [53089] = 0.02*5, -- Worgen's Blood
        [53517] = 0.1/3*5, -- Roar of Recovery
        [54428] = 0.05/3*5, -- Divine Plea
        [57056] = 0.02/5*5, -- Aura of Regeneration
        [58026] = 0.1/2*5, -- Blessing of the Crusade
        [61011] = 0.15/2*5, -- Improved Brilliance Aura
        [74501] = 0.05*5, -- Brilliant Tactics
        [74719] = 0.05*5, -- Brilliant Tactics
        [74865] = 0.05*5, -- Boon of the Loa
        [408510] = 0.02, -- Water Shield
        [413083] = 0.15, -- Resilience of Nature
        [415058] = 0.05/3*5, -- Guarded by the Light
        [415423] = 0.1/3*5, -- Aspect of the Viper
        [425294] = 0.06*5, -- Dispersion
        [437324] = 0.02*5, -- Deep Slumber
        [449879] = 0.06*5, -- Dream Fog
        [1226808] = 0.05*5, -- Food
    },
    PeriodicallyGiveMana = {
        [15604] = 150, -- Second Wind
        [15822] = 20, -- Dreamless Sleep
        [16191] = 170/3*5, -- Mana Tide
        [16599] = 50, -- Blessing of Shahram
        [17252] = 22, -- Mark of the Dragon Lord
        [17328] = 15, -- Aura of Penitence
        [17355] = 230/3*5, -- Mana Tide
        [17360] = 290/3*5, -- Mana Tide
        [17447] = 375, -- Circle of Flame
        [18194] = 8, -- Mana Regeneration
        [19634] = 50/3*5, -- Mana Rejuvenation
        [21955] = 60, -- Razorlash Root
        [23108] = 500, -- Blessing of Nordrassil
        [23513] = 2500, -- Essence of the Red
        [24268] = 60, -- Mar'li's Brain Boost
        [24360] = 875, -- Greater Dreamless Sleep
        [24884] = 200, -- Earthen Sigil
        [25694] = 3, -- Well Fed
        [25941] = 6, -- Well Fed
        [26551] = 600, -- Jade Owl
        [26600] = 300, -- Emerald Owl
        [27996] = 50, -- Spellsurge
        [28504] = 1500, -- Major Dreamless Sleep
        [29040] = 6, -- Fizzy Energy Drink
        [29882] = 875, -- Loose Mana
        [31045] = 375, -- Talasite Owl
        [35478] = 200, -- Drums of Restoration
        [38929] = 400/3*5, -- Fel Mana
        [45027] = 750, -- Revitalize
        [45052] = 750, -- Evocation
        [45860] = 1125, -- Breath: Revitalize
        [46785] = 375, -- Seaspray Albatross
        [53753] = 4500, -- Nightmare Slumber
        [54833] = 450, -- Glyph of Innervate
        [55740] = 2500, -- Essence of the Red
        [71881] = 300, -- Invigoration
        [71941] = 200/3*5, -- Twisted Nightmare
        [351358] = 200, -- Greater Drums of Restoration
        [434851] = 380, -- Minor Evocation
        [435168] = 12, -- Guard of the Innovator
        [446088] = 24, -- Leyline Attunement
        [462858] = 750, -- Circle of Flame
    },
    PeriodicallyGiveManaTooltip = {
        [5677] = ((not ECS.IsWotlk) and 5/2 or nil), -- Mana Spring rank 1
        [10491] = ((not ECS.IsWotlk) and 5/2 or nil), -- Mana Spring rank 2
        [10493] = ((not ECS.IsWotlk) and 5/2 or nil), -- Mana Spring rank 3
        [10494] = ((not ECS.IsWotlk) and 5/2 or nil), -- Mana Spring rank 4
        [19742] = (ECS.IsClassic and 1 or nil), -- Blessing of Wisdom rank 1
        [19850] = (ECS.IsClassic and 1 or nil), -- Blessing of Wisdom rank 2
        [19852] = (ECS.IsClassic and 1 or nil), -- Blessing of Wisdom rank 3
        [19853] = (ECS.IsClassic and 1 or nil), -- Blessing of Wisdom rank 4
        [19854] = (ECS.IsClassic and 1 or nil), -- Blessing of Wisdom rank 5
        [24853] = 5/2, -- Mana Spring
        [25290] = (ECS.IsClassic and 1 or nil), -- Blessing of Wisdom rank 6
        [25569] = ((not ECS.IsWotlk) and 5/2 or nil), -- Mana Spring rank 5
        [25894] = (ECS.IsClassic and 1 or nil), -- Greater Blessing of Wisdom rank 1
        [25918] = (ECS.IsClassic and 1 or nil), -- Greater Blessing of Wisdom rank 2
    },
    SpellCrit = {
        [24907] = ((not ECS.IsClassic) and 5 or nil), -- Moonkin Aura
        [29177] = 6, -- Elemental Devastation Rank 2
        [29178] = 9, -- Elemental Devastation Rank 3
        [30165] = 3, -- Elemental Devastation Rank 1
        [51466] = 3, -- Elemental Oath Rank 1
        [51470] = 5, -- Elemental Oath Rank 2
    },
    SpellHaste = {
        [1714] = -50, -- Curse of Tongues Rank 1
        [3603] = -35, -- Distracting Pain
        [5760] = -40, -- Mind-numbing Poison Rank 1
        [7102] = -25, -- Contagion of Rot
        [7103] = -25, -- Contagion of Rot
        [7127] = -20, -- Wavering Will
        [8140] = -50, -- Befuddlement
        [8215] = 100, -- Rapid Cast
        [8272] = -20, -- Mind Tremor
        [8692] = -50, -- Mind-numbing Poison II Rank 2
        [10348] = 100, -- Tune Up
        [10651] = -20, -- Curse of the Eye
        [10653] = -20, -- Curse of the Eye
        [11398] = -60, -- Mind-numbing Poison III Rank 3
        [11719] = -60, -- Curse of Tongues Rank 2
        [12255] = -15, -- Curse of Tuten'kash
        [12889] = -50, -- Curse of Tongues
        [13338] = -50, -- Curse of Tongues
        [14538] = -35, -- Aural Shock
        [15470] = -50, -- Curse of Tongues
        [17331] = -10, -- Fang of the Crystal Spider
        [17633] = 66, -- Arcane Focus
        [18173] = 100000, -- Burning Adrenaline
        [18803] = 100000, -- Focus
        [19365] = -50, -- Ancient Dread
        [19779] = 26, -- Inspire
        [22247] = -80, -- Suppression Aura
        [22642] = -50, -- Brood Power: Bronze
        [22710] = 100, -- Enlarge
        [22909] = -50, -- Eye of Immol'thar
        [23153] = -50, -- Brood Affliction: Blue
        [23620] = 100000, -- Burning Adrenaline
        [23723] = 33, -- Mind Quickening
        [23733] = 33, -- Blinding Light
        [24415] = -50, -- Slow
        [25195] = -75, -- Curse of Tongues
        [25516] = 11, -- Aura of Command
        [25773] = 300, -- Will of Weavil
        [25810] = -50, -- Mind-numbing Poison
        [367987] = 101, -- Burning Adrenaline
        [368615] = 30, -- Pulse Lightning
        [370066] = 51, -- Visions of Madness
        [370767] = 11, -- Essence of C'Thun
        [370832] = 15, -- Gift of the Spider
        [371206] = 100, -- Servant of Chaos
        [402794] = -60, -- Curse of Tongues
        [425121] = 20, -- Icy Veins
        [427714] = 30, -- Backdraft
        [429125] = 20, -- Icy Veins
        [431060] = 100001, -- Flight Insurance
        [437362] = 20, -- Hyperconductive Shock
        [444046] = -50, -- Curse of Tongues
        [446528] = 10, -- Echoes of Madness
        [467141] = 33, -- Mind Quickening
        [467522] = 33, -- Blinding Light
        [469261] = 101, -- Burning Adrenaline
        [474236] = 100000, -- Blessing of Ji'zhi
        [1221578] = 25, -- Mark of the Master
        [1226451] = 20, -- Emergency
        [1227200] = 20, -- Wickedness
        [1236220] = -50, -- Slow
    },
}
Data.Enchant = {
    BlockValue = {
        [2583] = 15, -- Presence of Might
        [2653] = 18, -- Enchant Shield - Tough Shield
        [2655] = 15, -- Enchant Shield - Shield Block
        [3849] = 81, -- Titanium Plating
        [7633] = 15, -- Presence of Valor
    },
    Ids = {
        BIZNICK_SCOPE = 2523, -- 3% Hit from Biznicks 247x128 Accurascope
    },
    MP5 = {
        [2367] = 2,
        [2369] = 3,
        [2370] = 3,
        [2371] = 4,
        [2381] = 10, -- Enchant Chest - Greater Mana Restoration
        [2392] = 12,
        [2565] = 4, -- Enchant Bracer - Mana Regeneration
        [2590] = 4, -- Prophetic Aura
        [2624] = 4, -- Minor Mana Oil
        [2625] = 8, -- Lesser Mana Oil
        [2629] = 12, -- Brilliant Mana Oil
        [2656] = 4, -- Enchant Boots - Vitality
        [2677] = 14, -- Superior Mana Oil
        [2679] = 6, -- Enchant Bracer - Restore Mana Prime
        [2715] = 4, -- Resilience of the Scourge
        [2854] = 3,
        [2865] = 2,
        [2866] = 2,
        [2867] = 2,
        [2868] = 2,
        [2869] = 2,
        [2881] = 1,
        [2882] = 1,
        [2883] = 1,
        [2980] = 4, -- Greater Inscription of Faith
        [2992] = 5, -- Inscription of the Oracle
        [2993] = 6, -- Greater Inscription of the Oracle
        [3001] = 7, -- Glyph of Renewal
        [3150] = 6, -- Enchant Chest – Restore Mana Prime
        [3244] = 7, -- Enchant Boots - Greater Vitality
        [3298] = 19, -- Exceptional Mana Oil
        [3306] = 2,
        [3307] = 2,
        [3308] = 2,
        [3807] = 5, -- Inscription of the Crag
        [3809] = 8, -- Greater Inscription of the Crag
        [3819] = 10, -- Arcanum of Blissful Mending
        [3836] = 8, -- Master's Inscription of the Crag
        [7099] = 12, -- Blackfathom Mana Oil. This effect only applies within Blackfathom Deeps.
    },
}
Data.Gem = {
    Colours = {
        [22459] = 14, -- Void Sphere
        [22460] = 14, -- Prismatic Sphere
        [23094] = 2, -- Teardrop Blood Garnet
        [23095] = 2, -- Bold Blood Garnet
        [23096] = 2, -- Runed Blood Garnet
        [23097] = 2, -- Delicate Blood Garnet
        [23098] = 6, -- Inscribed Flame Spessarite
        [23099] = 6, -- Luminous Flame Spessarite
        [23100] = 6, -- Glinting Flame Spessarite
        [23101] = 6, -- Potent Flame Spessarite
        [23103] = 12, -- Radiant Deep Peridot
        [23104] = 12, -- Jagged Deep Peridot
        [23105] = 12, -- Enduring Deep Peridot
        [23106] = 12, -- Dazzling Deep Peridot
        [23108] = 10, -- Glowing Shadow Draenite
        [23109] = 10, -- Royal Shadow Draenite
        [23110] = 10, -- Shifting Shadow Draenite
        [23111] = 10, -- Sovereign Shadow Draenite
        [23113] = 4, -- Brilliant Golden Draenite
        [23114] = 4, -- Gleaming Golden Draenite
        [23115] = 4, -- Thick Golden Draenite
        [23116] = 4, -- Rigid Golden Draenite
        [23118] = 8, -- Solid Azure Moonstone
        [23119] = 8, -- Sparkling Azure Moonstone
        [23120] = 8, -- Stormy Azure Moonstone
        [23121] = 8, -- Lustrous Azure Moonstone
        [23233] = 2, -- Red Bryanite of Strength stuff
        [23234] = 8, -- Blue Bryanite of Agility
        [23235] = 4, -- Yellow Bryanite of Stamina
        [23364] = 1, -- zzDEPRECATEDHeart of the Sky
        [23366] = 1, -- zzDEPRECATEDPerfect Diamond
        [24027] = 2, -- Bold Living Ruby
        [24028] = 2, -- Delicate Living Ruby
        [24029] = 2, -- Teardrop Living Ruby
        [24030] = 2, -- Runed Living Ruby
        [24031] = 2, -- Bright Living Ruby
        [24032] = 2, -- Subtle Living Ruby
        [24033] = 8, -- Solid Star of Elune
        [24035] = 8, -- Sparkling Star of Elune
        [24036] = 2, -- Flashing Living Ruby
        [24037] = 8, -- Lustrous Star of Elune
        [24039] = 8, -- Stormy Star of Elune
        [24047] = 4, -- Brilliant Dawnstone
        [24048] = 4, -- Smooth Dawnstone
        [24050] = 4, -- Gleaming Dawnstone
        [24051] = 4, -- Rigid Dawnstone
        [24052] = 4, -- Thick Dawnstone
        [24053] = 4, -- Mystic Dawnstone
        [24054] = 10, -- Sovereign Nightseye
        [24055] = 10, -- Shifting Nightseye
        [24056] = 10, -- Glowing Nightseye
        [24057] = 10, -- Royal Nightseye
        [24058] = 6, -- Inscribed Noble Topaz
        [24059] = 6, -- Potent Noble Topaz
        [24060] = 6, -- Luminous Noble Topaz
        [24061] = 6, -- Glinting Noble Topaz
        [24062] = 12, -- Enduring Talasite
        [24065] = 12, -- Dazzling Talasite
        [24066] = 12, -- Radiant Talasite
        [24067] = 12, -- Jagged Talasite
        [25890] = 1, -- Destructive Skyfire Diamond
        [25893] = 1, -- Mystical Skyfire Diamond
        [25894] = 1, -- Swift Skyfire Diamond
        [25895] = 1, -- Enigmatic Skyfire Diamond
        [25896] = 1, -- Powerful Earthstorm Diamond
        [25897] = 1, -- Bracing Earthstorm Diamond
        [25898] = 1, -- Tenacious Earthstorm Diamond
        [25899] = 1, -- Brutal Earthstorm Diamond
        [25901] = 1, -- Insightful Earthstorm Diamond
        [27679] = 4, -- Sublime Mystic Dawnstone
        [27774] = 2, -- zzOLDMighty Blood Garnet
        [27777] = 2, -- Stark Blood Garnet
        [27785] = 12, -- Notched Deep Peridot
        [27786] = 12, -- Barbed Deep Peridot
        [27809] = 12, -- Barbed Deep Peridot
        [27811] = 2, -- zzOLDMighty Blood Garnet
        [27812] = 2, -- Stark Blood Garnet
        [27820] = 12, -- Notched Deep Peridot
        [27863] = 8, -- Brian's Bryanite of Extended Cost
        [27864] = 8, -- Brian's Bryanite of Extended Cost Copying
        [28117] = 2, -- zzOLDBold Ornate Ruby
        [28118] = 2, -- Runed Ornate Ruby
        [28119] = 4, -- Smooth Ornate Dawnstone
        [28120] = 4, -- Gleaming Ornate Dawnstone
        [28122] = 6, -- zzOLDEnscribed Ornate Topaz
        [28123] = 6, -- Potent Ornate Topaz
        [28290] = 4, -- Smooth Golden Draenite
        [28360] = 2, -- Mighty Blood Garnet
        [28361] = 2, -- Mighty Blood Garnet
        [28362] = 2, -- Bold Ornate Ruby
        [28363] = 6, -- Inscribed Ornate Topaz
        [28388] = 2, -- TCHILTON TEST RUBY
        [28389] = 4, -- TCHILTON TEST DAWNSTONE
        [28458] = 2, -- Bold Tourmaline
        [28459] = 2, -- Delicate Tourmaline
        [28460] = 2, -- Teardrop Tourmaline
        [28461] = 2, -- Runed Tourmaline
        [28462] = 2, -- Bright Tourmaline
        [28463] = 8, -- Solid Zircon
        [28464] = 8, -- Sparkling Zircon
        [28465] = 8, -- Lustrous Zircon
        [28466] = 4, -- Brilliant Amber
        [28467] = 4, -- Smooth Amber
        [28468] = 4, -- Rigid Amber
        [28469] = 4, -- Gleaming Amber
        [28470] = 4, -- Thick Amber
        [28556] = 1, -- Swift Windfire Diamond
        [28557] = 1, -- Swift Starfire Diamond
        [32409] = 1, -- Relentless Earthstorm Diamond
        [28595] = 2, -- Bright Blood Garnet
        [30546] = 10, -- Sovereign Tanzanite
        [30547] = 6, -- Luminous Fire Opal
        [30548] = 12, -- Polished Chrysoprase
        [30549] = 10, -- Shifting Tanzanite
        [30552] = 10, -- Blessed Tanzanite
        [30550] = 12, -- Sundered Chrysoprase
        [30551] = 6, -- Infused Fire Opal
        [30553] = 6, -- Pristine Fire Opal
        [30554] = 6, -- Stalwart Fire Opal
        [30555] = 10, -- Glowing Tanzanite
        [30556] = 6, -- Glinting Fire Opal
        [30558] = 6, -- Glimmering Fire Opal
        [30559] = 6, -- Etched Fire Opal
        [30560] = 12, -- Rune Covered Chrysoprase
        [30563] = 10, -- Regal Tanzanite
        [30564] = 6, -- Shining Fire Opal
        [30565] = 6, -- Assassin's Fire Opal
        [30566] = 10, -- Defender's Tanzanite
        [30571] = 2, -- Don Rodrigo's Heart
        [30572] = 10, -- Imperial Tanzanite
        [30573] = 6, -- Mysterious Fire Opal
        [30574] = 10, -- Brutal Tanzanite
        [30575] = 6, -- Nimble Fire Opal
        [30581] = 6, -- Durable Fire Opal
        [30582] = 6, -- Deadly Fire Opal
        [30583] = 12, -- Timeless Chrysoprase
        [30584] = 6, -- Enscribed Fire Opal
        [30585] = 6, -- Glistening Fire Opal
        [30586] = 12, -- Seer's Chrysoprase
        [30587] = 6, -- Champion's Fire Opal
        [30588] = 6, -- Potent Fire Opal
        [30589] = 12, -- Dazzling Chrysoprase
        [30590] = 12, -- Enduring Chrysoprase
        [30591] = 6, -- Empowered Fire Opal
        [30592] = 12, -- Steady Chrysoprase
        [30593] = 6, -- Iridescent Fire Opal
        [30594] = 12, -- Effulgent Chrysoprase
        [30598] = 2, -- Don Amancio's Heart
        [30600] = 10, -- Fluorescent Tanzanite
        [30601] = 6, -- Beaming Fire Opal
        [30602] = 12, -- Jagged Chrysoprase
        [30603] = 10, -- Royal Tanzanite
        [30604] = 6, -- Resplendent Fire Opal
        [30605] = 12, -- Vivid Chrysoprase
        [30606] = 12, -- Lambent Chrysoprase
        [30607] = 6, -- Splendid Fire Opal
        [30608] = 12, -- Radiant Chrysoprase
        [31116] = 10, -- Infused Amethyst
        [31117] = 10, -- Soothing Amethyst
        [31118] = 10, -- Pulsing Amethyst
        [31860] = 4, -- Great Golden Draenite
        [31861] = 4, -- Great Dawnstone
        [31862] = 10, -- Balanced Shadow Draenite
        [31863] = 10, -- Balanced Nightseye
        [31864] = 10, -- Infused Shadow Draenite
        [31865] = 10, -- Infused Nightseye
        [31866] = 6, -- Veiled Flame Spessarite
        [31867] = 6, -- Veiled Noble Topaz
        [31868] = 6, -- Wicked Noble Topaz
        [31869] = 6, -- Wicked Flame Spessarite
        [32193] = 2, -- Bold Crimson Spinel
        [32194] = 2, -- Delicate Crimson Spinel
        [32195] = 2, -- Teardrop Crimson Spinel
        [32196] = 2, -- Runed Crimson Spinel
        [32197] = 2, -- Bright Crimson Spinel
        [32198] = 2, -- Subtle Crimson Spinel
        [32199] = 2, -- Flashing Crimson Spinel
        [32200] = 8, -- Solid Empyrean Sapphire
        [32201] = 8, -- Sparkling Empyrean Sapphire
        [32202] = 8, -- Lustrous Empyrean Sapphire
        [32203] = 8, -- Stormy Empyrean Sapphire
        [32204] = 4, -- Brilliant Lionseye
        [32205] = 4, -- Smooth Lionseye
        [32206] = 4, -- Rigid Lionseye
        [32207] = 4, -- Gleaming Lionseye
        [32208] = 4, -- Thick Lionseye
        [32209] = 4, -- Mystic Lionseye
        [32210] = 4, -- Great Lionseye
        [32211] = 10, -- Sovereign Shadowsong Amethyst
        [32212] = 10, -- Shifting Shadowsong Amethyst
        [32213] = 10, -- Balanced Shadowsong Amethyst
        [32214] = 10, -- Infused Shadowsong Amethyst
        [32215] = 10, -- Glowing Shadowsong Amethyst
        [32216] = 10, -- Royal Shadowsong Amethyst
        [32217] = 6, -- Inscribed Pyrestone
        [32218] = 6, -- Potent Pyrestone
        [32219] = 6, -- Luminous Pyrestone
        [32220] = 6, -- Glinting Pyrestone
        [32221] = 6, -- Veiled Pyrestone
        [32222] = 6, -- Wicked Pyrestone
        [32223] = 12, -- Enduring Seaspray Emerald
        [32224] = 12, -- Radiant Seaspray Emerald
        [32225] = 12, -- Dazzling Seaspray Emerald
        [32226] = 12, -- Jagged Seaspray Emerald
        [32410] = 1, -- Thundering Skyfire Diamond
        [32634] = 10, -- Unstable Amethyst
        [32635] = 12, -- Unstable Peridot
        [32636] = 10, -- Unstable Sapphire
        [32637] = 6, -- Unstable Citrine
        [32638] = 6, -- Unstable Topaz
        [32639] = 12, -- Unstable Talasite
        [32640] = 1, -- Potent Unstable Diamond
        [32641] = 1, -- Imbued Unstable Diamond
        [32735] = 12, -- Radiant Spencerite
        [32833] = 10, -- Purified Jaggal Pearl
        [32836] = 10, -- Purified Shadow Pearl
        [35707] = 10, -- Regal Nightseye
        [33060] = 14, -- Soulbound Test Gem
        [33131] = 2, -- Crimson Sun
        [33132] = 2, -- Delicate Fire Ruby
        [33133] = 2, -- Don Julio's Heart
        [33134] = 2, -- Kailee's Rose
        [33135] = 8, -- Falling Star
        [33137] = 8, -- Sparkling Falling Star
        [33138] = 4, -- Mystic Bladestone
        [33139] = 4, -- Brilliant Bladestone
        [33140] = 4, -- Blood of Amber
        [33141] = 4, -- Great Bladestone
        [33142] = 4, -- Rigid Bladestone
        [33143] = 4, -- Stone of Blades
        [33144] = 4, -- Facet of Eternity
        [33633] = 4, -- Forceful Earthstorm Diamond
        [33782] = 12, -- Steady Talasite
        [34142] = 14, -- Infinite Sphere
        [34143] = 14, -- Chromatic Sphere
        [34220] = 1, -- Chaotic Skyfire Diamond
        [34256] = 8, -- Charmed Amani Jewel
        [34627] = 4, -- Heavy Tonk Armor
        [34831] = 8, -- Eye of the Sea
        [34967] = 14, -- Juno's Test Gem
        [35315] = 4, -- Quick Dawnstone
        [35316] = 6, -- Reckless Noble Topaz
        [35318] = 12, -- Forceful Talasite
        [35487] = 2, -- Bright Crimson Spinel
        [35488] = 2, -- Runed Crimson Spinel
        [35489] = 2, -- Teardrop Crimson Spinel
        [35501] = 1, -- Eternal Earthstorm Diamond
        [35503] = 1, -- Ember Skyfire Diamond
        [35715] = 6, -- Deprecated Glyph of Venomous Mana [PH]
        [35758] = 12, -- Steady Seaspray Emerald
        [35759] = 12, -- Forceful Seaspray Emerald
        [35760] = 6, -- Reckless Pyrestone
        [35761] = 4, -- Quick Lionseye
        [36766] = 2, -- Bright Dragon's Eye
        [36767] = 8, -- Solid Dragon's Eye
        [37301] = 2, -- Deprecated Test Glyph
        [37430] = 8, -- Solid Sky Sapphire (Unused)
        [37503] = 10, -- Purified Shadowsong Amethyst
        [38498] = 10, -- QA Test Blank Purple Gem
        [37550] = 2, -- DEPRECATED Test Glyph 2
        [37551] = 2, -- DEPRECATED Test Glyph 3 [PH]
        [38292] = 2, -- Test Living Ruby
        [38499] = 10, -- QA Test Blank Blue Gem
        [38500] = 2, -- QA Test Blank Red Gem
        [38501] = 2, -- QA Test Blank Yellow Gem
        [38502] = 6, -- QA Test Blank Orange Gem
        [38503] = 12, -- QA Test Blank Green Gem
        [38538] = 1, -- Riding Crop
        [38545] = 2, -- Bold Ornate Ruby
        [38546] = 4, -- Gleaming Ornate Dawnstone
        [38547] = 6, -- Inscribed Ornate Topaz
        [38548] = 6, -- Potent Ornate Topaz
        [38549] = 2, -- Runed Ornate Ruby
        [38550] = 4, -- Smooth Ornate Dawnstone
        [38725] = 2, -- DEPRECATED item
        [39302] = 4, -- Glyph of the Penguin
        [39900] = 2, -- Bold Bloodstone
        [39905] = 2, -- Delicate Bloodstone
        [39906] = 2, -- Bright Bloodstone
        [39907] = 2, -- Subtle Bloodstone
        [39908] = 2, -- Flashing Bloodstone
        [39909] = 2, -- Fractured Bloodstone
        [39910] = 2, -- Precise Bloodstone
        [39911] = 2, -- Runed Bloodstone
        [39912] = 4, -- Brilliant Sun Crystal
        [39914] = 4, -- Smooth Sun Crystal
        [39915] = 4, -- Rigid Sun Crystal
        [39916] = 4, -- Thick Sun Crystal
        [39917] = 4, -- Mystic Sun Crystal
        [39918] = 4, -- Quick Sun Crystal
        [39919] = 8, -- Solid Chalcedony
        [39920] = 8, -- Sparkling Chalcedony
        [39927] = 8, -- Lustrous Chalcedony
        [39932] = 8, -- Stormy Chalcedony
        [39933] = 10, -- Puissant Shadow Crystal
        [39934] = 10, -- Sovereign Shadow Crystal
        [39935] = 10, -- Shifting Shadow Crystal
        [39936] = 10, -- Glowing Shadow Crystal
        [39937] = 10, -- Balanced Shadow Crystal
        [39938] = 10, -- Regal Shadow Crystal
        [39939] = 10, -- Defender's Shadow Crystal
        [39940] = 10, -- Guardian's Shadow Crystal
        [39941] = 10, -- Purified Shadow Crystal
        [39942] = 10, -- Tenuous Shadow Crystal
        [39943] = 10, -- Royal Shadow Crystal
        [39944] = 10, -- Infused Shadow Crystal
        [39945] = 10, -- Mysterious Shadow Crystal
        [39946] = 6, -- Luminous Huge Citrine
        [39947] = 6, -- Inscribed Huge Citrine
        [39948] = 6, -- Etched Huge Citrine
        [39949] = 6, -- Champion's Huge Citrine
        [39950] = 6, -- Resplendent Huge Citrine
        [39951] = 6, -- Fierce Huge Citrine
        [39952] = 6, -- Deadly Huge Citrine
        [39953] = 6, -- Glinting Huge Citrine
        [39954] = 6, -- Lucent Huge Citrine
        [39955] = 6, -- Deft Huge Citrine
        [39956] = 6, -- Potent Huge Citrine
        [39957] = 6, -- Veiled Huge Citrine
        [39958] = 6, -- Durable Huge Citrine
        [39959] = 6, -- Reckless Huge Citrine
        [39960] = 6, -- Wicked Huge Citrine
        [39961] = 6, -- Pristine Huge Citrine
        [39962] = 6, -- Empowered Huge Citrine
        [39963] = 6, -- Stark Huge Citrine
        [39964] = 6, -- Stalwart Huge Citrine
        [39965] = 6, -- Glimmering Huge Citrine
        [39966] = 6, -- Accurate Huge Citrine
        [39967] = 6, -- Resolute Huge Citrine
        [39968] = 12, -- Timeless Dark Jade
        [39974] = 12, -- Jagged Dark Jade
        [39975] = 12, -- Vivid Dark Jade
        [39976] = 12, -- Enduring Dark Jade
        [39977] = 12, -- Steady Dark Jade
        [39978] = 12, -- Forceful Dark Jade
        [39979] = 12, -- Seer's Dark Jade
        [39980] = 12, -- Misty Dark Jade
        [39981] = 12, -- Shining Dark Jade
        [39982] = 12, -- Turbid Dark Jade
        [39983] = 12, -- Intricate Dark Jade
        [39984] = 12, -- Dazzling Dark Jade
        [39985] = 12, -- Sundered Dark Jade
        [39986] = 12, -- Lambent Dark Jade
        [39988] = 12, -- Opaque Dark Jade
        [39989] = 12, -- Energized Dark Jade
        [39990] = 12, -- Radiant Dark Jade
        [39991] = 12, -- Tense Dark Jade
        [39992] = 12, -- Shattered Dark Jade
        [39996] = 2, -- Bold Scarlet Ruby
        [39997] = 2, -- Delicate Scarlet Ruby
        [39998] = 2, -- Runed Scarlet Ruby
        [39999] = 2, -- Bright Scarlet Ruby
        [40000] = 2, -- Subtle Scarlet Ruby
        [40001] = 2, -- Flashing Scarlet Ruby
        [40002] = 2, -- Fractured Scarlet Ruby
        [40003] = 2, -- Precise Scarlet Ruby
        [40008] = 8, -- Solid Sky Sapphire
        [40009] = 8, -- Sparkling Sky Sapphire
        [40010] = 8, -- Lustrous Sky Sapphire
        [40011] = 8, -- Stormy Sky Sapphire
        [40012] = 4, -- Brilliant Autumn's Glow
        [40013] = 4, -- Smooth Autumn's Glow
        [40014] = 4, -- Rigid Autumn's Glow
        [40015] = 4, -- Thick Autumn's Glow
        [40016] = 4, -- Mystic Autumn's Glow
        [40017] = 4, -- Quick Autumn's Glow
        [40022] = 10, -- Sovereign Twilight Opal
        [40023] = 10, -- Shifting Twilight Opal
        [40024] = 10, -- Tenuous Twilight Opal
        [40025] = 10, -- Glowing Twilight Opal
        [40026] = 10, -- Purified Twilight Opal
        [40027] = 10, -- Royal Twilight Opal
        [40028] = 10, -- Mysterious Twilight Opal
        [40029] = 10, -- Balanced Twilight Opal
        [40030] = 10, -- Infused Twilight Opal
        [40031] = 10, -- Regal Twilight Opal
        [40032] = 10, -- Defender's Twilight Opal
        [40033] = 10, -- Puissant Twilight Opal
        [40034] = 10, -- Guardian's Twilight Opal
        [40037] = 6, -- Inscribed Monarch Topaz
        [40038] = 6, -- Etched Monarch Topaz
        [40039] = 6, -- Champion's Monarch Topaz
        [40040] = 6, -- Resplendent Monarch Topaz
        [40041] = 6, -- Fierce Monarch Topaz
        [40043] = 6, -- Deadly Monarch Topaz
        [40044] = 6, -- Glinting Monarch Topaz
        [40045] = 6, -- Lucent Monarch Topaz
        [40046] = 6, -- Deft Monarch Topaz
        [40047] = 6, -- Luminous Monarch Topaz
        [40048] = 6, -- Potent Monarch Topaz
        [40049] = 6, -- Veiled Monarch Topaz
        [40050] = 6, -- Durable Monarch Topaz
        [40051] = 6, -- Reckless Monarch Topaz
        [40052] = 6, -- Wicked Monarch Topaz
        [40053] = 6, -- Pristine Monarch Topaz
        [40054] = 6, -- Empowered Monarch Topaz
        [40055] = 6, -- Stark Monarch Topaz
        [40056] = 6, -- Stalwart Monarch Topaz
        [40057] = 6, -- Glimmering Monarch Topaz
        [40058] = 6, -- Accurate Monarch Topaz
        [40059] = 6, -- Resolute Monarch Topaz
        [40085] = 12, -- Timeless Forest Emerald
        [40086] = 12, -- Jagged Forest Emerald
        [40088] = 12, -- Vivid Forest Emerald
        [40089] = 12, -- Enduring Forest Emerald
        [40090] = 12, -- Steady Forest Emerald
        [40091] = 12, -- Forceful Forest Emerald
        [40092] = 12, -- Seer's Forest Emerald
        [40094] = 12, -- Dazzling Forest Emerald
        [40095] = 12, -- Misty Forest Emerald
        [40096] = 12, -- Sundered Forest Emerald
        [40098] = 12, -- Radiant Forest Emerald
        [40099] = 12, -- Shining Forest Emerald
        [40100] = 12, -- Lambent Forest Emerald
        [40101] = 12, -- Tense Forest Emerald
        [40102] = 12, -- Turbid Forest Emerald
        [40103] = 12, -- Opaque Forest Emerald
        [40104] = 12, -- Intricate Forest Emerald
        [40105] = 12, -- Energized Forest Emerald
        [40106] = 12, -- Shattered Forest Emerald
        [40111] = 2, -- Bold Cardinal Ruby
        [40112] = 2, -- Delicate Cardinal Ruby
        [40113] = 2, -- Runed Cardinal Ruby
        [40114] = 2, -- Bright Cardinal Ruby
        [40115] = 2, -- Subtle Cardinal Ruby
        [40116] = 2, -- Flashing Cardinal Ruby
        [40117] = 2, -- Fractured Cardinal Ruby
        [40118] = 2, -- Precise Cardinal Ruby
        [40119] = 8, -- Solid Majestic Zircon
        [40120] = 8, -- Sparkling Majestic Zircon
        [40121] = 8, -- Lustrous Majestic Zircon
        [40122] = 8, -- Stormy Majestic Zircon
        [40123] = 4, -- Brilliant King's Amber
        [40124] = 4, -- Smooth King's Amber
        [40125] = 4, -- Rigid King's Amber
        [40126] = 4, -- Thick King's Amber
        [40127] = 4, -- Mystic King's Amber
        [40128] = 4, -- Quick King's Amber
        [40129] = 10, -- Sovereign Dreadstone
        [40130] = 10, -- Shifting Dreadstone
        [40131] = 10, -- Tenuous Dreadstone
        [40132] = 10, -- Glowing Dreadstone
        [40133] = 10, -- Purified Dreadstone
        [40134] = 10, -- Royal Dreadstone
        [40135] = 10, -- Mysterious Dreadstone
        [40136] = 10, -- Balanced Dreadstone
        [40137] = 10, -- Infused Dreadstone
        [40138] = 10, -- Regal Dreadstone
        [40139] = 10, -- Defender's Dreadstone
        [40140] = 10, -- Puissant Dreadstone
        [40141] = 10, -- Guardian's Dreadstone
        [40142] = 6, -- Inscribed Ametrine
        [40143] = 6, -- Etched Ametrine
        [40144] = 6, -- Champion's Ametrine
        [40145] = 6, -- Resplendent Ametrine
        [40146] = 6, -- Fierce Ametrine
        [40147] = 6, -- Deadly Ametrine
        [40148] = 6, -- Glinting Ametrine
        [40149] = 6, -- Lucent Ametrine
        [40150] = 6, -- Deft Ametrine
        [40151] = 6, -- Luminous Ametrine
        [40152] = 6, -- Potent Ametrine
        [40153] = 6, -- Veiled Ametrine
        [40154] = 6, -- Durable Ametrine
        [40155] = 6, -- Reckless Ametrine
        [40156] = 6, -- Wicked Ametrine
        [40157] = 6, -- Pristine Ametrine
        [40158] = 6, -- Empowered Ametrine
        [40159] = 6, -- Stark Ametrine
        [40160] = 6, -- Stalwart Ametrine
        [40161] = 6, -- Glimmering Ametrine
        [40162] = 6, -- Accurate Ametrine
        [40163] = 6, -- Resolute Ametrine
        [40164] = 12, -- Timeless Eye of Zul
        [40165] = 12, -- Jagged Eye of Zul
        [40166] = 12, -- Vivid Eye of Zul
        [40167] = 12, -- Enduring Eye of Zul
        [40168] = 12, -- Steady Eye of Zul
        [40169] = 12, -- Forceful Eye of Zul
        [40170] = 12, -- Seer's Eye of Zul
        [40171] = 12, -- Misty Eye of Zul
        [40172] = 12, -- Shining Eye of Zul
        [40173] = 12, -- Turbid Eye of Zul
        [40174] = 12, -- Intricate Eye of Zul
        [40175] = 12, -- Dazzling Eye of Zul
        [40176] = 12, -- Sundered Eye of Zul
        [40177] = 12, -- Lambent Eye of Zul
        [40178] = 12, -- Opaque Eye of Zul
        [40179] = 12, -- Energized Eye of Zul
        [40180] = 12, -- Radiant Eye of Zul
        [40181] = 12, -- Tense Eye of Zul
        [40182] = 12, -- Shattered Eye of Zul
        [40232] = 12, -- Test Dazzling Talasite
        [41285] = 1, -- Chaotic Skyflare Diamond
        [41307] = 1, -- Destructive Skyflare Diamond
        [41333] = 1, -- Ember Skyflare Diamond
        [41335] = 1, -- Enigmatic Skyflare Diamond
        [41339] = 1, -- Swift Skyflare Diamond
        [41375] = 1, -- Tireless Skyflare Diamond
        [41376] = 1, -- Revitalizing Skyflare Diamond
        [41377] = 1, -- Effulgent Skyflare Diamond
        [41378] = 1, -- Forlorn Skyflare Diamond
        [41379] = 1, -- Impassive Skyflare Diamond
        [41380] = 1, -- Austere Earthsiege Diamond
        [41381] = 1, -- Persistent Earthsiege Diamond
        [41382] = 1, -- Trenchant Earthsiege Diamond
        [41385] = 1, -- Invigorating Earthsiege Diamond
        [41389] = 1, -- Beaming Earthsiege Diamond
        [41395] = 1, -- Bracing Earthsiege Diamond
        [41396] = 1, -- Eternal Earthsiege Diamond
        [41397] = 1, -- Powerful Earthsiege Diamond
        [41398] = 1, -- Relentless Earthsiege Diamond
        [41400] = 1, -- Thundering Skyflare Diamond
        [41401] = 1, -- Insightful Earthsiege Diamond
        [41429] = 6, -- Perfect Wicked Huge Citrine
        [41432] = 2, -- Perfect Bold Bloodstone
        [41433] = 2, -- Perfect Bright Bloodstone
        [41434] = 2, -- Perfect Delicate Bloodstone
        [41435] = 2, -- Perfect Flashing Bloodstone
        [41436] = 2, -- Perfect Fractured Bloodstone
        [41437] = 2, -- Perfect Precise Bloodstone
        [41438] = 2, -- Perfect Runed Bloodstone
        [41439] = 2, -- Perfect Subtle Bloodstone
        [41440] = 8, -- Perfect Lustrous Chalcedony
        [41441] = 8, -- Perfect Solid Chalcedony
        [41442] = 8, -- Perfect Sparkling Chalcedony
        [41443] = 8, -- Perfect Stormy Chalcedony
        [41444] = 4, -- Perfect Brilliant Sun Crystal
        [41445] = 4, -- Perfect Mystic Sun Crystal
        [41446] = 4, -- Perfect Quick Sun Crystal
        [41447] = 4, -- Perfect Rigid Sun Crystal
        [41448] = 4, -- Perfect Smooth Sun Crystal
        [41449] = 4, -- Perfect Thick Sun Crystal
        [41450] = 10, -- Perfect Balanced Shadow Crystal
        [41451] = 10, -- Perfect Defender's Shadow Crystal
        [41452] = 10, -- Perfect Glowing Shadow Crystal
        [41453] = 10, -- Perfect Guardian's Shadow Crystal
        [41454] = 10, -- Perfect Infused Shadow Crystal
        [41455] = 10, -- Perfect Mysterious Shadow Crystal
        [41456] = 10, -- Perfect Puissant Shadow Crystal
        [41457] = 10, -- Perfect Purified Shadow Crystal
        [41458] = 10, -- Perfect Regal Shadow Crystal
        [41459] = 10, -- Perfect Royal Shadow Crystal
        [41460] = 10, -- Perfect Shifting Shadow Crystal
        [41461] = 10, -- Perfect Sovereign Shadow Crystal
        [41462] = 10, -- Perfect Tenuous Shadow Crystal
        [41463] = 12, -- Perfect Dazzling Dark Jade
        [41464] = 12, -- Perfect Enduring Dark Jade
        [41465] = 12, -- Perfect Energized Dark Jade
        [41466] = 12, -- Perfect Forceful Dark Jade
        [41467] = 12, -- Perfect Intricate Dark Jade
        [41468] = 12, -- Perfect Jagged Dark Jade
        [41469] = 12, -- Perfect Lambent Dark Jade
        [41470] = 12, -- Perfect Misty Dark Jade
        [41471] = 12, -- Perfect Opaque Dark Jade
        [41472] = 12, -- Perfect Radiant Dark Jade
        [41473] = 12, -- Perfect Seer's Dark Jade
        [41474] = 12, -- Perfect Shattered Dark Jade
        [41475] = 12, -- Perfect Shining Dark Jade
        [41476] = 12, -- Perfect Steady Dark Jade
        [41477] = 12, -- Perfect Sundered Dark Jade
        [41478] = 12, -- Perfect Tense Dark Jade
        [41479] = 12, -- Perfect Timeless Dark Jade
        [41480] = 12, -- Perfect Turbid Dark Jade
        [41481] = 12, -- Perfect Vivid Dark Jade
        [41482] = 6, -- Perfect Accurate Huge Citrine
        [41483] = 6, -- Perfect Champion's Huge Citrine
        [41484] = 6, -- Perfect Deadly Huge Citrine
        [41485] = 6, -- Perfect Deft Huge Citrine
        [41486] = 6, -- Perfect Durable Huge Citrine
        [41487] = 6, -- Perfect Empowered Huge Citrine
        [41488] = 6, -- Perfect Etched Huge Citrine
        [41489] = 6, -- Perfect Fierce Huge Citrine
        [41490] = 6, -- Perfect Glimmering Huge Citrine
        [41491] = 6, -- Perfect Glinting Huge Citrine
        [41492] = 6, -- Perfect Inscribed Huge Citrine
        [41493] = 6, -- Perfect Lucent Huge Citrine
        [41494] = 6, -- Perfect Luminous Huge Citrine
        [41495] = 6, -- Perfect Potent Huge Citrine
        [41496] = 6, -- Perfect Pristine Huge Citrine
        [41497] = 6, -- Perfect Reckless Huge Citrine
        [41498] = 6, -- Perfect Resolute Huge Citrine
        [41499] = 6, -- Perfect Resplendent Huge Citrine
        [41500] = 6, -- Perfect Stalwart Huge Citrine
        [41501] = 6, -- Perfect Stark Huge Citrine
        [41502] = 6, -- Perfect Veiled Huge Citrine
        [42142] = 2, -- Bold Dragon's Eye
        [42143] = 2, -- Delicate Dragon's Eye
        [42144] = 2, -- Runed Dragon's Eye
        [42145] = 8, -- Sparkling Dragon's Eye
        [42146] = 8, -- Lustrous Dragon's Eye
        [42148] = 4, -- Brilliant Dragon's Eye
        [42149] = 4, -- Smooth Dragon's Eye
        [42150] = 4, -- Quick Dragon's Eye
        [42151] = 2, -- Subtle Dragon's Eye
        [42152] = 2, -- Flashing Dragon's Eye
        [42153] = 2, -- Fractured Dragon's Eye
        [42154] = 2, -- Precise Dragon's Eye
        [42155] = 8, -- Stormy Dragon's Eye
        [42156] = 4, -- Rigid Dragon's Eye
        [42157] = 4, -- Thick Dragon's Eye
        [42158] = 4, -- Mystic Dragon's Eye
        [42701] = 14, -- Enchanted Pearl
        [42702] = 14, -- Enchanted Tear
        [44066] = 8, -- Kharmaa's Grace
        [44076] = 1, -- Swift Starflare Diamond
        [44078] = 1, -- Tireless Starflare Diamond
        [44081] = 1, -- Enigmatic Starflare Diamond
        [44082] = 1, -- Impassive Starflare Diamond
        [44084] = 1, -- Forlorn Starflare Diamond
        [44087] = 1, -- Persistent Earthshatter Diamond
        [44088] = 1, -- Powerful Earthshatter Diamond
        [44089] = 1, -- Trenchant Earthshatter Diamond
        [45862] = 2, -- Bold Stormjewel
        [45879] = 2, -- Delicate Stormjewel
        [45880] = 8, -- Solid Stormjewel
        [45881] = 8, -- Sparkling Stormjewel
        [45882] = 4, -- Brilliant Stormjewel
        [45883] = 2, -- Runed Stormjewel
        [45987] = 4, -- Rigid Stormjewel
        [49110] = 14, -- Nightmare Tear
    },
    MP5 = {
        [23106] = 2, -- Dazzling Deep Peridot
        [23109] = 2, -- Royal Shadow Draenite
        [23121] = 3, -- Lustrous Azure Moonstone
        [24037] = 4, -- Lustrous Star of Elune
        [24057] = 2, -- Royal Nightseye
        [24065] = 2, -- Dazzling Talasite
        [28465] = 2, -- Lustrous Zircon
        [30550] = 2, -- Sundered Chrysoprase
        [30560] = 2, -- Rune Covered Chrysoprase
        [30589] = 2, -- Dazzling Chrysoprase
        [30594] = 2, -- Effulgent Chrysoprase
        [30603] = 2, -- Royal Tanzanite
        [30606] = 2, -- Lambent Chrysoprase
        [31864] = 1, -- Infused Shadow Draenite
        [31865] = 2, -- Infused Nightseye
        [32202] = 5, -- Lustrous Empyrean Sapphire
        [32214] = 3, -- Infused Shadowsong Amethyst
        [32216] = 3, -- Royal Shadowsong Amethyst
        [32225] = 3, -- Dazzling Seaspray Emerald
        [39927] = 6, -- Lustrous Chalcedony
        [39942] = 3, -- Tenuous Shadow Crystal
        [39943] = 3, -- Royal Shadow Crystal
        [39944] = 3, -- Infused Shadow Crystal
        [39984] = 3, -- Dazzling Dark Jade
        [39985] = 3, -- Sundered Dark Jade
        [39986] = 3, -- Lambent Dark Jade
        [39988] = 3, -- Opaque Dark Jade
        [39989] = 3, -- Energized Dark Jade
        [40010] = 8, -- Lustrous Sky Sapphire
        [40024] = 4, -- Tenuous Twilight Opal
        [40027] = 4, -- Royal Twilight Opal
        [40030] = 4, -- Infused Twilight Opal
        [40094] = 4, -- Dazzling Forest Emerald
        [40096] = 4, -- Sundered Forest Emerald
        [40100] = 4, -- Lambent Forest Emerald
        [40103] = 4, -- Opaque Forest Emerald
        [40105] = 4, -- Energized Forest Emerald
        [40121] = 10, -- Lustrous Majestic Zircon
        [40131] = 5, -- Tenuous Dreadstone
        [40134] = 5, -- Royal Dreadstone
        [40137] = 5, -- Infused Dreadstone
        [40175] = 5, -- Dazzling Eye of Zul
        [40176] = 5, -- Sundered Eye of Zul
        [40177] = 5, -- Lambent Eye of Zul
        [40178] = 5, -- Opaque Eye of Zul
        [40179] = 5, -- Energized Eye of Zul
        [41376] = 11, -- Revitalizing Skyflare Diamond
        [41440] = 7, -- Perfect Lustrous Chalcedony
        [41454] = 4, -- Perfect Infused Shadow Crystal
        [41459] = 4, -- Perfect Royal Shadow Crystal
        [41462] = 4, -- Perfect Tenuous Shadow Crystal
        [41463] = 4, -- Perfect Dazzling Dark Jade
        [41465] = 4, -- Perfect Energized Dark Jade
        [41469] = 4, -- Perfect Lambent Dark Jade
        [41471] = 4, -- Perfect Opaque Dark Jade
        [41477] = 4, -- Perfect Sundered Dark Jade
        [42146] = 17, -- Lustrous Dragon's Eye
    },
}
Data.Item = {
    IsTimeworn = {
        [233496] = true,
        [233505] = true,
        [233506] = true,
        [233514] = true,
        [233516] = true,
        [233517] = true,
        [233518] = true,
        [233520] = true,
        [233521] = true,
        [233522] = true,
        [233523] = true,
        [233559] = true,
        [233560] = true,
        [233561] = true,
        [233563] = true,
        [233564] = true,
        [233566] = true,
        [233567] = true,
        [233568] = true,
        [233573] = true,
        [233574] = true,
        [233575] = true,
        [233577] = true,
        [233578] = true,
        [233579] = true,
        [233582] = true,
        [233583] = true,
        [233584] = true,
        [233590] = true,
        [233591] = true,
        [233592] = true,
        [233593] = true,
        [233594] = true,
        [233595] = true,
        [233598] = true,
        [233603] = true,
        [233604] = true,
        [233607] = true,
        [233608] = true,
        [233610] = true,
        [233611] = true,
        [233612] = true,
        [233613] = true,
        [233614] = true,
        [233617] = true,
        [233618] = true,
        [233619] = true,
        [233622] = true,
        [233623] = true,
        [233624] = true,
        [233625] = true,
        [233631] = true,
        [233632] = true,
        [233633] = true,
        [233635] = true,
        [233637] = true,
        [233644] = true,
        [233645] = true,
        [233646] = true,
        [234062] = true,
        [234063] = true,
        [234064] = true,
        [234065] = true,
        [234066] = true,
        [234068] = true,
        [234069] = true,
        [234070] = true,
        [234071] = true,
        [234072] = true,
        [234073] = true,
        [234075] = true,
        [234077] = true,
        [234078] = true,
        [234081] = true,
        [234082] = true,
        [234084] = true,
        [234087] = true,
        [234088] = true,
        [234090] = true,
        [234091] = true,
        [234093] = true,
        [234094] = true,
        [234095] = true,
        [234098] = true,
        [234099] = true,
        [234100] = true,
        [234102] = true,
        [234103] = true,
        [234105] = true,
        [234106] = true,
        [234107] = true,
        [234108] = true,
        [234109] = true,
        [234110] = true,
        [234111] = true,
        [234114] = true,
        [234117] = true,
        [234120] = true,
        [234123] = true,
        [234146] = true,
        [234147] = true,
        [234148] = true,
        [234149] = true,
        [234150] = true,
        [234156] = true,
        [234157] = true,
        [234161] = true,
        [234162] = true,
        [234163] = true,
        [234164] = true,
        [234165] = true,
        [234166] = true,
        [234167] = true,
        [234168] = true,
        [234171] = true,
        [234173] = true,
        [234174] = true,
        [234962] = true,
        [234963] = true,
        [235047] = true,
    },
    Socket = {
        [18546] = {[0] = 2854,1,3,0}, -- Infernal Headcage
        [19131] = {[0] = 2869,4,0,0}, -- Snowblind Shoes
        [19135] = {[0] = 2869,4,0,0}, -- Blacklight Bracer
        [21865] = {[0] = 2869,3,2,4}, -- Soulcloth Vest
        [23229] = {[0] = 2392,7,7,0}, -- Sword of Sockety Goodness
        [23534] = {[0] = 2882,2,4,3}, -- Storm Helm
        [24022] = {[0] = 2865,2,4,3}, -- Scale Leggings of the Skirmisher
        [24083] = {[0] = 2865,2,4,4}, -- Lifegiver Britches
        [24256] = {[0] = 2883,2,3,0}, -- Girdle of Ruination
        [24262] = {[0] = 2882,4,3,2}, -- Spellstrike Pants
        [24266] = {[0] = 2868,4,3,2}, -- Spellstrike Hood
        [24393] = {[0] = 2866,2,4,0}, -- Bloody Surgeon's Mitts
        [24397] = {[0] = 2868,2,3,4}, -- Raiments of Divine Authority
        [24455] = {[0] = 2865,2,3,4}, -- Tunic of the Nightwatcher
        [25923] = {[0] = 2881,2,3,0}, -- Fierce Mantle
        [25924] = {[0] = 2866,2,3,0}, -- Swamprunner's Boots
        [25930] = {[0] = 2882,3,2,4}, -- Cenarion Thicket Helm
        [25931] = {[0] = 2882,2,3,3}, -- Cenarion Thicket Circlet
        [25932] = {[0] = 2882,2,3,4}, -- Cenarion Thicket Jerkin
        [25955] = {[0] = 2865,2,2,3}, -- Mask of the Howling Storm
        [25967] = {[0] = 2881,2,3,0}, -- Eagle Crested Pauldrons
        [25968] = {[0] = 2883,2,3,0}, -- Shalassi Sentry's Epaulets
        [25969] = {[0] = 2882,2,3,0}, -- Rapscallion's Touch
        [25970] = {[0] = 2883,2,3,0}, -- Shalassi Oracle's Sandals
        [27408] = {[0] = 2865,2,3,4}, -- Hope Bearer Helm
        [27409] = {[0] = 2865,2,4,4}, -- Raven-Heart Headdress
        [27414] = {[0] = 2865,2,2,3}, -- Mok'Nathal Beast-Mask
        [27487] = {[0] = 2882,2,3,4}, -- Bloodlord Legplates
        [27492] = {[0] = 2865,2,3,3}, -- Moonchild Leggings
        [27647] = {[0] = 2867,3,0,0}, -- Marksman's Legguards
        [27649] = {[0] = 2867,3,0,0}, -- Hierophant's Leggings
        [27650] = {[0] = 2867,3,0,0}, -- Shadowstalker's Leggings
        [27652] = {[0] = 2867,3,0,0}, -- Stormbreaker's Leggings
        [27653] = {[0] = 2867,3,0,0}, -- Slayer's Leggings
        [27654] = {[0] = 2867,3,0,0}, -- Avenger's Legplates
        [27773] = {[0] = 2869,2,2,4}, -- Barbaric Legstraps
        [27893] = {[0] = 2865,2,3,4}, -- Ornate Leggings of the Venerated
        [27986] = {[0] = 2868,2,2,2}, -- Crow Wing Reaper
        [28170] = {[0] = 2881,2,0,0}, -- Auchenai Bracers
        [28186] = {[0] = 2865,2,3,4}, -- Laughing Skull Battle-Harness
        [28203] = {[0] = 2865,2,3,4}, -- Breastplate of the Righteous
        [28218] = {[0] = 2868,2,4,4}, -- Pontiff's Pantaloons of Prophecy
        [28229] = {[0] = 2869,3,3,2}, -- Incanter's Robe
        [28230] = {[0] = 2868,2,3,4}, -- Hallowed Garments
        [28232] = {[0] = 2868,2,3,4}, -- Robe of Oblivion
        [28275] = {[0] = 2865,2,1,0}, -- Beast Lord Helm
        [28285] = {[0] = 2869,3,1,0}, -- Helm of the Righteous
        [28337] = {[0] = 2865,2,2,4}, -- Breastplate of Righteous Fury
        [28349] = {[0] = 2869,3,1,0}, -- Tidefury Helm
        [28381] = {[0] = 2867,3,0,0}, -- General's Plate Bracers
        [28424] = {[0] = 2867,3,0,0}, -- General's Leather Bracers
        [28441] = {[0] = 3308,4,0,0}, -- Deep Thunder
        [28445] = {[0] = 2867,2,0,0}, -- General's Dragonhide Bracers
        [28448] = {[0] = 2867,2,0,0}, -- General's Wyrmhide Bracers
        [28451] = {[0] = 2867,3,0,0}, -- General's Chain Bracers
        [28521] = {[0] = 2866,4,3,0}, -- Mitts of the Treemender
        [28605] = {[0] = 2867,3,0,0}, -- General's Linked Bracers
        [28621] = {[0] = 2868,2,3,3}, -- Wrynn Dynasty Greaves
        [28638] = {[0] = 2867,3,0,0}, -- General's Mail Bracers
        [28643] = {[0] = 2867,3,0,0}, -- General's Lamellar Bracers
        [28646] = {[0] = 2867,3,0,0}, -- General's Scaled Bracers
        [28740] = {[0] = 2868,2,3,4}, -- Rip-Flayer Leggings
        [28748] = {[0] = 2869,3,4,4}, -- Legplates of the Innocent
        [28751] = {[0] = 2869,4,4,3}, -- Heart-Flame Leggings
        [28800] = {[0] = 2869,2,2,4}, -- Hammer of the Naaru
        [28964] = {[0] = 2868,3,3,2}, -- Voidheart Robe
        [28973] = {[0] = 2867,3,0,0}, -- Marshal's Chain Bracers
        [28978] = {[0] = 2867,2,0,0}, -- Marshal's Dragonhide Bracers
        [28984] = {[0] = 2867,3,0,0}, -- Marshal's Lamellar Bracers
        [28988] = {[0] = 2867,3,0,0}, -- Marshal's Leather Bracers
        [28989] = {[0] = 2867,3,0,0}, -- Marshal's Linked Bracers
        [28992] = {[0] = 2867,3,0,0}, -- Marshal's Mail Bracers
        [28996] = {[0] = 2867,3,0,0}, -- Marshal's Plate Bracers
        [28999] = {[0] = 2867,3,0,0}, -- Marshal's Scaled Bracers
        [29006] = {[0] = 2867,2,0,0}, -- Marshal's Wyrmhide Bracers
        [29029] = {[0] = 2869,2,3,4}, -- Cyclone Hauberk
        [29031] = {[0] = 2881,4,4,0}, -- Cyclone Shoulderpads
        [29050] = {[0] = 2869,2,4,4}, -- Robes of the Incarnate
        [29061] = {[0] = 2865,2,1,0}, -- Justicar Diadem
        [29062] = {[0] = 2868,4,4,3}, -- Justicar Chestpiece
        [29071] = {[0] = 2868,2,2,4}, -- Justicar Breastplate
        [29086] = {[0] = 2869,2,1,0}, -- Crown of Malorne
        [29089] = {[0] = 2866,4,4,0}, -- Shoulderguards of Malorne
        [29129] = {[0] = 2865,3,4,3}, -- Anchorite's Robes
        [29141] = {[0] = 2865,2,3,3}, -- Tempest Leggings
        [29142] = {[0] = 2865,2,3,3}, -- Kurenai Kilt
        [29306] = {[0] = 2865,4,0,0}, -- Band of Eternity
        [29307] = {[0] = 2865,4,0,0}, -- Band of Eternity
        [29308] = {[0] = 2865,4,0,0}, -- Band of Eternity
        [29309] = {[0] = 2865,4,0,0}, -- Band of the Eternal Restorer
        [29337] = {[0] = 2868,3,3,3}, -- The Exarch's Protector
        [29344] = {[0] = 2869,3,3,3}, -- Haramad's Linked Chain Pantaloons
        [29965] = {[0] = 2865,4,0,0}, -- Girdle of the Righteous Path
        [29988] = {[0] = 2869,4,0,0}, -- The Nexus Key
        [30015] = {[0] = 2869,3,0,0}, -- The Sun King's Talisman
        [30018] = {[0] = 2865,4,0,0}, -- Lord Sanguinar's Claim
        [30027] = {[0] = 2865,4,0,0}, -- Boots of Courage Unending
        [30030] = {[0] = 3306,3,3,0}, -- Girdle of Fallen Stars
        [30033] = {[0] = 2882,4,0,0}, -- Boots of the Protector
        [30066] = {[0] = 3308,2,0,0}, -- Tempest-Strider Boots
        [30068] = {[0] = 3308,3,0,0}, -- Girdle of the Tidal Call
        [30109] = {[0] = 2869,4,0,0}, -- Ring of Endless Coils
        [30119] = {[0] = 3308,4,0,0}, -- Destroyer Gauntlets
        [30138] = {[0] = 2869,2,0,0}, -- Crystalforge Pauldrons
        [30153] = {[0] = 3306,4,2,0}, -- Breeches of the Avatar
        [30160] = {[0] = 2869,4,0,0}, -- Handguards of the Avatar
        [30165] = {[0] = 2865,4,0,0}, -- Cataclysm Gloves
        [30167] = {[0] = 3306,3,4,0}, -- Cataclysm Legguards
        [30170] = {[0] = 2865,3,0,0}, -- Cataclysm Handgrips
        [30172] = {[0] = 3306,2,4,0}, -- Cataclysm Leggings
        [30189] = {[0] = 2869,3,0,0}, -- Cataclysm Gauntlets
        [30205] = {[0] = 3308,4,0,0}, -- Gloves of Tirisfal
        [30210] = {[0] = 2869,4,0,0}, -- Mantle of Tirisfal
        [30211] = {[0] = 3308,4,0,0}, -- Gloves of the Corruptor
        [30217] = {[0] = 2869,4,0,0}, -- Nordrassil Gloves
        [30232] = {[0] = 2869,2,0,0}, -- Nordrassil Gauntlets
        [30726] = {[0] = 2865,3,0,0}, -- Archaic Charm of Presence
        [30728] = {[0] = 2854,1,4,0}, -- Fathom-Helm of the Deeps
        [30732] = {[0] = 2865,4,0,0}, -- Exodar Life-Staff
        [30736] = {[0] = 2865,3,0,0}, -- Ring of Flowing Light
        [30869] = {[0] = 2881,4,0,0}, -- Howling Wind Bracers
        [30882] = {[0] = 2881,2,0,0}, -- Bastion of Light
        [30974] = {[0] = 2868,1,2,0}, -- Onslaught Greathelm
        [30976] = {[0] = 2868,2,2,3}, -- Onslaught Chestguard
        [30988] = {[0] = 2865,3,1,0}, -- Lightbringer Greathelm
        [30991] = {[0] = 2868,2,2,3}, -- Lightbringer Chestguard
        [31015] = {[0] = 2868,1,3,0}, -- Skyshatter Cover
        [31016] = {[0] = 2865,4,4,3}, -- Skyshatter Chestguard
        [31019] = {[0] = 2881,2,0,0}, -- Skyshatter Leggings
        [31056] = {[0] = 2868,1,3,0}, -- Cowl of the Tempest
        [31060] = {[0] = 2881,4,0,0}, -- Gloves of Absolution
        [31598] = {[0] = 2867,2,0,0}, -- General's Kodohide Bracers
        [31599] = {[0] = 2867,2,0,0}, -- Marshal's Kodohide Bracers
        [32083] = {[0] = 2868,4,1,0}, -- Faceguard of Determination
        [32084] = {[0] = 2865,1,3,0}, -- Helmet of the Steadfast Champion
        [32085] = {[0] = 2865,2,1,0}, -- Warpstalker Helm
        [32235] = {[0] = 2868,1,3,0}, -- Cursed Vision of Sargeras
        [32240] = {[0] = 2865,1,2,0}, -- Guise of the Tidal Lurker
        [32263] = {[0] = 2868,3,3,2}, -- Praetorian's Legguards
        [32267] = {[0] = 2882,2,0,0}, -- Boots of the Resilient
        [32353] = {[0] = 2881,2,4,0}, -- Gloves of Unfailing Faith
        [32373] = {[0] = 2868,1,3,0}, -- Helm of the Illidari Shatterer
        [32376] = {[0] = 2865,2,1,0}, -- Forest Prowler's Helm
        [32473] = {[0] = 2882,1,3,0}, -- Tankatronic Goggles
        [32521] = {[0] = 2868,1,2,0}, -- Faceplate of the Impenetrable
        [32809] = {[0] = 2867,3,0,0}, -- Veteran's Chain Bracers
        [32810] = {[0] = 2867,2,0,0}, -- Veteran's Dragonhide Bracers
        [32812] = {[0] = 2867,2,0,0}, -- Veteran's Kodohide Bracers
        [32813] = {[0] = 2867,3,0,0}, -- Veteran's Lamellar Bracers
        [32814] = {[0] = 2867,3,0,0}, -- Veteran's Leather Bracers
        [32816] = {[0] = 2867,3,0,0}, -- Veteran's Linked Bracers
        [32817] = {[0] = 2867,3,0,0}, -- Veteran's Mail Bracers
        [32818] = {[0] = 2867,3,0,0}, -- Veteran's Plate Bracers
        [32819] = {[0] = 2867,3,0,0}, -- Veteran's Scaled Bracers
        [32821] = {[0] = 2867,2,0,0}, -- Veteran's Wyrmhide Bracers
        [32866] = {[0] = 2883,4,3,0}, -- Ascendant's Boots
        [32871] = {[0] = 2882,3,4,4}, -- Horns of the Illidari
        [32983] = {[0] = 2867,3,0,0}, -- General's Ornamented Bracers
        [32986] = {[0] = 2867,3,0,0}, -- Marshal's Ornamented Bracers
        [32989] = {[0] = 2867,3,0,0}, -- Veteran's Ornamented Bracers
        [32991] = {[0] = 2867,3,0,0}, -- General's Ringmail Bracers
        [32994] = {[0] = 2867,3,0,0}, -- Marshal's Ringmail Bracers
        [32997] = {[0] = 2867,3,0,0}, -- Veteran's Ringmail Bracers
        [33216] = {[0] = 2865,2,4,3}, -- Chestguard of Hidden Purpose
        [33286] = {[0] = 2865,2,3,4}, -- Mojo-mender's Mask
        [33332] = {[0] = 2881,3,0,0}, -- Enamelled Disc of Mojo
        [33421] = {[0] = 2868,2,3,4}, -- Battleworn Tuskguard
        [33463] = {[0] = 2865,2,3,4}, -- Hood of the Third Eye
        [33473] = {[0] = 2868,3,2,4}, -- Chestguard of the Warlord
        [33480] = {[0] = 2881,2,4,0}, -- Cord of Braided Troll Hair
        [33515] = {[0] = 2868,2,3,4}, -- Unwavering Legguards
        [33520] = {[0] = 2881,3,0,0}, -- Vambraces of the Naaru
        [33522] = {[0] = 2868,2,3,4}, -- Chestguard of the Stoic Guardian
        [33530] = {[0] = 2865,3,2,4}, -- Natural Life Leggings
        [33552] = {[0] = 2865,2,3,4}, -- Pants of Splendid Recovery
        [33810] = {[0] = 2868,2,3,4}, -- Amani Mask of Death
        [33876] = {[0] = 2867,3,0,0}, -- Vindicator's Chain Bracers
        [33881] = {[0] = 2867,2,0,0}, -- Vindicator's Dragonhide Bracers
        [33887] = {[0] = 2867,2,0,0}, -- Vindicator's Kodohide Bracers
        [33889] = {[0] = 2867,3,0,0}, -- Vindicator's Lamellar Bracers
        [33893] = {[0] = 2867,3,0,0}, -- Vindicator's Leather Bracers
        [33894] = {[0] = 2867,3,0,0}, -- Vindicator's Linked Bracers
        [33897] = {[0] = 2867,3,0,0}, -- Vindicator's Mail Bracers
        [33904] = {[0] = 2867,3,0,0}, -- Vindicator's Ornamented Bracers
        [33906] = {[0] = 2867,3,0,0}, -- Vindicator's Ringmail Bracers
        [33910] = {[0] = 2867,3,0,0}, -- Vindicator's Scaled Bracers
        [33917] = {[0] = 2867,2,0,0}, -- Vindicator's Wyrmhide Bracers
        [33971] = {[0] = 2865,2,3,4}, -- Elunite Imbued Leggings
        [34167] = {[0] = 2865,2,3,4}, -- Legplates of the Holy Juggernaut
        [34199] = {[0] = 2881,2,0,0}, -- Archon's Gavel
        [34202] = {[0] = 2881,2,4,0}, -- Shawl of Wonderment
        [34208] = {[0] = 2881,3,2,0}, -- Equilibrium Epaulets
        [34209] = {[0] = 2881,4,2,0}, -- Spaulders of Reclamation
        [34212] = {[0] = 2865,2,4,4}, -- Sunglow Vest
        [34216] = {[0] = 2868,4,3,3}, -- Heroic Judicator's Chestguard
        [34229] = {[0] = 2865,2,2,2}, -- Garments of Serene Shores
        [34240] = {[0] = 2881,3,2,0}, -- Gauntlets of the Soothed Soul
        [34245] = {[0] = 2865,1,2,0}, -- Cover of Ursol the Wise
        [34247] = {[0] = 2868,2,2,2}, -- Apolyon, the Soul-Render
        [34335] = {[0] = 2881,4,0,0}, -- Hammer of Sanctification
        [34339] = {[0] = 2865,1,2,0}, -- Cowl of Light's Purity
        [34342] = {[0] = 2881,2,4,0}, -- Handguards of the Dawn
        [34351] = {[0] = 2866,2,2,0}, -- Tranquil Majesty Wraps
        [34357] = {[0] = 2882,1,3,0}, -- Hard Khorium Goggles
        [34360] = {[0] = 2881,2,0,0}, -- Amulet of Flowing Life
        [34365] = {[0] = 2865,4,4,4}, -- Robe of Eternal Light
        [34367] = {[0] = 2866,4,2,0}, -- Hands of Eternal Light
        [34371] = {[0] = 2865,2,2,2}, -- Leather Chestguard of the Sun
        [34372] = {[0] = 2866,4,2,0}, -- Leather Gauntlets of the Sun
        [34375] = {[0] = 2865,2,2,2}, -- Sun-Drenched Scale Chestguard
        [34376] = {[0] = 2881,2,2,0}, -- Sun-Drenched Scale Gloves
        [34379] = {[0] = 2865,2,3,4}, -- Sunblessed Breastplate
        [34380] = {[0] = 2881,4,2,0}, -- Sunblessed Gauntlets
        [34381] = {[0] = 2868,4,4,2}, -- Felstrength Legplates
        [34382] = {[0] = 2868,4,4,2}, -- Judicator's Legguards
        [34383] = {[0] = 2865,4,2,2}, -- Kilt of Spiritual Reconstruction
        [34384] = {[0] = 2866,2,2,4}, -- Breeches of Natural Splendor
        [34394] = {[0] = 2868,4,4,2}, -- Breastplate of Agony's Aversion
        [34395] = {[0] = 2865,2,2,4}, -- Noble Judicator's Chestguard
        [34398] = {[0] = 2865,2,4,4}, -- Utopian Tunic of Elune
        [34400] = {[0] = 2868,1,4,0}, -- Crown of Dath'Remar
        [34401] = {[0] = 2868,1,4,0}, -- Helm of Uther's Resolve
        [34402] = {[0] = 2865,3,1,0}, -- Shroud of Chieftain Ner'zhul
        [34404] = {[0] = 2868,2,1,0}, -- Mask of the Fury Hunter
        [34409] = {[0] = 2881,2,4,0}, -- Gauntlets of the Ancient Frostwolf
        [34432] = {[0] = 2881,2,0,0}, -- Lightbringer Bracers
        [34438] = {[0] = 2881,2,0,0}, -- Skyshatter Bracers
        [34487] = {[0] = 2881,2,0,0}, -- Lightbringer Belt
        [34543] = {[0] = 2881,2,0,0}, -- Skyshatter Belt
        [34565] = {[0] = 2881,2,0,0}, -- Skyshatter Boots
        [34612] = {[0] = 2881,4,3,0}, -- Greaves of the Penitent Knight
        [34700] = {[0] = 2881,4,3,0}, -- Gauntlets of Divine Blessings
        [34705] = {[0] = 2881,2,0,0}, -- Bracers of Divine Infusion
        [34707] = {[0] = 2881,2,4,0}, -- Boots of Resuscitation
        [34790] = {[0] = 2881,2,0,0}, -- Battle-mace of the High Priestess
        [34791] = {[0] = 2881,2,2,0}, -- Gauntlets of the Tranquil Waves
        [34793] = {[0] = 2866,2,4,0}, -- Cord of Reconstruction
        [34795] = {[0] = 2865,3,2,2}, -- Helm of Sanctification
        [34796] = {[0] = 2865,2,3,4}, -- Robes of Summer Flame
        [34901] = {[0] = 2866,4,2,0}, -- Grovewalker's Leggings
        [34922] = {[0] = 2881,4,3,0}, -- Greaves of Pacification
        [34930] = {[0] = 2881,2,0,0}, -- Wave of Life Chestguard
        [34931] = {[0] = 2881,2,4,0}, -- Runed Scales of Antiquity
        [34965] = {[0] = 2868,2,3,4}, -- Test Copy Unwavering Legguards
        [34966] = {[0] = 2868,2,3,4}, -- Test Two Unwavering Legguards
        [35166] = {[0] = 2867,3,0,0}, -- Guardian's Chain Bracers
        [35167] = {[0] = 2867,2,0,0}, -- Guardian's Dragonhide Bracers
        [35169] = {[0] = 2867,2,0,0}, -- Guardian's Kodohide Bracers
        [35170] = {[0] = 2867,3,0,0}, -- Guardian's Lamellar Bracers
        [35171] = {[0] = 2867,3,0,0}, -- Guardian's Leather Bracers
        [35172] = {[0] = 2867,3,0,0}, -- Guardian's Linked Bracers
        [35173] = {[0] = 2867,3,0,0}, -- Guardian's Mail Bracers
        [35175] = {[0] = 2867,3,0,0}, -- Guardian's Ornamented Bracers
        [35177] = {[0] = 2867,3,0,0}, -- Guardian's Ringmail Bracers
        [35178] = {[0] = 2867,3,0,0}, -- Guardian's Scaled Bracers
        [35180] = {[0] = 2867,2,0,0}, -- Guardian's Wyrmhide Bracers
        [36969] = {[0] = 2868,2,0,0}, -- Helm of the Ley-Guardian
        [36974] = {[0] = 2865,4,0,0}, -- Eregos' Ornamented Chestguard
        [36978] = {[0] = 2868,3,0,0}, -- Ley-Whelphide Belt
        [36991] = {[0] = 2868,3,0,0}, -- Raiments of the Titans
        [36992] = {[0] = 2868,2,0,0}, -- Leather-Braced Chain Leggings
        [36996] = {[0] = 2868,2,0,0}, -- Hood of the Furtive Assassin
        [37057] = {[0] = 2868,2,0,0}, -- Drake Rider's Tunic
        [37066] = {[0] = 2868,3,0,0}, -- Ancient Royal Legguards
        [37152] = {[0] = 2865,3,0,0}, -- Girdle of Ice
        [37155] = {[0] = 3306,2,4,0}, -- Frozen Forest Kilt
        [37165] = {[0] = 3307,3,2,0}, -- Crystal-Infused Tunic
        [37167] = {[0] = 3307,2,2,0}, -- Dragon Slayer's Sabatons
        [37176] = {[0] = 3308,2,0,0}, -- Cavern Leather Treads
        [37178] = {[0] = 3308,2,0,0}, -- Strategist's Belt
        [37184] = {[0] = 2869,4,0,0}, -- Dalronn's Jerkin
        [37193] = {[0] = 3307,2,3,0}, -- Staggering Legplates
        [37244] = {[0] = 2869,2,0,0}, -- Fungi-Coated Boots
        [37292] = {[0] = 2868,3,0,0}, -- Ley-Guardian's Legguards
        [37362] = {[0] = 3307,2,3,0}, -- Leggings of Protective Auras
        [37368] = {[0] = 3308,4,0,0}, -- Silent Spectator Shoulderpads
        [37374] = {[0] = 3307,2,2,0}, -- Ravenous Leggings of the Furbolg
        [37376] = {[0] = 2868,3,0,0}, -- Ferocious Pauldrons of the Rhino
        [37389] = {[0] = 3308,2,0,0}, -- Crenelation Leggings
        [37590] = {[0] = 3308,4,0,0}, -- Bands of Fading Light
        [37627] = {[0] = 2868,3,0,0}, -- Snake Den Spaulders
        [37632] = {[0] = 2869,2,0,0}, -- Mojo Frenzy Greaves
        [37635] = {[0] = 2868,3,0,0}, -- Pauldrons of the Colossus
        [37650] = {[0] = 2869,2,0,0}, -- Shardling Legguards
        [37675] = {[0] = 3307,2,3,0}, -- Legplates of Steel Implants
        [37679] = {[0] = 2868,2,0,0}, -- Spaulders of the Abomination
        [37686] = {[0] = 2869,2,0,0}, -- Cracked Epoch Grasps
        [37687] = {[0] = 2868,3,0,0}, -- Gloves of Distorted Time
        [37730] = {[0] = 2868,2,0,0}, -- Cleric's Linen Shoes
        [37799] = {[0] = 2869,2,0,0}, -- Reanimator's Cloak
        [37800] = {[0] = 3307,2,3,0}, -- Aviary Guardsman's Hauberk
        [37818] = {[0] = 2868,2,0,0}, -- Patroller's War-Kilt
        [37825] = {[0] = 3308,3,0,0}, -- Traditionally Dyed Handguards
        [37846] = {[0] = 2868,2,0,0}, -- Charged-Bolt Grips
        [37850] = {[0] = 2868,2,0,0}, -- Flowing Sash of Order
        [37868] = {[0] = 3308,4,0,0}, -- Girdle of the Ethereal
        [37875] = {[0] = 2868,3,0,0}, -- Spaulders of the Violet Hold
        [39189] = {[0] = 2869,3,0,0}, -- Boots of Persistence
        [39190] = {[0] = 3308,2,0,0}, -- Agonal Sash
        [39195] = {[0] = 2882,4,0,0}, -- Bracers of Lost Sentiments
        [39228] = {[0] = 2865,4,0,0}, -- Web Cocoon Grips
        [39232] = {[0] = 2882,2,0,0}, -- Pendant of Lost Vocations
        [39274] = {[0] = 2865,2,0,0}, -- Retcher's Shoulderpads
        [39278] = {[0] = 2869,4,0,0}, -- Bands of Anxiety
        [39285] = {[0] = 2865,3,0,0}, -- Handgrips of Turmoil
        [39389] = {[0] = 2869,2,0,0}, -- Signet of the Malevolent
        [39391] = {[0] = 3306,4,2,0}, -- Heinous Mail Chestguard
        [39494] = {[0] = 3308,3,0,0}, -- Heroes' Frostfire Shoulderpads
        [39495] = {[0] = 2869,2,0,0}, -- Heroes' Frostfire Gloves
        [39499] = {[0] = 2868,2,0,0}, -- Heroes' Plagueheart Shoulderpads
        [39500] = {[0] = 2868,2,0,0}, -- Heroes' Plagueheart Gloves
        [39519] = {[0] = 3308,2,0,0}, -- Heroes' Gloves of Faith
        [39529] = {[0] = 2868,2,0,0}, -- Heroes' Mantle of Faith
        [39531] = {[0] = 3306,1,4,0}, -- Heroes' Dreamwalker Headpiece
        [39534] = {[0] = 2868,2,0,0}, -- Pauldrons of the Lightning Revenant
        [39544] = {[0] = 2868,2,0,0}, -- Heroes' Dreamwalker Gloves
        [39548] = {[0] = 2869,2,0,0}, -- Heroes' Dreamwalker Mantle
        [39554] = {[0] = 3307,2,3,0}, -- Heroes' Dreamwalker Raiments
        [39555] = {[0] = 3307,2,3,0}, -- Heroes' Dreamwalker Legguards
        [39556] = {[0] = 2868,2,0,0}, -- Heroes' Dreamwalker Shoulderpads
        [39581] = {[0] = 2869,2,0,0}, -- Heroes' Cryptstalker Spaulders
        [39582] = {[0] = 3308,3,0,0}, -- Heroes' Cryptstalker Handguards
        [39588] = {[0] = 3306,2,3,0}, -- Heroes' Earthshatter Tunic
        [39590] = {[0] = 2869,2,0,0}, -- Heroes' Earthshatter Spaulders
        [39591] = {[0] = 2869,2,0,0}, -- Heroes' Earthshatter Handguards
        [39596] = {[0] = 2868,2,0,0}, -- Heroes' Earthshatter Shoulderpads
        [39601] = {[0] = 2868,2,0,0}, -- Heroes' Earthshatter Grips
        [39603] = {[0] = 3307,2,3,0}, -- Heroes' Earthshatter War-Kilt
        [39613] = {[0] = 2868,2,0,0}, -- Heroes' Dreadnaught Pauldrons
        [39617] = {[0] = 3307,2,3,0}, -- Heroes' Scourgeborne Battleplate
        [39622] = {[0] = 2868,2,0,0}, -- Heroes' Dreadnaught Handguards
        [39626] = {[0] = 3307,3,2,0}, -- Heroes' Scourgeborne Legguards
        [39627] = {[0] = 2868,2,0,0}, -- Heroes' Scourgeborne Pauldrons
        [39628] = {[0] = 2854,1,2,0}, -- Heroes' Redemption Headpiece
        [39631] = {[0] = 2865,3,0,0}, -- Heroes' Redemption Spaulders
        [39634] = {[0] = 2868,2,0,0}, -- Heroes' Redemption Gauntlets
        [39642] = {[0] = 2868,3,0,0}, -- Heroes' Redemption Shoulderguards
        [39653] = {[0] = 2869,2,0,0}, -- Choker of Betrayal
        [39655] = {[0] = 2868,3,0,0}, -- Betrayer's Choker
        [39717] = {[0] = 2868,3,0,0}, -- Inexorable Sabatons
        [39719] = {[0] = 2869,2,0,0}, -- Mantle of the Locusts
        [39721] = {[0] = 2869,3,0,0}, -- Sash of the Parlor
        [39722] = {[0] = 3308,4,0,0}, -- Swarm Bindings
        [39731] = {[0] = 2869,2,0,0}, -- Punctilious Bindings
        [39734] = {[0] = 2865,4,0,0}, -- Atonement Greaves
        [39765] = {[0] = 2868,2,0,0}, -- Sinner's Bindings
        [40075] = {[0] = 2882,2,0,0}, -- Ruthlessness
        [40080] = {[0] = 2883,4,0,0}, -- Lost Jewel
        [40186] = {[0] = 3308,2,0,0}, -- Thrusting Bands
        [40187] = {[0] = 2869,2,0,0}, -- Poignant Sabatons
        [40210] = {[0] = 3306,3,4,0}, -- Chestguard of Bitter Charms
        [40235] = {[0] = 2854,1,2,0}, -- Helm of Pilgrimage
        [40242] = {[0] = 3308,3,0,0}, -- Grotesque Handgrips
        [40274] = {[0] = 2869,3,0,0}, -- Bracers of Liberation
        [40278] = {[0] = 3308,2,0,0}, -- Girdle of Chivalry
        [40279] = {[0] = 3307,3,3,0}, -- Chestguard of the Exhausted
        [40286] = {[0] = 2869,2,0,0}, -- Mantle of the Corrupted
        [40288] = {[0] = 2865,3,0,0}, -- Spaulders of Incoherence
        [40300] = {[0] = 2869,3,0,0}, -- Spire of Sunset
        [40301] = {[0] = 2869,2,0,0}, -- Cincture of Polarity
        [40302] = {[0] = 2865,4,0,0}, -- Benefactor's Gauntlets
        [40303] = {[0] = 2865,3,0,0}, -- Wraps of the Persecuted
        [40310] = {[0] = 3307,2,3,0}, -- TEST ARMOR DEATH KNIGHT LEGS
        [40315] = {[0] = 2869,2,0,0}, -- Shoulderpads of Secret Arts
        [40316] = {[0] = 2868,2,0,0}, -- Gauntlets of Guiding Touch
        [40332] = {[0] = 3308,4,0,0}, -- Abetment Bracers
        [40347] = {[0] = 2868,2,0,0}, -- Zeliek's Gauntlets
        [40374] = {[0] = 2865,4,0,0}, -- Cosmic Lights
        [40377] = {[0] = 2865,3,0,0}, -- Noble Birthright Pauldrons
        [40399] = {[0] = 2869,3,0,0}, -- Signet of Manifested Pain
        [40415] = {[0] = 2869,2,0,0}, -- Frostfire Gloves
        [40419] = {[0] = 3308,3,0,0}, -- Frostfire Shoulderpads
        [40420] = {[0] = 2868,2,0,0}, -- Plagueheart Gloves
        [40424] = {[0] = 2868,2,0,0}, -- Plagueheart Shoulderpads
        [40433] = {[0] = 2865,4,0,0}, -- Wyrmrest Band
        [40438] = {[0] = 3308,2,0,0}, -- Council Chamber Epaulets
        [40439] = {[0] = 2882,4,0,0}, -- Mantle of the Eternal Sentinel
        [40445] = {[0] = 3308,2,0,0}, -- Gloves of Faith
        [40459] = {[0] = 2868,2,0,0}, -- Mantle of Faith
        [40461] = {[0] = 3306,1,4,0}, -- Dreamwalker Headpiece
        [40466] = {[0] = 2868,2,0,0}, -- Dreamwalker Gloves
        [40470] = {[0] = 2869,2,0,0}, -- Dreamwalker Mantle
        [40471] = {[0] = 3307,2,3,0}, -- Dreamwalker Raiments
        [40493] = {[0] = 3307,2,3,0}, -- Dreamwalker Legguards
        [40494] = {[0] = 2868,2,0,0}, -- Dreamwalker Shoulderpads
        [40504] = {[0] = 3308,3,0,0}, -- Cryptstalker Handguards
        [40507] = {[0] = 2869,2,0,0}, -- Cryptstalker Spaulders
        [40508] = {[0] = 3306,2,3,0}, -- Earthshatter Tunic
        [40509] = {[0] = 2869,2,0,0}, -- Earthshatter Handguards
        [40513] = {[0] = 2869,2,0,0}, -- Earthshatter Spaulders
        [40518] = {[0] = 2868,2,0,0}, -- Earthshatter Shoulderpads
        [40520] = {[0] = 2868,2,0,0}, -- Earthshatter Grips
        [40522] = {[0] = 3307,2,3,0}, -- Earthshatter War-Kilt
        [40541] = {[0] = 2882,4,0,0}, -- Frosted Adroit Handguards
        [40545] = {[0] = 2868,2,0,0}, -- Dreadnaught Handguards
        [40548] = {[0] = 2868,2,0,0}, -- Dreadnaught Pauldrons
        [40550] = {[0] = 3307,2,3,0}, -- Scourgeborne Battleplate
        [40561] = {[0] = 2865,4,0,0}, -- Leash of Heedless Magic
        [40562] = {[0] = 2854,1,4,0}, -- Hood of Rationality
        [40566] = {[0] = 2865,4,0,0}, -- Unravelling Strands of Sanity
        [40567] = {[0] = 3307,3,2,0}, -- Scourgeborne Legguards
        [40568] = {[0] = 2868,2,0,0}, -- Scourgeborne Pauldrons
        [40571] = {[0] = 2854,1,2,0}, -- Redemption Headpiece
        [40573] = {[0] = 2865,3,0,0}, -- Redemption Spaulders
        [40575] = {[0] = 2868,2,0,0}, -- Redemption Gauntlets
        [40584] = {[0] = 2868,3,0,0}, -- Redemption Shoulderguards
        [40590] = {[0] = 2869,3,0,0}, -- Elevated Lair Pauldrons
        [40591] = {[0] = 2882,4,0,0}, -- Melancholy Sabatons
        [40646] = {[0] = 3307,2,3,0}, -- LK ARENA TEST WARRIOR BP 252
        [40647] = {[0] = 3307,2,3,0}, -- LK ARENA TEST WARRIOR BP 213
        [40654] = {[0] = 3307,2,3,0}, -- LK ARENA TEST MAGE BP 213
        [40655] = {[0] = 3307,2,3,0}, -- LK ARENA TEST MAGE BP 252
        [40656] = {[0] = 3307,2,3,0}, -- LK ARENA TEST PRIEST BP 213
        [40657] = {[0] = 3307,2,3,0}, -- LK ARENA TEST PRIEST BP 252
        [40689] = {[0] = 2868,3,0,0}, -- Waistguard of Living Iron
        [40693] = {[0] = 3308,3,0,0}, -- Beadwork Belt of Shamanic Vision
        [40918] = {[0] = 2865,4,0,0}, -- Savage Gladiator's Ornamented Gloves
        [40925] = {[0] = 2865,4,0,0}, -- Hateful Gladiator's Ornamented Gloves
        [40926] = {[0] = 2865,4,0,0}, -- Deadly Gladiator's Ornamented Gloves
        [40927] = {[0] = 2865,4,0,0}, -- Furious Gladiator's Ornamented Gloves
        [40928] = {[0] = 2865,4,0,0}, -- Relentless Gladiator's Ornamented Gloves
        [40930] = {[0] = 2854,1,2,0}, -- Savage Gladiator's Ornamented Headcover
        [40931] = {[0] = 2854,1,2,0}, -- Hateful Gladiator's Ornamented Headcover
        [40932] = {[0] = 2854,1,2,0}, -- Deadly Gladiator's Ornamented Headcover
        [40933] = {[0] = 2854,1,2,0}, -- Furious Gladiator's Ornamented Headcover
        [40934] = {[0] = 2854,1,2,0}, -- Relentless Gladiator's Ornamented Headcover
        [40960] = {[0] = 2865,3,0,0}, -- Savage Gladiator's Ornamented Spaulders
        [40961] = {[0] = 2865,3,0,0}, -- Hateful Gladiator's Ornamented Spaulders
        [40962] = {[0] = 2865,3,0,0}, -- Deadly Gladiator's Ornamented Spaulders
        [40963] = {[0] = 2865,3,0,0}, -- Furious Gladiator's Ornamented Spaulders
        [40964] = {[0] = 2865,3,0,0}, -- Relentless Gladiator's Ornamented Spaulders
        [40998] = {[0] = 2865,4,0,0}, -- Savage Gladiator's Ringmail Gauntlets
        [40999] = {[0] = 2865,4,0,0}, -- Hateful Gladiator's Ringmail Gauntlets
        [41000] = {[0] = 2865,4,0,0}, -- Deadly Gladiator's Ringmail Gauntlets
        [41001] = {[0] = 2865,4,0,0}, -- Furious Gladiator's Ringmail Gauntlets
        [41002] = {[0] = 2865,4,0,0}, -- Relentless Gladiator's Ringmail Gauntlets
        [41004] = {[0] = 2865,4,0,0}, -- Savage Gladiator's Mail Gauntlets
        [41005] = {[0] = 2865,4,0,0}, -- Hateful Gladiator's Mail Gauntlets
        [41006] = {[0] = 2865,4,0,0}, -- Deadly Gladiator's Mail Gauntlets
        [41007] = {[0] = 2865,4,0,0}, -- Furious Gladiator's Mail Gauntlets
        [41008] = {[0] = 2865,4,0,0}, -- Relentless Gladiator's Mail Gauntlets
        [41010] = {[0] = 2854,1,2,0}, -- Savage Gladiator's Ringmail Helm
        [41011] = {[0] = 2854,1,2,0}, -- Hateful Gladiator's Ringmail Helm
        [41012] = {[0] = 2854,1,2,0}, -- Deadly Gladiator's Ringmail Helm
        [41013] = {[0] = 2854,1,2,0}, -- Furious Gladiator's Ringmail Helm
        [41014] = {[0] = 2854,1,2,0}, -- Relentless Gladiator's Ringmail Helm
        [41016] = {[0] = 2854,1,2,0}, -- Savage Gladiator's Mail Helm
        [41017] = {[0] = 2854,1,2,0}, -- Hateful Gladiator's Mail Helm
        [41018] = {[0] = 2854,1,2,0}, -- Deadly Gladiator's Mail Helm
        [41019] = {[0] = 2854,1,2,0}, -- Furious Gladiator's Mail Helm
        [41020] = {[0] = 2854,1,2,0}, -- Relentless Gladiator's Mail Helm
        [41024] = {[0] = 2865,3,0,0}, -- Savage Gladiator's Ringmail Spaulders
        [41036] = {[0] = 2865,3,0,0}, -- Hateful Gladiator's Ringmail Spaulders
        [41037] = {[0] = 2865,3,0,0}, -- Deadly Gladiator's Ringmail Spaulders
        [41038] = {[0] = 2865,3,0,0}, -- Furious Gladiator's Ringmail Spaulders
        [41039] = {[0] = 2865,3,0,0}, -- Relentless Gladiator's Ringmail Spaulders
        [41041] = {[0] = 2865,3,0,0}, -- Savage Gladiator's Mail Spaulders
        [41042] = {[0] = 2865,3,0,0}, -- Hateful Gladiator's Mail Spaulders
        [41043] = {[0] = 2865,3,0,0}, -- Deadly Gladiator's Mail Spaulders
        [41044] = {[0] = 2865,3,0,0}, -- Furious Gladiator's Mail Spaulders
        [41045] = {[0] = 2865,3,0,0}, -- Relentless Gladiator's Mail Spaulders
        [41168] = {[0] = 2882,4,0,0}, -- Armor Plated Combat Shotgun
        [41918] = {[0] = 3307,2,3,0}, -- Savage Gladiator's Satin Robe
        [41919] = {[0] = 3307,2,3,0}, -- Hateful Gladiator's Satin Robe
        [41920] = {[0] = 3307,2,3,0}, -- Deadly Gladiator's Satin Robe
        [41921] = {[0] = 3307,2,3,0}, -- Furious Gladiator's Satin Robe
        [41922] = {[0] = 3307,2,3,0}, -- Relentless Gladiator's Satin Robe
        [41930] = {[0] = 2868,3,0,0}, -- Savage Gladiator's Satin Mantle
        [41931] = {[0] = 2868,3,0,0}, -- Hateful Gladiator's Satin Mantle
        [41933] = {[0] = 2868,3,0,0}, -- Deadly Gladiator's Satin Mantle
        [41934] = {[0] = 2868,3,0,0}, -- Furious Gladiator's Satin Mantle
        [41935] = {[0] = 2868,3,0,0}, -- Relentless Gladiator's Satin Mantle
        [41949] = {[0] = 3307,2,3,0}, -- Savage Gladiator's Silk Raiment
        [41950] = {[0] = 3307,2,3,0}, -- Hateful Gladiator's Silk Raiment
        [41951] = {[0] = 3307,2,3,0}, -- Deadly Gladiator's Silk Raiment
        [41953] = {[0] = 3307,2,3,0}, -- Furious Gladiator's Silk Raiment
        [41954] = {[0] = 3307,2,3,0}, -- Relentless Gladiator's Silk Raiment
        [41962] = {[0] = 2868,3,0,0}, -- Savage Gladiator's Silk Amice
        [41963] = {[0] = 2868,3,0,0}, -- Hateful Gladiator's Silk Amice
        [41964] = {[0] = 2868,3,0,0}, -- Deadly Gladiator's Silk Amice
        [41965] = {[0] = 2868,3,0,0}, -- Furious Gladiator's Silk Amice
        [41966] = {[0] = 2868,3,0,0}, -- Relentless Gladiator's Silk Amice
        [41996] = {[0] = 3307,2,3,0}, -- Savage Gladiator's Felweave Raiment
        [41997] = {[0] = 3307,2,3,0}, -- Deadly Gladiator's Felweave Raiment
        [41998] = {[0] = 3307,2,3,0}, -- Furious Gladiator's Felweave Raiment
        [41999] = {[0] = 3307,2,3,0}, -- Relentless Gladiator's Felweave Raiment
        [42001] = {[0] = 3307,2,3,0}, -- Hateful Gladiator's Felweave Raiment
        [42008] = {[0] = 2868,3,0,0}, -- Savage Gladiator's Felweave Amice
        [42009] = {[0] = 2868,3,0,0}, -- Hateful Gladiator's Felweave Amice
        [42010] = {[0] = 2868,3,0,0}, -- Deadly Gladiator's Felweave Amice
        [42011] = {[0] = 2868,3,0,0}, -- Furious Gladiator's Felweave Amice
        [42012] = {[0] = 2868,3,0,0}, -- Relentless Gladiator's Felweave Amice
        [42341] = {[0] = 3307,2,2,0}, -- Figurine - Ruby Hare
        [42413] = {[0] = 3306,4,4,0}, -- Figurine - Sapphire Owl
        [42645] = {[0] = 2868,2,0,0}, -- Titanium Impact Choker
        [42646] = {[0] = 2868,2,0,0}, -- Titanium Earthguard Chain
        [42647] = {[0] = 2869,2,0,0}, -- Titanium Spellshock Necklace
        [42827] = {[0] = 2868,4,0,0}, -- Rockshaper's Resolve
        [42850] = {[0] = 2869,4,0,0}, -- Flamebringer's Crown
        [42877] = {[0] = 2869,4,0,0}, -- Chestguard of the Frozen Ascent
        [42879] = {[0] = 2882,3,0,0}, -- Crown of Hyldnir
        [42885] = {[0] = 3308,4,0,0}, -- Mountaineer's Helm
        [43204] = {[0] = 3308,4,0,0}, -- Hyldnir Runeweaver's Garb
        [43287] = {[0] = 2869,3,0,0}, -- Silken Bridge Handwraps
        [43312] = {[0] = 2868,2,0,0}, -- Gorloc Muddy Footwraps
        [43353] = {[0] = 2868,3,0,0}, -- Void Sentry Legplates
        [43387] = {[0] = 2868,2,0,0}, -- Shoulderplates of the Beholder
        [43402] = {[0] = 2868,3,0,0}, -- The Obliterator Greaves
        [43405] = {[0] = 2869,4,0,0}, -- Sabatons of Erekem
        [43500] = {[0] = 2868,2,0,0}, -- Bolstered Legplates
        [43582] = {[0] = 2868,2,0,0}, -- Titanium Frostguard Ring
        [43584] = {[0] = 3307,2,3,0}, -- Glacial Waistband
        [43585] = {[0] = 3307,2,3,0}, -- Glacial Slippers
        [43587] = {[0] = 3307,2,3,0}, -- Icebane Girdle
        [43588] = {[0] = 3307,2,3,0}, -- Icebane Treads
        [43591] = {[0] = 3307,2,3,0}, -- Polar Cord
        [43592] = {[0] = 3307,2,3,0}, -- Polar Boots
        [43594] = {[0] = 3307,2,3,0}, -- Icy Scale Belt
        [43595] = {[0] = 3307,2,3,0}, -- Icy Scale Boots
        [43734] = {[0] = 3308,3,0,0}, -- Cryptstalker Handguards
        [43737] = {[0] = 2869,2,0,0}, -- Cryptstalker Spaulders
        [43743] = {[0] = 2868,2,0,0}, -- Dreadnaught Handguards
        [43747] = {[0] = 2868,2,0,0}, -- Dreadnaught Pauldrons
        [43750] = {[0] = 2868,2,0,0}, -- Dreamwalker Gloves
        [43754] = {[0] = 3306,1,4,0}, -- Dreamwalker Headpiece
        [43756] = {[0] = 3307,2,3,0}, -- Dreamwalker Legguards
        [43757] = {[0] = 2869,2,0,0}, -- Dreamwalker Mantle
        [43758] = {[0] = 2868,2,0,0}, -- Dreamwalker Shoulderpads
        [43765] = {[0] = 2868,2,0,0}, -- Earthshatter Grips
        [43766] = {[0] = 2869,2,0,0}, -- Earthshatter Handguards
        [43773] = {[0] = 2868,2,0,0}, -- Earthshatter Shoulderpads
        [43774] = {[0] = 2869,2,0,0}, -- Earthshatter Spaulders
        [43775] = {[0] = 3306,2,3,0}, -- Earthshatter Tunic
        [43776] = {[0] = 3307,2,3,0}, -- Earthshatter War-Kilt
        [43778] = {[0] = 2869,2,0,0}, -- Frostfire Gloves
        [43781] = {[0] = 3308,3,0,0}, -- Frostfire Shoulderpads
        [43782] = {[0] = 3308,2,0,0}, -- Gloves of Faith
        [43785] = {[0] = 2868,2,0,0}, -- Mantle of Faith
        [43788] = {[0] = 2868,2,0,0}, -- Plagueheart Gloves
        [43791] = {[0] = 2868,2,0,0}, -- Plagueheart Shoulderpads
        [43796] = {[0] = 2868,2,0,0}, -- Redemption Gauntlets
        [43800] = {[0] = 2854,1,2,0}, -- Redemption Headpiece
        [43804] = {[0] = 2868,3,0,0}, -- Redemption Shoulderguards
        [43806] = {[0] = 2865,3,0,0}, -- Redemption Spaulders
        [43809] = {[0] = 3307,2,3,0}, -- Scourgeborne Battleplate
        [43816] = {[0] = 3307,3,2,0}, -- Scourgeborne Legguards
        [43818] = {[0] = 2868,2,0,0}, -- Scourgeborne Pauldrons
        [43822] = {[0] = 3307,2,3,0}, -- Dreamwalker Raiments
        [43844] = {[0] = 2882,4,0,0}, -- Ebon Pauldrons
        [43858] = {[0] = 2868,4,0,0}, -- Vrykul Crusher
        [43879] = {[0] = 2869,4,0,0}, -- Gryphon Rider's Bracers
        [43884] = {[0] = 2868,4,0,0}, -- Amulet of the Malefic Necromancer
        [43910] = {[0] = 3308,3,0,0}, -- Gloves of the Flayed
        [43913] = {[0] = 2869,4,0,0}, -- Efrem's Bracers
        [43919] = {[0] = 2868,4,0,0}, -- Curved Assassin's Dagger
        [43930] = {[0] = 2869,4,0,0}, -- Accelerator Stompers
        [43931] = {[0] = 2869,4,0,0}, -- Savryn's Muddy Boots
        [43933] = {[0] = 2868,2,0,0}, -- Gauntlets of Urgency
        [43936] = {[0] = 2869,4,0,0}, -- Battlesurgeon's Gauntlets
        [43938] = {[0] = 2869,4,0,0}, -- Belt of Rising Hope
        [43947] = {[0] = 2868,4,0,0}, -- Stability Girdle
        [43988] = {[0] = 2868,3,0,0}, -- Gale-Proof Cloak
        [43989] = {[0] = 2865,2,0,0}, -- Remembrance Girdle
        [44000] = {[0] = 3307,2,3,0}, -- Dragonstorm Breastplate
        [44034] = {[0] = 2869,4,0,0}, -- Amulet of the Crusade
        [44035] = {[0] = 2882,2,0,0}, -- Reinforced Titanium Neckguard
        [44039] = {[0] = 3308,3,0,0}, -- Signet of Bridenbrad
        [44063] = {[0] = 3307,4,3,0}, -- Figurine - Monarch Crab
        [44181] = {[0] = 2869,4,0,0}, -- Ghostflicker Waistband
        [44197] = {[0] = 3308,3,0,0}, -- Bracers of Accorded Courtesy
        [44200] = {[0] = 2869,4,0,0}, -- Ancestral Sinew Wristguards
        [44202] = {[0] = 2869,4,0,0}, -- Sandals of Crimson Fury
        [44239] = {[0] = 2869,4,0,0}, -- Standard Issue Legguards
        [44305] = {[0] = 2865,4,0,0}, -- Kilt of Dark Mercy
        [44660] = {[0] = 2868,2,0,0}, -- Drakescale Collar
        [44665] = {[0] = 2868,2,0,0}, -- Nexus War Champion Beads
        [44901] = {[0] = 2854,1,2,0}, -- Titan-Forged Plate Headcover of Salvation
        [44904] = {[0] = 2854,1,2,0}, -- Titan-Forged Mail Helm of Dominance
        [44905] = {[0] = 2854,1,2,0}, -- Titan-Forged Ringmail Helm of Salvation
        [45226] = {[0] = 2854,1,3,0}, -- Ancient Iron Heaume
        [45274] = {[0] = 2865,2,0,0}, -- Leggings of the Stoneweaver
        [45334] = {[0] = 3307,2,3,0}, -- Unbreakable Chestguard
        [45338] = {[0] = 3307,4,2,0}, -- Valorous Darkruned Legguards
        [45355] = {[0] = 2882,3,0,0}, -- Valorous Nightsong Handgrips
        [45357] = {[0] = 3307,4,3,0}, -- Valorous Nightsong Legguards
        [45369] = {[0] = 2869,3,0,0}, -- Valorous Kirin Tor Shoulderpads
        [45370] = {[0] = 3308,2,0,0}, -- Valorous Aegis Gloves
        [45381] = {[0] = 3307,4,2,0}, -- Valorous Aegis Breastplate
        [45383] = {[0] = 2868,2,0,0}, -- Valorous Aegis Handguards
        [45385] = {[0] = 2868,2,0,0}, -- Valorous Aegis Shoulderguards
        [45404] = {[0] = 2865,2,0,0}, -- Valorous Worldbreaker Spaulders
        [45410] = {[0] = 2868,2,0,0}, -- Valorous Worldbreaker Shoulderpads
        [45427] = {[0] = 3307,3,4,0}, -- Valorous Siegebreaker Legguards
        [45434] = {[0] = 2865,3,0,0}, -- Greaves of the Rockmender
        [45440] = {[0] = 2865,2,0,0}, -- Amice of the Stoic Watch
        [45442] = {[0] = 2868,2,0,0}, -- Sorthalis, Hammer of the Watchers
        [45471] = {[0] = 2868,3,0,0}, -- Fate's Clutch
        [45485] = {[0] = 2868,3,0,0}, -- Bronze Pendant of the Vanir
        [45487] = {[0] = 3307,2,3,0}, -- Handguards of Revitalization
        [45496] = {[0] = 2868,2,0,0}, -- Titanskin Cloak
        [45514] = {[0] = 2869,3,0,0}, -- Mantle of the Unknowing
        [45542] = {[0] = 2868,3,0,0}, -- Greaves of the Stonewarder
        [45543] = {[0] = 3308,2,0,0}, -- Shoulders of Misfortune
        [45551] = {[0] = 3307,4,2,0}, -- Indestructible Plate Girdle
        [45560] = {[0] = 3307,3,4,0}, -- Spiked Deathdealers
        [45707] = {[0] = 2882,4,0,0}, -- Shieldwall of the Breaker
        [45842] = {[0] = 2868,3,2,0}, -- Wyrmguard Legplates
        [45936] = {[0] = 2869,4,0,0}, -- Legplates of Flourishing Resolve
        [45946] = {[0] = 2865,3,0,0}, -- Fire Orchid Signet
        [45996] = {[0] = 2882,4,0,0}, -- Hoperender
        [46028] = {[0] = 2370,1,4,0}, -- Faceguard of the Eyeless Horror
        [46039] = {[0] = 3307,4,4,0}, -- Breastplate of the Timeless
        [46065] = {[0] = 3307,2,3,0}, -- Titan-Forged Raiment of Dominance
        [46066] = {[0] = 3307,2,3,0}, -- Titan-Forged Raiment of Salvation
        [46121] = {[0] = 3307,4,2,0}, -- Conqueror's Darkruned Legguards
        [46134] = {[0] = 2869,3,0,0}, -- Conqueror's Kirin Tor Shoulderpads
        [46158] = {[0] = 2882,3,0,0}, -- Conqueror's Nightsong Handgrips
        [46160] = {[0] = 3307,4,3,0}, -- Conqueror's Nightsong Legguards
        [46169] = {[0] = 3307,3,4,0}, -- Conqueror's Siegebreaker Legguards
        [46173] = {[0] = 3307,4,2,0}, -- Conqueror's Aegis Breastplate
        [46174] = {[0] = 2868,2,0,0}, -- Conqueror's Aegis Handguards
        [46177] = {[0] = 2868,2,0,0}, -- Conqueror's Aegis Shoulderguards
        [46179] = {[0] = 3308,2,0,0}, -- Conqueror's Aegis Gloves
        [46204] = {[0] = 2865,2,0,0}, -- Conqueror's Worldbreaker Spaulders
        [46211] = {[0] = 2868,2,0,0}, -- Conqueror's Worldbreaker Shoulderpads
        [46214] = {[0] = 3307,4,2,0}, -- Aegis Breastplate
        [46217] = {[0] = 3308,2,0,0}, -- Aegis Gloves
        [46219] = {[0] = 2868,2,0,0}, -- Aegis Handguards
        [46225] = {[0] = 2868,2,0,0}, -- Aegis Shoulderguards
        [46238] = {[0] = 3307,4,2,0}, -- Darkruned Legguards
        [46252] = {[0] = 2869,3,0,0}, -- Kirin Tor Shoulderpads
        [46260] = {[0] = 2882,3,0,0}, -- Nightsong Handgrips
        [46265] = {[0] = 3307,4,3,0}, -- Nightsong Legguards
        [46284] = {[0] = 3307,3,4,0}, -- Siegebreaker Legguards
        [46304] = {[0] = 2868,2,0,0}, -- Worldbreaker Shoulderpads
        [46305] = {[0] = 2865,2,0,0}, -- Worldbreaker Spaulders
        [46345] = {[0] = 2869,4,0,0}, -- Bracers of Righteous Reformation
        [46962] = {[0] = 3307,2,4,0}, -- Chestplate of the Towering Monstrosity
        [46964] = {[0] = 2868,3,0,0}, -- Crystal Plated Vanguard
        [46997] = {[0] = 2868,2,0,0}, -- Dawnbreaker Greaves
        [47003] = {[0] = 3307,2,4,0}, -- Dawnbreaker Greaves
        [47052] = {[0] = 3307,2,4,0}, -- Legguards of Feverish Dedication
        [47063] = {[0] = 2868,3,0,0}, -- Pride of the Eredar
        [47072] = {[0] = 2868,2,0,0}, -- Girdle of Bloodied Scars
        [47076] = {[0] = 3307,2,4,0}, -- Girdle of Bloodied Scars
        [47111] = {[0] = 2868,2,0,0}, -- Bracers of the Shieldmaiden
        [47133] = {[0] = 2868,2,0,0}, -- The Arbiter's Muse
        [47157] = {[0] = 2868,2,0,0}, -- Signet of the Traitor King
        [47177] = {[0] = 2882,4,0,0}, -- Gloves of the Argent Fanatic
        [47178] = {[0] = 2865,4,0,0}, -- Carapace of Grim Visions
        [47201] = {[0] = 2882,2,0,0}, -- Boots of Heartfelt Repentance
        [47227] = {[0] = 2882,4,0,0}, -- Girdle of the Pallid Knight
        [47243] = {[0] = 2882,4,0,0}, -- Mark of the Relentless
        [47254] = {[0] = 3307,2,4,0}, -- Hauberk of the Towering Monstrosity
        [47269] = {[0] = 2868,2,0,0}, -- Dawnbreaker Sabatons
        [47273] = {[0] = 3307,2,4,0}, -- Legplates of Feverish Dedication
        [47283] = {[0] = 2868,2,0,0}, -- Belt of Bloodied Scars
        [47421] = {[0] = 2868,3,0,0}, -- Forlorn Barrier
        [47430] = {[0] = 3307,2,4,0}, -- Dawnbreaker Sabatons
        [47436] = {[0] = 2868,3,0,0}, -- Pride of the Demon Lord
        [47444] = {[0] = 3307,2,4,0}, -- Belt of Bloodied Scars
        [47459] = {[0] = 2868,2,0,0}, -- Armguards of the Shieldmaiden
        [47466] = {[0] = 2868,2,0,0}, -- Legionnaire's Gorget
        [47476] = {[0] = 2868,2,0,0}, -- Band of the Traitor King
        [47506] = {[0] = 2868,3,0,0}, -- Silverwing Defender
        [47510] = {[0] = 3308,3,0,0}, -- Trueheart Girdle
        [47513] = {[0] = 2868,3,0,0}, -- Orgrim's Deflector
        [47549] = {[0] = 2868,4,0,0}, -- Magni's Resolution
        [47550] = {[0] = 2868,4,0,0}, -- Cairne's Endurance
        [47562] = {[0] = 2869,4,0,0}, -- Symbol of Redemption
        [47567] = {[0] = 2869,4,0,0}, -- Gauntlets of Revelation
        [47570] = {[0] = 2868,3,0,0}, -- Saronite Swordbreakers
        [47571] = {[0] = 2868,3,0,0}, -- Saronite Swordbreakers
        [47698] = {[0] = 2868,2,0,0}, -- Shoulderplates of Enduring Order
        [47699] = {[0] = 2868,2,0,0}, -- Shoulderguards of Enduring Order
        [47747] = {[0] = 2869,4,0,0}, -- Darkbane Pendant
        [47811] = {[0] = 2882,4,0,0}, -- Chestguard of the Warden
        [47812] = {[0] = 2865,3,0,0}, -- Vigilant Ward
        [47832] = {[0] = 3308,2,0,0}, -- Spaulders of the Snow Bandit
        [47835] = {[0] = 2882,4,0,0}, -- Bulwark of the Royal Guard
        [47837] = {[0] = 2869,3,0,0}, -- Cinch of the Undying
        [47890] = {[0] = 2869,4,0,0}, -- Darkbane Amulet
        [47895] = {[0] = 2865,3,0,0}, -- Pride of the Kor'kron
        [47896] = {[0] = 2882,4,0,0}, -- Stoneskin Chestplate
        [47909] = {[0] = 2869,3,0,0}, -- Belt of the Eternal
        [47910] = {[0] = 2882,4,0,0}, -- Aegis of the Trial of the Crusader -
        [47918] = {[0] = 2882,4,0,0}, -- Dreadscale Armguards
        [47924] = {[0] = 2869,4,0,0}, -- Belt of the Frozen Reach
        [47930] = {[0] = 2869,3,0,0}, -- Amulet of Binding Elements
        [47937] = {[0] = 2882,4,0,0}, -- Girdle of the Nether Champion
        [47955] = {[0] = 2882,4,0,0}, -- Loop of the Twin Val'kyr
        [47957] = {[0] = 2869,4,0,0}, -- Darkbane Pendant
        [47963] = {[0] = 2865,3,0,0}, -- Vigilant Ward
        [47964] = {[0] = 3307,4,4,0}, -- Chestguard of the Warden
        [47977] = {[0] = 2869,3,0,0}, -- Cinch of the Undying
        [47978] = {[0] = 2882,4,0,0}, -- Bulwark of the Royal Guard
        [47989] = {[0] = 3308,2,0,0}, -- Bracers of the Northern Stalker
        [47991] = {[0] = 2882,4,0,0}, -- Dreadscale Bracers
        [47997] = {[0] = 2869,4,0,0}, -- Girdle of the Frozen Reach
        [48003] = {[0] = 2869,3,0,0}, -- Pendant of Binding Elements
        [48009] = {[0] = 2868,4,0,0}, -- Belt of the Nether Champion
        [48027] = {[0] = 2868,4,0,0}, -- Band of the Twin Val'kyr
        [48030] = {[0] = 2869,4,0,0}, -- Darkbane Amulet
        [48040] = {[0] = 2865,3,0,0}, -- Pride of the Kor'kron
        [48041] = {[0] = 3307,4,4,0}, -- Stoneskin Chestplate
        [48054] = {[0] = 2869,3,0,0}, -- Belt of the Eternal
        [48055] = {[0] = 2882,4,0,0}, -- Aegis of the Trial of the Crusader -
        [48436] = {[0] = 3307,3,4,0}, -- Wrynn's Breastplate of Conquest
        [48445] = {[0] = 3307,2,4,0}, -- Wrynn's Legguards of Conquest
        [48446] = {[0] = 3307,2,4,0}, -- Wrynn's Legguards of Triumph
        [48447] = {[0] = 3307,2,4,0}, -- Wrynn's Legguards of Triumph
        [48449] = {[0] = 2868,3,0,0}, -- Wrynn's Handguards of Conquest
        [48450] = {[0] = 3307,3,4,0}, -- Wrynn's Breastplate of Triumph
        [48451] = {[0] = 3307,3,4,0}, -- Wrynn's Breastplate of Triumph
        [48452] = {[0] = 2868,3,0,0}, -- Wrynn's Handguards of Triumph
        [48453] = {[0] = 2868,3,0,0}, -- Wrynn's Handguards of Triumph
        [48456] = {[0] = 3307,3,4,0}, -- Hellscream's Breastplate of Conquest
        [48457] = {[0] = 2868,3,0,0}, -- Hellscream's Handguards of Conquest
        [48459] = {[0] = 3307,2,4,0}, -- Hellscream's Legguards of Conquest
        [48461] = {[0] = 3307,3,4,0}, -- Hellscream's Breastplate of Triumph
        [48462] = {[0] = 2868,3,0,0}, -- Hellscream's Handguards of Triumph
        [48464] = {[0] = 3307,2,4,0}, -- Hellscream's Legguards of Triumph
        [48466] = {[0] = 3307,3,4,0}, -- Hellscream's Breastplate of Triumph
        [48467] = {[0] = 2868,3,0,0}, -- Hellscream's Handguards of Triumph
        [48469] = {[0] = 3307,2,4,0}, -- Hellscream's Legguards of Triumph
        [48531] = {[0] = 3307,3,4,0}, -- Thassarian's Chestguard of Conquest
        [48533] = {[0] = 3307,2,4,0}, -- Thassarian's Legguards of Conquest
        [48535] = {[0] = 2868,2,0,0}, -- Thassarian's Pauldrons of Conquest
        [48537] = {[0] = 2868,2,0,0}, -- Thassarian's Handguards of Conquest
        [48538] = {[0] = 3307,3,4,0}, -- Thassarian's Chestguard of Triumph
        [48539] = {[0] = 2868,2,0,0}, -- Thassarian's Handguards of Triumph
        [48541] = {[0] = 3307,2,4,0}, -- Thassarian's Legguards of Triumph
        [48542] = {[0] = 2868,2,0,0}, -- Thassarian's Pauldrons of Triumph
        [48543] = {[0] = 2868,2,0,0}, -- Thassarian's Pauldrons of Triumph
        [48544] = {[0] = 3307,2,4,0}, -- Thassarian's Legguards of Triumph
        [48546] = {[0] = 2868,2,0,0}, -- Thassarian's Handguards of Triumph
        [48547] = {[0] = 3307,3,4,0}, -- Thassarian's Chestguard of Triumph
        [48548] = {[0] = 3307,3,4,0}, -- Koltira's Chestguard of Triumph
        [48549] = {[0] = 2868,2,0,0}, -- Koltira's Handguards of Triumph
        [48551] = {[0] = 3307,2,4,0}, -- Koltira's Legguards of Triumph
        [48552] = {[0] = 2868,2,0,0}, -- Koltira's Pauldrons of Triumph
        [48553] = {[0] = 2868,2,0,0}, -- Koltira's Pauldrons of Triumph
        [48554] = {[0] = 3307,2,4,0}, -- Koltira's Legguards of Triumph
        [48556] = {[0] = 2868,2,0,0}, -- Koltira's Handguards of Triumph
        [48557] = {[0] = 3307,3,4,0}, -- Koltira's Chestguard of Triumph
        [48558] = {[0] = 3307,3,4,0}, -- Koltira's Chestguard of Conquest
        [48559] = {[0] = 2868,2,0,0}, -- Koltira's Handguards of Conquest
        [48561] = {[0] = 3307,2,4,0}, -- Koltira's Legguards of Conquest
        [48562] = {[0] = 2868,2,0,0}, -- Koltira's Pauldrons of Conquest
        [48632] = {[0] = 3307,3,4,0}, -- Turalyon's Breastplate of Conquest
        [48633] = {[0] = 2868,3,0,0}, -- Turalyon's Handguards of Conquest
        [48635] = {[0] = 3307,2,4,0}, -- Turalyon's Legguards of Conquest
        [48638] = {[0] = 3307,2,4,0}, -- Turalyon's Legguards of Triumph
        [48640] = {[0] = 2868,3,0,0}, -- Turalyon's Handguards of Triumph
        [48641] = {[0] = 3307,3,4,0}, -- Turalyon's Breastplate of Triumph
        [48642] = {[0] = 3307,3,4,0}, -- Turalyon's Breastplate of Triumph
        [48643] = {[0] = 2868,3,0,0}, -- Turalyon's Handguards of Triumph
        [48645] = {[0] = 3307,2,4,0}, -- Turalyon's Legguards of Triumph
        [48648] = {[0] = 3307,2,4,0}, -- Liadrin's Legguards of Triumph
        [48650] = {[0] = 2868,3,0,0}, -- Liadrin's Handguards of Triumph
        [48651] = {[0] = 3307,3,4,0}, -- Liadrin's Breastplate of Triumph
        [48652] = {[0] = 3307,3,4,0}, -- Liadrin's Breastplate of Conquest
        [48653] = {[0] = 2868,3,0,0}, -- Liadrin's Handguards of Conquest
        [48655] = {[0] = 3307,2,4,0}, -- Liadrin's Legguards of Conquest
        [48657] = {[0] = 3307,3,4,0}, -- Liadrin's Breastplate of Triumph
        [48658] = {[0] = 2868,3,0,0}, -- Liadrin's Handguards of Triumph
        [48660] = {[0] = 3307,2,4,0}, -- Liadrin's Legguards of Triumph
        [48670] = {[0] = 2868,4,0,0}, -- Cloak of the Unflinching Guardian
        [48675] = {[0] = 2868,4,0,0}, -- Cloak of the Unmoving Guardian
        [48870] = {[0] = 3307,3,4,0}, -- Hellscream's Breastplate
        [48872] = {[0] = 2868,3,0,0}, -- Hellscream's Handguards
        [48873] = {[0] = 3307,2,4,0}, -- Hellscream's Legguards
        [48875] = {[0] = 3307,3,4,0}, -- Wrynn's Breastplate
        [48877] = {[0] = 2868,3,0,0}, -- Wrynn's Handguards
        [48878] = {[0] = 3307,2,4,0}, -- Wrynn's Legguards
        [48890] = {[0] = 3307,3,4,0}, -- Koltira's Chestguard
        [48892] = {[0] = 2868,2,0,0}, -- Koltira's Handguards
        [48893] = {[0] = 3307,2,4,0}, -- Koltira's Legguards
        [48894] = {[0] = 2868,2,0,0}, -- Koltira's Pauldrons
        [48895] = {[0] = 3307,3,4,0}, -- Thassarian's Chestguard
        [48897] = {[0] = 2868,2,0,0}, -- Thassarian's Handguards
        [48898] = {[0] = 3307,2,4,0}, -- Thassarian's Legguards
        [48899] = {[0] = 2868,2,0,0}, -- Thassarian's Pauldrons
        [48922] = {[0] = 3307,3,4,0}, -- Liadrin's Breastplate
        [48924] = {[0] = 2868,3,0,0}, -- Liadrin's Handguards
        [48925] = {[0] = 3307,2,4,0}, -- Liadrin's Legguards
        [48927] = {[0] = 3307,3,4,0}, -- Turalyon's Breastplate
        [48929] = {[0] = 2868,3,0,0}, -- Turalyon's Handguards
        [48930] = {[0] = 3307,2,4,0}, -- Turalyon's Legguards
        [49233] = {[0] = 2869,3,0,0}, -- Sandals of the Grieving Soul
        [49234] = {[0] = 2869,3,0,0}, -- Boots of the Grieving Soul
        [49329] = {[0] = 2371,1,4,0}, -- Gaze of Ten Storms
        [49470] = {[0] = 2371,1,4,0}, -- Helmet of Ten Storms
        [49727] = {[0] = 2868,3,0,0}, -- Monster - Orgrim's Sword, Icecrown Citadel
        [49738] = {[0] = 2868,3,0,0}, -- Monster - Shield, Icecrown Citadel
        [49777] = {[0] = 2868,3,0,0}, -- Monster - Shield, Icecrown Raid - Entryway Skeletons
        [49816] = {[0] = 2868,4,0,0}, -- Scourgelord's Frigid Chestplate
        [49822] = {[0] = 3308,4,0,0}, -- Rimewoven Silks
        [49828] = {[0] = 2869,2,0,0}, -- Marwyn's Macabre Fingertips
        [49907] = {[0] = 3307,3,4,0}, -- Boots of Kingly Upheaval
        [49960] = {[0] = 2868,3,0,0}, -- Bracers of Dark Reckoning
        [49985] = {[0] = 2868,2,0,0}, -- Juggernaut Band
        [50003] = {[0] = 3307,3,4,0}, -- Boneguard Commander's Pauldrons
        [50023] = {[0] = 2868,2,0,0}, -- Bile-Encrusted Medallion
        [50036] = {[0] = 3307,2,4,0}, -- Belt of Broken Bones
        [50074] = {[0] = 2868,3,0,0}, -- Royal Crimson Cloak
        [50075] = {[0] = 3307,2,4,0}, -- Taldaram's Plated Fists
        [50185] = {[0] = 2868,2,0,0}, -- Devium's Eternally Cold Ring
        [50190] = {[0] = 3307,3,4,0}, -- Grinning Skull Greatboots
        [50195] = {[0] = 2868,3,0,0}, -- Noose of Malachite
        [50229] = {[0] = 2869,4,0,0}, -- Legguards of the Frosty Depths
        [50400] = {[0] = 2367,3,0,0}, -- Ashen Band of Endless Wisdom
        [50404] = {[0] = 2868,3,0,0}, -- Ashen Band of Endless Courage
        [50447] = {[0] = 2868,3,0,0}, -- Harbinger's Bone Band
        [50466] = {[0] = 2868,3,0,0}, -- Sentinel's Winter Cloak
        [50611] = {[0] = 2868,3,0,0}, -- Bracers of Dark Reckoning
        [50622] = {[0] = 2868,2,0,0}, -- Devium's Eternally Cold Ring
        [50625] = {[0] = 3307,3,4,0}, -- Grinning Skull Greatboots
        [50627] = {[0] = 2868,3,0,0}, -- Noose of Malachite
        [50642] = {[0] = 2868,2,0,0}, -- Juggernaut Band
        [50660] = {[0] = 3307,3,4,0}, -- Boneguard Commander's Pauldrons
        [50682] = {[0] = 2868,2,0,0}, -- Bile-Encrusted Medallion
        [50691] = {[0] = 3307,2,4,0}, -- Belt of Broken Bones
        [50708] = {[0] = 2868,3,0,0}, -- Last Word
        [50716] = {[0] = 3307,2,4,0}, -- Taldaram's Plated Fists
        [50718] = {[0] = 2868,3,0,0}, -- Royal Crimson Cloak
        [50729] = {[0] = 2868,2,0,0}, -- Icecrown Glacial Wall
        [50738] = {[0] = 2868,4,0,0}, -- Mithrios, Bronzebeard's Legacy
        [50763] = {[0] = 2868,4,0,0}, -- Marrowgar's Scratching Choker
        [50784] = {[0] = 2369,2,3,0}, -- Deathspeaker Disciple's Belt
        [50790] = {[0] = 2868,4,0,0}, -- Abomination's Bloody Ring
        [50796] = {[0] = 2869,4,0,0}, -- Bracers of Pale Illumination
        [50802] = {[0] = 2868,3,0,0}, -- Gargoyle Spit Bracers
        [50846] = {[0] = 2868,2,0,0}, -- Ymirjar Lord's Pauldrons
        [50847] = {[0] = 3307,3,4,0}, -- Ymirjar Lord's Legguards
        [50849] = {[0] = 2868,3,0,0}, -- Ymirjar Lord's Handguards
        [50850] = {[0] = 3307,2,4,0}, -- Ymirjar Lord's Breastplate
        [50853] = {[0] = 2868,2,0,0}, -- Scourgelord Pauldrons
        [50854] = {[0] = 3307,3,4,0}, -- Scourgelord Legguards
        [50856] = {[0] = 2868,3,0,0}, -- Scourgelord Handguards
        [50857] = {[0] = 3307,2,4,0}, -- Scourgelord Chestguard
        [50860] = {[0] = 2868,2,0,0}, -- Lightsworn Shoulderguards
        [50861] = {[0] = 3307,3,4,0}, -- Lightsworn Legguards
        [50863] = {[0] = 2868,3,0,0}, -- Lightsworn Handguards
        [50864] = {[0] = 3307,2,4,0}, -- Lightsworn Chestguard
        [50978] = {[0] = 3307,2,3,0}, -- Gauntlets of the Kraken
        [50991] = {[0] = 3307,2,4,0}, -- Verdigris Chain Belt
        [51006] = {[0] = 2371,3,3,0}, -- Shuffling Shoes
        [51130] = {[0] = 2868,2,0,0}, -- Sanctified Scourgelord Pauldrons
        [51131] = {[0] = 3307,3,4,0}, -- Sanctified Scourgelord Legguards
        [51132] = {[0] = 2868,3,0,0}, -- Sanctified Scourgelord Handguards
        [51134] = {[0] = 3307,2,4,0}, -- Sanctified Scourgelord Chestguard
        [51170] = {[0] = 2868,2,0,0}, -- Sanctified Lightsworn Shoulderguards
        [51171] = {[0] = 3307,3,4,0}, -- Sanctified Lightsworn Legguards
        [51172] = {[0] = 2868,3,0,0}, -- Sanctified Lightsworn Handguards
        [51174] = {[0] = 3307,2,4,0}, -- Sanctified Lightsworn Chestguard
        [51215] = {[0] = 2868,2,0,0}, -- Sanctified Ymirjar Lord's Pauldrons
        [51216] = {[0] = 3307,3,4,0}, -- Sanctified Ymirjar Lord's Legguards
        [51217] = {[0] = 2868,3,0,0}, -- Sanctified Ymirjar Lord's Handguards
        [51219] = {[0] = 3307,2,4,0}, -- Sanctified Ymirjar Lord's Breastplate
        [51220] = {[0] = 3307,2,4,0}, -- Sanctified Ymirjar Lord's Breastplate
        [51222] = {[0] = 2868,3,0,0}, -- Sanctified Ymirjar Lord's Handguards
        [51223] = {[0] = 3307,3,4,0}, -- Sanctified Ymirjar Lord's Legguards
        [51224] = {[0] = 2868,2,0,0}, -- Sanctified Ymirjar Lord's Pauldrons
        [51265] = {[0] = 3307,2,4,0}, -- Sanctified Lightsworn Chestguard
        [51267] = {[0] = 2868,3,0,0}, -- Sanctified Lightsworn Handguards
        [51268] = {[0] = 3307,3,4,0}, -- Sanctified Lightsworn Legguards
        [51269] = {[0] = 2868,2,0,0}, -- Sanctified Lightsworn Shoulderguards
        [51305] = {[0] = 3307,2,4,0}, -- Sanctified Scourgelord Chestguard
        [51307] = {[0] = 2868,3,0,0}, -- Sanctified Scourgelord Handguards
        [51308] = {[0] = 3307,3,4,0}, -- Sanctified Scourgelord Legguards
        [51309] = {[0] = 2868,2,0,0}, -- Sanctified Scourgelord Pauldrons
        [51382] = {[0] = 2865,2,0,0}, -- Heartsick Mender's Cape
        [51463] = {[0] = 3307,2,3,0}, -- Wrathful Gladiator's Silk Raiment
        [51467] = {[0] = 2868,3,0,0}, -- Wrathful Gladiator's Silk Amice
        [51469] = {[0] = 2865,4,0,0}, -- Wrathful Gladiator's Ornamented Gloves
        [51470] = {[0] = 2854,1,2,0}, -- Wrathful Gladiator's Ornamented Headcover
        [51473] = {[0] = 2865,3,0,0}, -- Wrathful Gladiator's Ornamented Spaulders
        [51487] = {[0] = 3307,2,3,0}, -- Wrathful Gladiator's Satin Robe
        [51491] = {[0] = 2868,3,0,0}, -- Wrathful Gladiator's Satin Mantle
        [51498] = {[0] = 2865,4,0,0}, -- Wrathful Gladiator's Ringmail Gauntlets
        [51499] = {[0] = 2854,1,2,0}, -- Wrathful Gladiator's Ringmail Helm
        [51502] = {[0] = 2865,3,0,0}, -- Wrathful Gladiator's Ringmail Spaulders
        [51510] = {[0] = 2865,4,0,0}, -- Wrathful Gladiator's Mail Gauntlets
        [51511] = {[0] = 2854,1,2,0}, -- Wrathful Gladiator's Mail Helm
        [51514] = {[0] = 2865,3,0,0}, -- Wrathful Gladiator's Mail Spaulders
        [51536] = {[0] = 3307,2,3,0}, -- Wrathful Gladiator's Felweave Raiment
        [51540] = {[0] = 2868,3,0,0}, -- Wrathful Gladiator's Felweave Amice
        [51556] = {[0] = 3307,2,4,0}, -- Veincrusher Gauntlets
        [51564] = {[0] = 3307,4,4,0}, -- Ironrope Belt of Ymirjar
        [51572] = {[0] = 2868,3,0,0}, -- Titan-Forged Shoulderpads of Salvation
        [51578] = {[0] = 2865,3,0,0}, -- Titan-Forged Shoulders of Dominance
        [51579] = {[0] = 2865,3,0,0}, -- Titan-Forged Shoulders of Salvation
        [51581] = {[0] = 2865,3,0,0}, -- Titan-Forged Shoulderplates of Salvation
        [51687] = {[0] = 3307,2,4,0}, -- Scourgelord Chestguard
        [51688] = {[0] = 2868,3,0,0}, -- Scourgelord Handguards
        [51690] = {[0] = 3307,3,4,0}, -- Scourgelord Legguards
        [51691] = {[0] = 2868,2,0,0}, -- Scourgelord Pauldrons
        [51727] = {[0] = 3307,2,4,0}, -- Lightsworn Chestguard
        [51728] = {[0] = 2868,3,0,0}, -- Lightsworn Handguards
        [51730] = {[0] = 3307,3,4,0}, -- Lightsworn Legguards
        [51731] = {[0] = 2868,2,0,0}, -- Lightsworn Shoulderguards
        [51772] = {[0] = 3307,2,4,0}, -- Ymirjar Lord's Breastplate
        [51773] = {[0] = 2868,3,0,0}, -- Ymirjar Lord's Handguards
        [51775] = {[0] = 3307,3,4,0}, -- Ymirjar Lord's Legguards
        [51776] = {[0] = 2868,2,0,0}, -- Ymirjar Lord's Pauldrons
        [51787] = {[0] = 3307,4,4,0}, -- Scourge Fanged Stompers
        [51816] = {[0] = 3307,4,4,0}, -- Scourge Fanged Stompers
        [51831] = {[0] = 3307,4,4,0}, -- Ironrope Belt of Ymirjar
        [51834] = {[0] = 2868,4,0,0}, -- Dreamhunter's Carbine
        [51835] = {[0] = 3307,2,4,0}, -- Veincrusher Gauntlets
        [51848] = {[0] = 2865,2,0,0}, -- Heartsick Mender's Cape
        [51873] = {[0] = 2369,3,3,0}, -- Shuffling Shoes
        [51901] = {[0] = 2868,3,0,0}, -- Gargoyle Spit Bracers
        [51907] = {[0] = 2869,4,0,0}, -- Bracers of Pale Illumination
        [51909] = {[0] = 2868,4,0,0}, -- Neverending Winter
        [51910] = {[0] = 3308,3,0,0}, -- Midnight Sun
        [51913] = {[0] = 2868,4,0,0}, -- Abomination's Bloody Ring
        [51919] = {[0] = 2369,2,3,0}, -- Deathspeaker Disciple's Belt
        [51932] = {[0] = 3308,3,0,0}, -- Frost Needle
        [51934] = {[0] = 2868,4,0,0}, -- Marrowgar's Scratching Choker
        [51947] = {[0] = 2882,4,0,0}, -- Troggbane, Axe of the Frostborne King
        [53111] = {[0] = 3307,4,2,0}, -- Scion's Treads
        [53129] = {[0] = 3307,4,4,0}, -- Treads of Impending Resurrection
        [53491] = {[0] = 3307,3,0,0}, -- Twilight Offering Bands
        [53496] = {[0] = 2868,3,0,0}, -- Barrier of the Earth Princess
        [53505] = {[0] = 2868,3,0,0}, -- Salamander Skin
        [54564] = {[0] = 3307,4,2,0}, -- Scion's Treads
        [54579] = {[0] = 3307,4,4,0}, -- Treads of Impending Resurrection
        [237050] = {[0] = 2868,2,0,0}, -- Girdle of Bloodied Scars
        [237054] = {[0] = 2868,2,0,0}, -- Dawnbreaker Greaves
        [237077] = {[0] = 2868,2,0,0}, -- Belt of Bloodied Scars
        [237081] = {[0] = 2868,2,0,0}, -- Dawnbreaker Sabatons
        [255017] = {[0] = 2869,2,0,0}, -- Arcanist Gloves
        [255023] = {[0] = 2882,2,0,0}, -- Felheart Shoulder Pads
        [255028] = {[0] = 3308,2,0,0}, -- Gloves of Prophecy
        [255048] = {[0] = 2854,1,4,0}, -- Cenarion Helm
        [255053] = {[0] = 2869,3,0,0}, -- Earthfury Gauntlets
        [255058] = {[0] = 2869,2,0,0}, -- Earthfury Epaulets
        [255066] = {[0] = 3308,3,0,0}, -- Giantstalker's Gloves
        [255067] = {[0] = 3306,2,4,0}, -- Lawbringer Breastplate
        [255068] = {[0] = 2854,1,4,0}, -- Lawbringer Helm
        [255070] = {[0] = 2865,3,0,0}, -- Lawbringer Spaulders
        [255074] = {[0] = 2865,4,0,0}, -- Lawbringer Gloves
        [255077] = {[0] = 2868,2,0,0}, -- Handguards of Might
        [255101] = {[0] = 2865,4,0,0}, -- Seal of the Archmagus
        [255130] = {[0] = 3308,4,0,0}, -- Magma Tempered Boots
        [255136] = {[0] = 3306,2,3,0}, -- Manastorm Leggings
        [256072] = {[0] = 2868,2,0,0}, -- Pauldrons of the North
        [256074] = {[0] = 3307,2,3,0}, -- Legguards of the North
        [257624] = {[0] = 2868,2,0,0}, -- Shoulders of Prophecy
        [257634] = {[0] = 3307,2,3,0}, -- Battleplate of the North
        [257638] = {[0] = 2868,2,0,0}, -- Lawbringer Gauntlets
        [257645] = {[0] = 2882,3,0,0}, -- Lawbringer Shoulderplates
        [257653] = {[0] = 2868,4,0,0}, -- Cenarion Shoulders
        [257654] = {[0] = 3307,2,3,0}, -- Cenarion Legguards
        [257658] = {[0] = 3307,3,4,0}, -- Cenarion Armor
        [257662] = {[0] = 2869,3,0,0}, -- Cenarion Mantle
        [257669] = {[0] = 2882,2,0,0}, -- Earthfury Mantle
        [257678] = {[0] = 3307,2,3,0}, -- Earthfury Legguards
        [257680] = {[0] = 2882,2,0,0}, -- Earthfury Handguards
        [265333] = {[0] = 3308,3,0,0}, -- Dreadboots of Desecration
        [265346] = {[0] = 3307,2,3,0}, -- Hydraxxian Venom Boots
        [265347] = {[0] = 3307,2,3,0}, -- Hydraxxian Venom Cord
        [265350] = {[0] = 3307,2,3,0}, -- Toxic Treads
        [265351] = {[0] = 3307,2,3,0}, -- Toxic Girdle
        [265356] = {[0] = 2868,2,0,0}, -- Titanium Venomguard Ring
    },
    SpellHaste = {
        [235874] = 2,
        [236060] = 2,
        [236062] = 2,
        [236064] = 2,
        [236077] = 1,
        [236078] = 2,
        [236079] = 2,
        [236080] = 2,
        [236081] = 2,
        [236082] = 2,
        [236083] = 2,
        [236084] = 2,
        [236085] = 1,
        [236087] = 2,
        [236088] = 2,
        [236089] = 2,
        [236090] = 2,
        [236091] = 2,
        [236092] = 2,
        [236093] = 2,
        [236094] = 2,
        [236095] = 2,
        [236115] = 2,
        [236116] = 2,
        [236117] = 2,
        [236118] = 2,
        [236119] = 2,
        [236120] = 2,
        [236121] = 2,
        [236122] = 2,
        [236123] = 2,
        [236142] = 2,
        [236143] = 2,
        [236144] = 2,
        [236145] = 2,
        [236146] = 2,
        [236147] = 2,
        [236148] = 2,
        [236149] = 2,
        [236150] = 2,
        [236151] = 1,
        [236152] = 2,
        [236153] = 2,
        [236154] = 2,
        [236155] = 2,
        [236156] = 2,
        [236157] = 1,
        [236158] = 2,
        [236159] = 2,
        [236261] = 1,
        [236264] = 1,
        [236265] = 1,
        [236267] = 2,
        [236273] = 1,
        [236275] = 1,
        [236277] = 2,
        [236289] = 1,
        [236296] = 1,
        [236298] = 2,
        [236303] = 3,
        [236305] = 4,
        [236327] = 2,
        [236328] = 2,
        [236346] = 4,
        [236347] = 2,
        [236348] = 2,
        [236400] = 4,
        [236644] = 2,
        [236645] = 1,
        [240020] = 1,
        [240021] = 2,
        [240022] = 2,
        [240039] = 2,
        [240040] = 2,
        [240041] = 3,
        [240042] = 3,
        [240043] = 3,
        [240044] = 1,
        [240045] = 1,
        [240046] = 2,
        [240047] = 3,
        [240048] = 4,
        [240049] = 2,
        [240050] = 2,
        [240051] = 2,
        [240053] = 2,
        [240054] = 2,
        [240055] = 3,
        [240056] = 3,
        [240057] = 1,
        [240058] = 2,
        [240059] = 2,
        [240092] = 2,
        [240093] = 2,
        [240096] = 2,
        [240097] = 2,
        [240098] = 3,
        [240099] = 1,
        [240100] = 2,
        [240109] = 3,
        [240110] = 3,
        [240122] = 1,
        [240123] = 2,
        [240124] = 3,
        [240125] = 1,
        [240126] = 3,
        [240127] = 1,
        [240138] = 2,
        [240139] = 2,
        [240140] = 2,
        [240141] = 2,
        [240142] = 3,
        [240143] = 2,
        [240145] = 2,
        [241002] = 2,
        [241003] = 2,
        [241006] = 2,
        [241011] = 4,
        [241017] = 1,
        [241018] = 1,
        [241031] = 1,
        [241039] = 4,
        [241153] = 4,
        [241160] = 4,
        [241161] = 3,
        [241168] = 3,
        [241176] = 3,
        [241177] = 3,
        [241181] = 4,
        [241182] = 4,
        [241183] = 3,
        [242315] = 3,
        [242317] = 3,
    },
    TimewornSpellHaste = {
        [234016] = 2,
        [234020] = 2,
        [234024] = 2,
        [234028] = 2,
        [234032] = 2,
    },
}
Data.setNames = {
    AUGURS_REGALIA = "Augur's Regalia",
    BLOODSOUL_EMBRACE = "Bloodsoul Embrace",
    DAWN_OF_TRANSCENDENCE = "Dawn of Transcendence",
    FEL_IRON_CHAIN = "Fel Iron Chain",
    FREETHINKERS_ARMOR = "Freethinker's Armor",
    GREEN_DRAGON_MAIL = "Green Dragon Mail",
    HARUSPEXS_GARB = "Haruspex's Garb",
    LIVING_GREEN_DRAGON_MAIL = "Living Green Dragon Mail",
    PRIMAL_MOONCLOTH = "Primal Mooncloth",
    STORMRAGE_RAIMENT = "Stormrage Raiment",
    TEN_STORMS = "The Ten Storms",
    THE_EARTHSHATTERER = "The Earthshatterer",
    VESTMENTS_OF_TRANSCENDENCE = "Vestments of Transcendence",
    WINDHAWK_ARMOR = "Windhawk Armor",
}
Data.Talent = {
    -- keep-sorted start block=yes
    [Data.DEATHKNIGHT] = {
        -- keep-sorted start
        BLOOD_GORGED = {61274,61275,61276,61277,61278},
        VIRULENCE = {48962,49567,49568},
        -- keep-sorted end
    },
    [Data.DRUID] = {
        -- keep-sorted start
        BALANCE_OF_POWER = {33592,33596},
        INTENSITY_REFLECTION = {17106,17107,17108},
        NATURAL_PERFECTION = {33881,33882,33883},
        SURVIVAL_OF_THE_FITTEST = {33853,33855,33856},
        -- keep-sorted end
    },
    [Data.MAGE] = {
        -- keep-sorted start
        ARCANE_FOCUS = {11222,12839,12840,12841,12842},
        ARCANE_INSTABILITY = {15058,15059,15060},
        ARCANE_MEDITATION = {14521,18463,18464},
        CRITICAL_MASS = {11115,11367,11368},
        ELEMENTAL_PRECISION = {29438,29439,29440},
        PYROMANIAC = {34293,34295,34296},
        -- keep-sorted end
    },
    [Data.PALADIN] = {
        -- keep-sorted start
        CONVICTION = {20117,20118,20119,20120,20121},
        ENLIGHTENED_JUDGEMENTS = {53556,53557},
        HOLY_POWER = {5923,5924,5925,5926,25829},
        SANCTITY_OF_BATTLE = {32043,35396,35397},
        -- keep-sorted end
    },
    [Data.PRIEST] = {
        -- keep-sorted start
        HOLY_SPECIALIZATION = {14889,15008,15009,15010,15011},
        MEDITATION = {14521,14776,14777},
        SHADOW_FOCUS = {15260,15327,15328,15329,15330},
        SHADOW_RESILIENCE = {14910,33371},
        -- keep-sorted end
    },
    [Data.ROGUE] = {
        -- keep-sorted start
        PRECISION = {13705,13832,13843,13844,13845},
        SLEIGHT_OF_HAND = {30892,30893},
        -- keep-sorted end
    },
    [Data.SHAMAN] = {
        -- keep-sorted start
        ELEMENTAL_PRECISION = {30672,30673,30674},
        NATURES_GUIDANCE = {16180,16196,16198},
        THUNDERING_STRIKES = {16255,16302,16303,16304,16305},
        -- keep-sorted end
    },
    [Data.WARLOCK] = {
        -- keep-sorted start
        BACKLASH = {34935,34938,34939},
        DEMONIC_RESILIENCE = {30319,30320,30321},
        DEMONIC_TACTICS = {30242,30245,30246,30247,30248},
        DEVASTATION = {18130,18131,18132,18133,18134},
        SUPPRESSION = {18174,18175,18176},
        -- keep-sorted end
    },
    -- keep-sorted end
}
