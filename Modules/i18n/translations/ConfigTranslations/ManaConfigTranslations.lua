---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

local manaConfigTranslations = {
    ["Show Mana Stats"] = {
        ["enUS"] = true,
        ["deDE"] = "Manawerte anzeigen",
        ["frFR"] = "Mana Général",
        ["zhCN"] = "显示法力回复",
    },
    ["Shows/Hides all mana stats."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt alle Manawerte.",
        ["frFR"] = "Affiche/cache toutes les statistiques de mana.",
        ["zhCN"] = "显示/隐藏 所有法力回复",
    },

    ["Shows/Hides the MP5 value from items."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den MP5-Wert von Gegenständen.",
        ["frFR"] = "Affiche/cache la valeur MP5 des objets.",
        ["zhCN"] = "显示/隐藏 装备回蓝",
    },
    ["Shows/Hides the MP5 while casting value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den MP5-Wert während des Zauberwirkens.",
        ["frFR"] = "Affiche/cache la valeur MP5 pendant le lancer.",
        ["zhCN"] = "显示/隐藏 附魔回蓝",
    },
    ["Shows/Hides the MP5 value from spirit."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den MP5-Wert durch Willenskraft.",
        ["frFR"] = "Affiche/cache la valeur MP5 de l'esprit.",
        ["zhCN"] = "显示/隐藏 精神回蓝",
    },
    ["Shows/Hides the MP5 value from buffs."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den MP5-Wert Stärkungszauber.",
        ["frFR"] = "Affiche/cache la valeur MP5 de Amélioration.",
        ["zhCN"] = "显示/隐藏 增益回蓝",
    },
}

for k, v in pairs(manaConfigTranslations) do
    i18n.translations[k] = v
end