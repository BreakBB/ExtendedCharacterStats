---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

local configTranslations = {
    ["Settings"] = {
        ["enUS"] = true,
        ["deDE"] = "Einstellungen",
        ["frFR"] = "Paramètres",
        ["zhCN"] = "设置",
    },
    ["General"] = {
        ["enUS"] = true,
        ["deDE"] = "Allgemein",
        ["frFR"] = "Général",
        ["zhCN"] = "一般",
    },
    ["Stats"] = {
        ["enUS"] = true,
        ["deDE"] = "Werte",
        ["frFR"] = "Statistiques",
        ["zhCN"] = "统计信息",
    },
    ["General Settings"] = {
        ["enUS"] = true,
        ["deDE"] = "Allgemeine Einstellungen",
        ["frFR"] = "Paramètres généraux",
        ["zhCN"] = "一般设置",
    },
    ["Hide ECS when opening character tab"] = {
        ["enUS"] = true,
        ["deDE"] = "Verstecke das ECS Fenster beim Öffnen des Charakterfensters",
        ["frFR"] = "Cache ECS quand la fenêtre du personnage est ouverte",
        ["zhCN"] = "显示ECS切换按键",
    },
    ["Hides the stats windows when opening the character tab."] = {
        ["enUS"] = true,
        ["deDE"] = "Versteckt das Wertefenster beim Öffnen des Charakterfensters.",
        ["frFR"] = "Cache la fenêtre des statistiques quand la section du personnage est ouverte.",
        ["zhCN"] = "显示ECS打开/关闭按键",
    },
    ["Colorize Stats"] = {
        ["enUS"] = true,
        ["deDE"] = "Werte färben",
        ["frFR"] = "Coloriser les statistiques",
        ["zhCN"] = "染色统计信息",
    },
    ["Adds colors to the stats overview."] = {
        ["enUS"] = true,
        ["deDE"] = "Fügt dem Wertefenster Farben hinzu.",
        ["frFR"] = "Ajoute des couleurs dans l'aperçu des statistiques.",
        ["zhCN"] = "添加颜色的统计概览。",
    },
    ["Stats colorization"] = {
        ["enUS"] = true,
        ["deDE"] = "Werte Farbe",
        ["frFR"] = "Couleurs des statistiques",
        ["zhCN"] = "统计信息染色",
    },
    ["Full"] = {
        ["enUS"] = true,
        ["deDE"] = "Komplett",
        ["frFR"] = "Toutes",
        ["zhCN"] = "全部",
    },
    ["Stat texts"] = {
        ["enUS"] = true,
        ["deDE"] = "Wertenamen",
        ["frFR"] = "Textes des statistiques",
        ["zhCN"] = "统计文本染色",
    },
    ["Stat values"] = {
        ["enUS"] = true,
        ["deDE"] = "Wertezahlen",
        ["frFR"] = "Valeurs des statistiques",
        ["zhCN"] = "属性染色",
    },
    ["Show Item Quality Colors"] = {
        ["enUS"] = true,
        ["deDE"] = "Zeige Item Qualitätsfarben",
        ["frFR"] = "Affiche la couleur de rareté des objets",
        ["zhCN"] = "显示物品等级颜色",
    },
    ["Shows/Hides the colored frames around equipped items."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die farbigen Ränder an ausgerüsteten Gegenständen.",
        ["frFR"] = "Affiche/cache le niveau de rareté des objets par un cadre coloré.",
        ["zhCN"] = "显示/隐藏 装备边框染色 。",
    },
    ["Header Font Size"] = {
        ["enUS"] = true,
        ["deDE"] = "Überschriften Schriftgröße",
        ["frFR"] = "Taille de la police d'entête",
        ["zhCN"] = "标题字体大小",
    },
    ["Changes the font size of the headers (e.g. Melee)"] = {
        ["enUS"] = true,
        ["deDE"] = "Ändert die Schriftgröße der Überschriften (z.B. Nahkampf)",
        ["frFR"] = "Modifie la taille de la police d'entête (ex. Mêlée)",
        ["zhCN"] = "更改标题的字体大小 (例如：近战)",
    },
    ["Stat Font Size"] = {
        ["enUS"] = true,
        ["deDE"] = "Werte Schriftgröße",
        ["frFR"] = "Taille de la police des statistiques",
        ["zhCN"] = "统计字体大小",
    },
    ["Changes the font size of the stat lines (e.g. Crit)"] = {
        ["enUS"] = true,
        ["deDE"] = "Ändert die Schriftgröße der Werte (z.B. Kritische Chance)",
        ["frFR"] = "Modifie la taille de la police des statistiques (ex. Critique)",
        ["zhCN"] = "更改统计行的字体大小 (例如：暴击)",
    },
    ["Window Width"] = {
        ["enUS"] = true,
        ["deDE"] = "Fensterbreite",
        ["frFR"] = "Largeur de fenêtre",
        ["zhCN"] = "窗口宽度",
    },
    ["Changes the width of the stats window"] = {
        ["enUS"] = true,
        ["deDE"] = "Ändert die Breite des Wertefensters",
        ["frFR"] = "Modifie la largeur de la fenêtre des statistiques",
        ["zhCN"] = "更改统计窗口的宽度",
    },
    ["Language"] = {
        ["enUS"] = true,
        ["deDE"] = "Sprache",
        ["frFR"] = "Langue",
        ["zhCN"] = "语言",
    },
    ["Stats Settings"] = {
        ["enUS"] = true,
        ["deDE"] = "Werte Einstellungen",
        ["frFR"] = "Paramètres des statistiques",
        ["zhCN"] = "统计信息设置",
    },
    ["Reset ECS"] = {
        ["enUS"] = true,
        ["deDE"] = "ECS zurücksetzen",
        ["frFR"] = false,
        ["zhCN"] = false,
    },
    ["Restores all default values of ECS."] = {
        ["enUS"] = true,
        ["deDE"] = "Stellt alle Standardwerte von ECS wieder her.",
        ["frFR"] = false,
        ["zhCN"] = false,
    },
}

for k, v in pairs(configTranslations) do
    i18n.translations[k] = v
end
