---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

local strings = {}

function i18n:UseEnglish()
    i18n.texts = strings
end

strings = {
    -- Slash commands
    ["AVAILABLE_COMMANDS"] = "Available Commands",
    ["SLASH_TOGGLE"] = "/ecs toggle",
    ["SLASH_TOGGLE_DESC"] = "Toggles the visibility of the stats window",
    ["SLASH_CONFIG"] = "/ecs config",
    ["SLASH_CONFIG_DESC"] = "Shows the configuration window",

    ["NAME_VERSION"] = "ECS %s",

    ["SETTINGS"] = "Settings",
    ["STATS"] = "Stats",
    ["STATS_SETTINGS"] = "Stats Settings",
    ["GENERAL"] = "General",
    ["GENERAL_SETTINGS"] = "General Settings",
    ["SHOW_ITEM_QUALITY_COLORS"] = "Show Item Quaility Colors",
    ["SHOW_ITEM_QUALITY_COLORS_DESC"] = "Shows/Hides the colored frames around equiped items.",
    ["HEADER_FONT_SIZE"] = "Header Font Size",
    ["HEADER_FONT_SIZE_DESC"] = "Changes the font size of the headers (e.g. Melee)",
    ["STAT_FONT_SIZE"] = "Stat Font Size",
    ["STAT_FONT_SIZE_DESC"] = "Changes the font size of the stat lines (e.g. Crit)",
    ["WINDOW_WIDTH"] = "Window Width",
    ["WINDOW_WIDTH_DESC"] = "Changes the width of the stats window",
    ["SELECT_LANGUAGE"] = "Language",

    ["HIT"] = "Hit",
    ["MISS"] = "Miss: ",
    ["MISS_BOSS"] = "Miss (Lvl + 3): ",
    ["BONUS"] = "Bonus: ",
    ["ATTACK_POWER"] = "Attack Power: ",
    ["CRIT_CHANCE"] = "Crit Chance: ",

    ["MELEE"] = "Melee",
    ["RANGED"] = "Ranged",
    ["DEFENSE"] = "Defense",
    ["DEFENSE_VALUE"] = "Defense: ",
    ["ARMOR"] = "Armor: ",
    ["MANA"] = "Mana",

    ["BLOCK_CHANCE"] = "Block Chance: ",
    ["BLOCK_VALUE"] = "Block Value: ",
    ["PARRY_CHANCE"] = "Parry Chance: ",
    ["DODGE_CHANCE"] = "Dodge Chance: ",

    ["MP5_ITEMS"] = "MP5 (Items): ",
    ["MP5_SPIRIT"] = "MP5 (Spirit): ",
    ["MP5_CASTING"] = "MP5 (Casting): ",

    ["SPELL"] = "Spell",

    ["SPELL_POWER"] = "Spell Power",
    ["HEALING_POWER"] = "Healing Power: ",
    ["ARCANCE_DMG"] = "Arcane Damage: ",
    ["ARCANCE_CRIT"] = "Arcane Crit: ",
    ["FIRE_DMG"] = "Fire Damage: ",
    ["FIRE_CRIT"] = "Fire Crit: ",
    ["FROST_DMG"] = "Frost Damage: ",
    ["FROST_CRIT"] = "Frost Crit: ",
    ["HOLY_DMG"] = "Holy Damage: ",
    ["HOLY_CRIT"] = "Holy Crit: ",
    ["NATURE_DMG"] = "Nature Damage: ",
    ["NATURE_CRIT"] = "Nature Crit: ",
    ["PHYSICAL_DMG"] = "Physical Damage: ",
    ["PHYSICAL_CRIT"] = "Physical Crit: ",
    ["SHADOW_DMG"] = "Shadow Damage: ",
    ["SHADOW_CRIT"] = "Shadow Crit: ",
    
}
