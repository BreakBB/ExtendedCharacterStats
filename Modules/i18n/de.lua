---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

local strings = {}

function i18n:UseGerman()
    i18n.texts = strings
end

strings = {
    -- Slash commands
    ["AVAILABLE_COMMANDS"] = "Verfügbare Befehle",
    ["SLASH_TOGGLE"] = "/ecs toggle",
    ["SLASH_TOGGLE_DESC"] = "Öffnet/Schließt das Attributefenster",
    ["SLASH_CONFIG"] = "/ecs config",
    ["SLASH_CONFIG_DESC"] = "Öffnet/Schließt das Einstellungsfenster",

    ["NAME_VERSION"] = "ECS %s",

    ["SETTINGS"] = "Einstellungen",
    ["STATS"] = "Werte",
    ["STATS_SETTINGS"] = "Werte Einstellungen",
    ["GENERAL"] = "Allgemein",
    ["GENERAL_SETTINGS"] = "Allgemeine Einstellungen",
    ["SHOW_ITEM_QUALITY_COLORS"] = "Zeige Item Qualitätsfarben",
    ["SHOW_ITEM_QUALITY_COLORS_DESC"] = "Zeigt/Versteckt die farbigen Ränder an ausgerüsteten Gegenständen.",
    ["HEADER_FONT_SIZE"] = "Überschriften Schriftgröße",
    ["HEADER_FONT_SIZE_DESC"] = "Ändert die Schriftgröße der Überschriften (z.B. Nahkampf)",
    ["STAT_FONT_SIZE"] = "Werte Schriftgröße",
    ["STAT_FONT_SIZE_DESC"] = "Ändert die Schriftgröße der Werte (z.B. Kritische Chance)",
    ["WINDOW_WIDTH"] = "Fensterbreite",
    ["WINDOW_WIDTH_DESC"] = "Ändert die Breite des Wertefensters",
    ["SELECT_LANGUAGE"] = "Sprache",

    ["HIT"] = "Trefferchance",
    ["MISS"] = "Verfehlen: ",
    ["MISS_BOSS"] = "Verfehlen (Lvl + 3): ",
    ["BONUS"] = "Bonus: ",
    ["ATTACK_POWER"] = "Angriffskraft: ",
    ["CRIT_CHANCE"] = "Kritische Chance: ",

    ["MELEE"] = "Nahkampf",
    ["RANGED"] = "Fernkampf",
    ["DEFENSE"] = "Verteidigung",
    ["DEFENSE_VALUE"] = "Verteidigung: ",
    ["ARMOR"] = "Rüstung: ",
    ["MANA"] = "Mana",

    ["BLOCK_CHANCE"] = "Blockchance: ",
    ["BLOCK_VALUE"] = "Blockwertung: ",
    ["PARRY_CHANCE"] = "Parrierchance: ",
    ["DODGE_CHANCE"] = "Ausweichchance: ",

    ["MP5_ITEMS"] = "MP5 (Gegenstände): ",
    ["MP5_SPIRIT"] = "MP5 (Willenskraft): ",
    ["MP5_CASTING"] = "MP5 (Zaubernd): ",

    ["SPELL"] = "Zauber",

    ["SPELL_POWER"] = "Zauberkraft",
    ["HEALING_POWER"] = "Heilungskraft: ",
    ["ARCANCE_DMG"] = "Arkanschaden: ",
    ["ARCANCE_CRIT"] = "Arkan Kritisch: ",
    ["FIRE_DMG"] = "Feuerschaden: ",
    ["FIRE_CRIT"] = "Feuer Kritisch: ",
    ["FROST_DMG"] = "Frostschaden: ",
    ["FROST_CRIT"] = "Frost Kritisch: ",
    ["HOLY_DMG"] = "Heiligschaden: ",
    ["HOLY_CRIT"] = "Heilig Kritisch: ",
    ["NATURE_DMG"] = "Naturschaden: ",
    ["NATURE_CRIT"] = "Natur Kritisch: ",
    ["PHYSICAL_DMG"] = "Physischer Schaden: ",
    ["PHYSICAL_CRIT"] = "Physisch Kritisch: ",
    ["SHADOW_DMG"] = "Schattenschaden: ",
    ["SHADOW_CRIT"] = "Schatten Kritisch: ",
    
}
