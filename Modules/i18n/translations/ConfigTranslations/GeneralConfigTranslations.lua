---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

local generalConfigTranslations = {
    ["Show General Stats"] = {
        ["enUS"] = true,
        ["deDE"] = "Allgemeine Werte anzeigen",
        ["frFR"] = "Général",
        ["zhCN"] = "显示常规属性信息",
        ["ruRU"] = "Основные характеристики",
        ["esES"] = "Mostrar estadísticas generales",
        ["esMX"] = "Mostrar estadísticas generales"
    },
    ["Shows/Hides all general stats."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die allgemeinen Werte.",
        ["frFR"] = "Affiche/cache toutes les statistiques générales.",
        ["zhCN"] = "显示/隐藏 所有常规属性信息。",
        ["ruRU"] = "Показать/скрыть все основные характеристики",
        ["esES"] = "Muestra/oculta todas estadísticas generales",
        ["esMX"] = "Muestra/oculta todas estadísticas generales"
    },
    ["Show Movement Speed"] = {
        ["enUS"] = true,
        ["deDE"] = "Bewegungsgeschwindigkeit anzeigen",
        ["frFR"] = "Affiche la vitesse de déplacement",
        ["zhCN"] = "显示移动速度",
        ["ruRU"] = "Скорость движения",
        ["esES"] = "Mostrar velocidad de carrera",
        ["esMX"] = "Mostrar velocidad de carrera"
    },
    ["Shows/Hides the movement speed value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Bewegungsgeschwindigkeit.",
        ["frFR"] = "Affiche/Cache la vitesse de déplacement.",
        ["zhCN"] = "显示/隐藏 移动速度",
        ["ruRU"] = "Показать/скрыть значение скорости движения",
        ["esES"] = "Muestra/oculta el valor de velocidad de carrera",
        ["esMX"] = "Muestra/oculta el valor de velocidad de carrera"
    },
}

for k, v in pairs(generalConfigTranslations) do
    i18n.translations[k] = v
end
