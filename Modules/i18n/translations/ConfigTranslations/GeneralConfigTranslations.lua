---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

local generalConfigTranslations = {
    ["Show General Stats"] = {
        ["enUS"] = true,
        ["deDE"] = "Allgemeine Werte anzeigen",
        ["frFR"] = "Général",
        ["zhCN"] = "显示常规属性信息",
    },
    ["Shows/Hides all general stats."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die allgemeinen Werte.",
        ["frFR"] = "Affiche/cache toutes les statistiques générales.",
        ["zhCN"] = "显示/隐藏 所有常规属性信息。",
    },
    ["Show Movement Speed"] = {
        ["enUS"] = true,
        ["deDE"] = "Bewegungsgeschwindigkeit anzeigen",
        ["frFR"] = "Affiche la vitesse de déplacement",
        ["zhCN"] = "显示移动速度",
    },
    ["Shows/Hides the movement speed value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Bewegungsgeschwindigkeit.",
        ["frFR"] = "Affiche/Cache la vitesse de déplacement.",
        ["zhCN"] = "显示/隐藏 移动速度",
    },
}

for k, v in pairs(generalConfigTranslations) do
    i18n.translations[k] = v
end